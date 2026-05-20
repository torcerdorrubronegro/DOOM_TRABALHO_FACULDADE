"""
runtime/renderer_raycast.py
Renderer pseudo-3D em ASCII no estilo dos FPS antigos (Wolfenstein,
Doom classico). Implementacao de RAYCASTING 2.5D, nao raytracing
real: lanca um raio por coluna a partir do jogador, avanca celula
por celula no mapa ate bater em parede ou estourar a distancia
maxima, projeta a altura da parede pela distancia (corrigida para
evitar olho-de-peixe) e desenha colunas de chao/parede/teto.

Os dados de cores e tamanhos vem do GameState (que por sua vez vem
dos arquivos .algpp). O Python so executa o algoritmo.
"""

import math

from runtime import terminal
from runtime.colors import paint


_LINHAS_HUD_TOPO = 3
_LINHAS_HUD_RODAPE = 4


def _vazio(largura):
    return [(' ', None) for _ in range(largura)]


def _dentro_do_mapa(fase, cx, cy):
    if fase is None or not fase.mapa:
        return False
    if cy < 1 or cy > len(fase.mapa):
        return False
    if cx < 1 or cx > len(fase.mapa[cy - 1]):
        return False
    return True


def _eh_parede(fase, cx, cy):
    if not _dentro_do_mapa(fase, cx, cy):
        return True
    return fase.mapa[cy - 1][cx - 1] == "#"


def _lancar_raio(fase, ox, oy, angulo_rad, distancia_max):
    """Avanca o raio em passos pequenos ate bater em parede ou
    estourar a distancia maxima. Retorna (distancia, bateu_parede)."""
    dx = math.cos(angulo_rad)
    dy = math.sin(angulo_rad)
    passo = 0.05
    dist = 0.0
    x = ox
    y = oy
    while dist < distancia_max:
        x += dx * passo
        y += dy * passo
        dist += passo
        cx = int(round(x))
        cy = int(round(y))
        if _eh_parede(fase, cx, cy):
            return dist, True
    return distancia_max, False


def _char_parede(dist, dist_max):
    """Escolhe um caractere conforme a distancia."""
    proporcao = dist / max(0.1, dist_max)
    if proporcao < 0.2:
        return "#"
    if proporcao < 0.35:
        return "@"
    if proporcao < 0.5:
        return "%"
    if proporcao < 0.65:
        return "*"
    if proporcao < 0.8:
        return "+"
    if proporcao < 0.9:
        return "="
    return ":"


def _char_teto(prop_altura):
    if prop_altura < 0.3:
        return " "
    if prop_altura < 0.6:
        return "."
    return "'"


def _char_chao(prop_altura):
    if prop_altura < 0.3:
        return " "
    if prop_altura < 0.6:
        return "."
    return "_"


def _altura_coluna(dist_corrigida, altura_cena):
    """Quanto maior a distancia, menor a parede."""
    if dist_corrigida <= 0.1:
        return altura_cena
    h = int(altura_cena / max(0.5, dist_corrigida))
    if h < 1:
        h = 1
    if h > altura_cena:
        h = altura_cena
    return h


def _normalizar_angulo(g):
    g = g % 360.0
    if g > 180.0:
        g -= 360.0
    return g


def _coletar_entidades(st):
    """Lista de tuplas para projecao no raycast.

    Cada item: (x, y, letra, cor, prioridade,
                codigo_inimigo, codigo_boss, eh_item).

    Inclui itens do mapa (K/A/C/W/X), inimigos vivos e boss vivo.
    A prioridade so eh usada para desempate visual quando houver
    coincidencia (boss > inimigo > item). Os codigos sao usados
    para localizar o sprite correspondente em st.sprites."""
    fase = st.fase_atual
    if fase is None or not fase.mapa:
        return []
    saida = []
    cores = st.cores
    for y, linha in enumerate(fase.mapa):
        for x, ch in enumerate(linha):
            if ch == "X":
                saida.append((x + 1, y + 1, "X",
                              cores.get("saida", "azul"),
                              0, None, None, True))
            elif ch == "K":
                saida.append((x + 1, y + 1, "K",
                              cores.get("item", "amarelo"),
                              0, None, None, True))
            elif ch == "A":
                saida.append((x + 1, y + 1, "A",
                              cores.get("item", "amarelo"),
                              0, None, None, True))
            elif ch == "C":
                saida.append((x + 1, y + 1, "C",
                              cores.get("chave", "amarelo"),
                              0, None, None, True))
            elif ch == "W":
                saida.append((x + 1, y + 1, "W",
                              cores.get("arma", "ciano"),
                              0, None, None, True))
    for ini in fase.inimigos_instancia:
        if ini.vivo:
            saida.append((ini.x, ini.y, ini.letra, ini.cor,
                          1, ini.codigo, None, False))
    bi = fase.boss_instancia
    if bi is not None and bi.vivo:
        saida.append((bi.x, bi.y, bi.letra, bi.cor,
                      2, None, bi.codigo, False))
    return saida


def _sprite_para_entidade(st, codigo_letra):
    """Retorna o sprite associado a uma entidade pelo seu codigo
    canonico, se existir. Caso contrario None."""
    if not codigo_letra:
        return None
    return st.sprites.get(codigo_letra)


def _codigo_sprite_da_entidade(letra, codigo_inimigo,
                                codigo_boss, eh_item):
    """Decide qual sprite buscar em st.sprites para uma entidade."""
    if codigo_boss:
        return "boss_" + codigo_boss
    if codigo_inimigo:
        return "inimigo_" + codigo_inimigo
    if eh_item:
        if letra == "K":
            return "item_kit"
        if letra == "A":
            return "item_ammo"
        if letra == "C":
            return "item_chave"
        if letra == "W":
            return "item_arma"
        if letra == "X":
            return "saida"
    return None


def _desenhar_sprite_em(buf, sprite, cor, col_centro, lin_centro,
                          larg_alvo, alt_alvo, largura, altura,
                          depth, dist_corr):
    """Pinta o sprite escalado por nearest-neighbor, respeitando o
    depth buffer e o limite da tela. Espacos sao transparentes."""
    linhas_sprite = sprite.linhas
    if not linhas_sprite:
        return
    h_orig = len(linhas_sprite)
    w_orig = max((len(l) for l in linhas_sprite), default=0)
    if w_orig == 0 or h_orig == 0:
        return
    col_ini = col_centro - larg_alvo // 2
    lin_ini = lin_centro - alt_alvo // 2
    for ry in range(alt_alvo):
        target_y = lin_ini + ry
        if target_y < 0 or target_y >= altura:
            continue
        sy = int(ry * h_orig / max(1, alt_alvo))
        if sy >= h_orig:
            sy = h_orig - 1
        linha_src = linhas_sprite[sy]
        for rx in range(larg_alvo):
            target_x = col_ini + rx
            if target_x < 0 or target_x >= largura:
                continue
            sx = int(rx * w_orig / max(1, larg_alvo))
            if sx >= len(linha_src):
                continue
            ch = linha_src[sx]
            if ch == " ":
                continue
            if (depth[target_x] is not None
                    and dist_corr >= depth[target_x]):
                continue
            buf[target_y][target_x] = (ch, cor)


def _projetar_entidades(st, buf, depth, cena_y_min, cena_y_max,
                         fov_rad, largura, distancia_max):
    cena_altura = cena_y_max - cena_y_min
    angulo_jog_rad = math.radians(st.jogador.angulo)
    entidades = _coletar_entidades(st)
    visiveis = []
    for ent in entidades:
        ex, ey, letra, cor, prio, codigo_ini, codigo_boss, eh_item = ent
        dx = ex - st.jogador.x
        dy = ey - st.jogador.y
        dist = math.hypot(dx, dy)
        if dist < 0.1 or dist > distancia_max:
            continue
        ang_ent = math.atan2(dy, dx)
        delta = ang_ent - angulo_jog_rad
        while delta > math.pi:
            delta -= 2 * math.pi
        while delta < -math.pi:
            delta += 2 * math.pi
        if abs(delta) > fov_rad / 2:
            continue
        dist_corr = dist * math.cos(delta)
        if dist_corr <= 0.1:
            continue
        col_centro = int((delta + fov_rad / 2) / fov_rad * (largura - 1))
        altura_sprite = _altura_coluna(dist_corr, cena_altura)
        largura_sprite = max(1, int(altura_sprite * 0.9))
        visiveis.append((dist_corr, col_centro, altura_sprite,
                         largura_sprite, letra, cor, prio,
                         codigo_ini, codigo_boss, eh_item))
    visiveis.sort(key=lambda v: -v[0])
    for (dist_corr, col_centro, alt_sp, larg_sp,
         letra, cor, _, cod_ini, cod_boss, eh_item) in visiveis:
        topo = cena_y_min + (cena_altura - alt_sp) // 2
        base = topo + alt_sp
        lin_centro = (topo + base) // 2
        codigo_sprite = _codigo_sprite_da_entidade(
            letra, cod_ini, cod_boss, eh_item
        )
        sprite = _sprite_para_entidade(st, codigo_sprite)
        if sprite is not None and alt_sp >= 3:
            _desenhar_sprite_em(
                buf, sprite, cor, col_centro, lin_centro,
                larg_sp, alt_sp, largura,
                cena_y_max, depth, dist_corr,
            )
            continue
        col_ini = col_centro - larg_sp // 2
        col_fim = col_centro + (larg_sp - larg_sp // 2)
        for c in range(col_ini, col_fim):
            if c < 0 or c >= largura:
                continue
            if depth[c] is not None and dist_corr >= depth[c]:
                continue
            for y in range(topo, base):
                if cena_y_min <= y < cena_y_max:
                    buf[y][c] = (letra, cor)


def _desenhar_arma_jogador(st, buf, largura, altura, cena_y_max):
    """Desenha o sprite da arma equipada no centro inferior da
    cena, sobre o chao. Se nao houver sprite, deixa o espaco vazio."""
    if cena_y_max <= 1:
        return
    codigo = st.jogador.arma
    sprite = st.sprites.get("arma_" + (codigo or ""))
    if sprite is None or not sprite.linhas:
        return
    h_orig = len(sprite.linhas)
    w_orig = max((len(l) for l in sprite.linhas), default=0)
    if w_orig == 0 or h_orig == 0:
        return
    espaco_max = cena_y_max - 1
    alt_alvo = min(h_orig, max(3, espaco_max // 2))
    larg_alvo = min(w_orig, max(8, largura // 3))
    col_centro = largura // 2
    lin_topo = cena_y_max - alt_alvo
    col_ini = col_centro - larg_alvo // 2
    for ry in range(alt_alvo):
        target_y = lin_topo + ry
        if target_y < 0 or target_y >= altura:
            continue
        sy = int(ry * h_orig / max(1, alt_alvo))
        if sy >= h_orig:
            sy = h_orig - 1
        linha_src = sprite.linhas[sy]
        for rx in range(larg_alvo):
            target_x = col_ini + rx
            if target_x < 0 or target_x >= largura:
                continue
            sx = int(rx * w_orig / max(1, larg_alvo))
            if sx >= len(linha_src):
                continue
            ch = linha_src[sx]
            if ch == " ":
                continue
            buf[target_y][target_x] = (ch, sprite.cor)


def _desenhar_minimapa(st, buf, largura, altura):
    if not st.mostrar_minimapa:
        return
    fase = st.fase_atual
    if fase is None or not fase.mapa:
        return
    mapa_largura = max(len(linha) for linha in fase.mapa)
    mapa_altura = len(fase.mapa)
    if mapa_largura == 0 or mapa_altura == 0:
        return
    minx0 = largura - mapa_largura - 2
    miny0 = _LINHAS_HUD_TOPO
    if minx0 < 0:
        return
    cores = st.cores
    sobre = {}
    for ini in fase.inimigos_instancia:
        if ini.vivo:
            sobre[(ini.x, ini.y)] = (ini.letra, ini.cor)
    bi = fase.boss_instancia
    if bi is not None and bi.vivo:
        sobre[(bi.x, bi.y)] = (bi.letra, bi.cor)
    seta = _seta_direcao(st.jogador.direcao)
    cor_jog = cores.get("jogador", "verde")
    cor_par = cores.get("parede", "cinza")
    cor_sai = cores.get("saida", "azul")
    cor_chao = cores.get("chao", "preto")
    cor_item = cores.get("item", "amarelo")
    pj_x = st.jogador.cell_x()
    pj_y = st.jogador.cell_y()
    for ry in range(mapa_altura):
        sy = miny0 + ry
        if sy >= altura:
            break
        for rx in range(mapa_largura):
            sx = minx0 + rx
            if sx >= largura:
                break
            celx = rx + 1
            cely = ry + 1
            if (celx, cely) == (pj_x, pj_y):
                buf[sy][sx] = (seta, cor_jog)
                continue
            if (celx, cely) in sobre:
                letra, cor = sobre[(celx, cely)]
                buf[sy][sx] = (letra, cor)
                continue
            ch = fase.mapa[ry][rx]
            if ch == "#":
                buf[sy][sx] = ("#", cor_par)
            elif ch == "X":
                buf[sy][sx] = ("X", cor_sai)
            elif ch in ("K", "A", "C", "W"):
                buf[sy][sx] = (ch, cor_item)
            else:
                buf[sy][sx] = (".", cor_chao)


def _seta_direcao(direcao):
    return {
        "norte": "^",
        "leste": ">",
        "sul":   "v",
        "oeste": "<",
    }.get(direcao, "@")


def _barra(atual, maximo, largura=10, simbolo="#"):
    if maximo <= 0:
        cheio = 0
    else:
        cheio = (atual * largura) // maximo
        if cheio < 0:
            cheio = 0
        if cheio > largura:
            cheio = largura
    return "[" + (simbolo * cheio) + ("." * (largura - cheio)) + "]"


def _escrever_em_buffer(buf, linha, coluna, texto, cor):
    largura = len(buf[0]) if buf else 0
    for i, ch in enumerate(texto):
        c = coluna + i
        if 0 <= c < largura and 0 <= linha < len(buf):
            buf[linha][c] = (ch, cor)


def _desenhar_hud(st, buf, largura, altura):
    cores = st.cores
    cor_hud = cores.get("hud", "branco")
    cor_dano = cores.get("inimigo", "vermelho")
    cor_jog = cores.get("jogador", "verde")
    cor_boss = cores.get("boss", "magenta")
    _escrever_em_buffer(buf, 0, 0, st.titulo, cor_hud)
    arma = st.arma_atual()
    ammo = st.ammo_arma()
    ammo_max = st.ammo_max_arma()
    nome_arma = arma.nome if arma else "-"
    dano = arma.dano if arma else 0
    chave = "SIM" if st.jogador.tem_chave else "NAO"
    barra_vida = _barra(st.jogador.vida, st.jogador.vida_max, 10)
    barra_ammo = _barra(ammo, ammo_max, 10, "*")
    fase_nome = st.fase_atual.nome if st.fase_atual else "-"
    linha_hud = "VIDA {} {}/{}  ARMA {} {} {}/{}  DANO {}  CHAVE {}  FASE {}".format(
        barra_vida, st.jogador.vida, st.jogador.vida_max,
        nome_arma, barra_ammo, ammo, ammo_max, dano, chave, fase_nome,
    )
    _escrever_em_buffer(buf, 1, 0, linha_hud, cor_hud)
    bi = st.fase_atual.boss_instancia if st.fase_atual else None
    if bi is not None and bi.vivo:
        barra = _barra(bi.vida, bi.vida_max, 14, "#")
        texto = "{} {} {}/{}".format(bi.nome, barra, bi.vida, bi.vida_max)
        _escrever_em_buffer(buf, 2, 0, texto, cor_boss)
    elif bi is not None and not bi.vivo:
        _escrever_em_buffer(buf, 2, 0, bi.nome + " DERROTADO", cor_boss)
    objetivo = "OBJETIVO: " + (st.status or "")
    _escrever_em_buffer(buf, altura - 4, 0, objetivo, cor_hud)
    if st.fase_atual is not None:
        info = "Inimigos restantes: {}   Saida: {}".format(
            st.inimigos_vivos(),
            "LIBERADA" if st.saida_liberada() else "BLOQUEADA",
        )
        _escrever_em_buffer(buf, altura - 3, 0, info, cor_hud)
    if st.derrota:
        _escrever_em_buffer(buf, altura - 2, 0,
                            "VOCE PERDEU", cor_dano)
    elif st.vitoria_final:
        _escrever_em_buffer(buf, altura - 2, 0,
                            "VOCE VENCEU A CAMPANHA", cor_jog)
    elif (st.fase_atual is not None
          and st.fase_atual.concluida):
        if st.tem_proxima_fase():
            prox = st.proxima_fase()
            _escrever_em_buffer(
                buf, altura - 2, 0,
                "Fase concluida. Proxima: " + prox.nome, cor_jog,
            )
        else:
            _escrever_em_buffer(buf, altura - 2, 0,
                                "Fase concluida", cor_jog)
    elif st.vitoria:
        _escrever_em_buffer(buf, altura - 2, 0, "VOCE VENCEU", cor_jog)
    elif st.jogador.dano_recente > 0:
        _escrever_em_buffer(
            buf, altura - 2, 0,
            "DANO RECEBIDO -" + str(st.jogador.dano_recente), cor_dano,
        )
    else:
        _escrever_em_buffer(buf, altura - 2, 0, st.mensagem, cor_hud)
    rodape = ("W avanca  S recua  A esq  D dir  F atira  "
              "R rec  Z/X arma  Q sair")
    _escrever_em_buffer(buf, altura - 1, 0, rodape, cor_hud)


def desenhar(st):
    """Funcao principal do renderer raycast. Constroi um buffer
    [altura][largura] = (char, cor) e descarrega no terminal."""
    terminal.home()
    largura = st.largura_tela
    altura = st.altura_tela
    buf = [[(' ', None) for _ in range(largura)] for _ in range(altura)]
    cena_y_min = _LINHAS_HUD_TOPO
    cena_y_max = altura - _LINHAS_HUD_RODAPE
    cena_altura = cena_y_max - cena_y_min
    fov_rad = math.radians(st.fov)
    distancia_max = max(2.0, float(st.distancia_visao))
    cor_parede = st.cor_de("parede")
    cor_teto = st.cor_de("teto")
    cor_chao = st.cor_de("chao")
    depth = [None] * largura
    angulo_jog = math.radians(st.jogador.angulo)
    if largura <= 0 or cena_altura <= 0:
        terminal.escrever("\033[J\n")
        terminal.descarregar()
        return
    for col in range(largura):
        prop = col / max(1, largura - 1)
        angulo_raio = angulo_jog - fov_rad / 2 + prop * fov_rad
        dist, bateu = _lancar_raio(
            st.fase_atual, st.jogador.x, st.jogador.y,
            angulo_raio, distancia_max,
        )
        dist_corr = dist * math.cos(angulo_raio - angulo_jog)
        if dist_corr < 0.1:
            dist_corr = 0.1
        depth[col] = dist_corr
        altura_parede = _altura_coluna(dist_corr, cena_altura)
        topo = cena_y_min + (cena_altura - altura_parede) // 2
        base = topo + altura_parede
        char_parede = _char_parede(dist_corr, distancia_max) if bateu else " "
        for y in range(cena_y_min, topo):
            prop_y = (topo - y) / max(1, (topo - cena_y_min))
            buf[y][col] = (_char_teto(prop_y), cor_teto)
        for y in range(topo, base):
            buf[y][col] = (char_parede, cor_parede)
        for y in range(base, cena_y_max):
            prop_y = (y - base) / max(1, (cena_y_max - base))
            buf[y][col] = (_char_chao(prop_y), cor_chao)
    _projetar_entidades(st, buf, depth, cena_y_min, cena_y_max,
                         fov_rad, largura, distancia_max)
    _desenhar_arma_jogador(st, buf, largura, altura, cena_y_max)
    _desenhar_minimapa(st, buf, largura, altura)
    _desenhar_hud(st, buf, largura, altura)
    saida_linhas = []
    for linha in buf:
        partes = []
        for ch, cor in linha:
            if cor is None:
                partes.append(ch)
            else:
                partes.append(paint(ch, cor))
        saida_linhas.append("".join(partes) + "\033[K")
    terminal.escrever("\n".join(saida_linhas) + "\033[J\n")
    terminal.descarregar()

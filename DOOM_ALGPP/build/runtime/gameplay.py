"""
runtime/gameplay.py
Operacoes de domino do jogo: andar, atirar, recarregar, trocar de
arma e coletar itens. Esses metodos modificam o GameState e
respeitam os dados declarados nos arquivos .algpp (armas, inimigos,
bosses, fases).

main.py so chama estas funcoes a partir das teclas pressionadas.

No modo "mapa" (renderer 2D), W/A/S/D movem o jogador em quatro
direcoes cardinais.

No modo "raycast", W/S avancam ou recuam na direcao em que o
jogador esta olhando, e A/D giram o angulo do jogador. As
funcoes andar_raycast(), virar_esq() e virar_dir() implementam
esse comportamento.
"""

import math


_DELTAS = {
    "norte": (0, -1),
    "sul":   (0, 1),
    "leste": (1, 0),
    "oeste": (-1, 0),
}

_TECLA_PARA_DIR = {
    "w": "norte",
    "s": "sul",
    "a": "oeste",
    "d": "leste",
}


def _delta_da_direcao(direcao):
    return _DELTAS.get(direcao, (0, 0))


def _delta_do_angulo(angulo_graus):
    """Vetor (dx, dy) unitario para um angulo em graus."""
    a = math.radians(angulo_graus)
    return (math.cos(a), math.sin(a))


def _dentro_do_mapa(fase, x, y):
    if fase is None or not fase.mapa:
        return False
    if y < 1 or y > len(fase.mapa):
        return False
    linha = fase.mapa[y - 1]
    if x < 1 or x > len(linha):
        return False
    return True


def _celula(fase, x, y):
    return fase.mapa[y - 1][x - 1]


def _set_celula(fase, x, y, ch):
    fase.mapa[y - 1][x - 1] = ch


def _coletar_item(st, ch, x, y):
    """Aplica o efeito do item naquela celula. Retorna o nome curto."""
    fase = st.fase_atual
    if ch == "K":
        ganho = max(1, st.jogador.vida_max // 4)
        st.jogador.vida = min(
            st.jogador.vida_max, st.jogador.vida + ganho
        )
        _set_celula(fase, x, y, ".")
        st.mensagem = "Kit coletado"
        return "kit"
    if ch == "A":
        arma = st.arma_atual()
        if arma is not None:
            cap = arma.municao_max
            ganho = max(1, cap // 2)
            atual = st.jogador.ammo.get(arma.codigo, 0)
            st.jogador.ammo[arma.codigo] = min(cap, atual + ganho)
        _set_celula(fase, x, y, ".")
        st.mensagem = "Municao coletada"
        return "ammo"
    if ch == "C":
        st.jogador.tem_chave = True
        _set_celula(fase, x, y, ".")
        st.mensagem = "Chave coletada"
        return "chave"
    if ch == "W":
        _set_celula(fase, x, y, ".")
        _liberar_proxima_arma(st)
        return "arma"
    return None


def _liberar_proxima_arma(st):
    """Libera a proxima arma da ordem padrao ainda nao desbloqueada
    e ja enche a municao dela."""
    ordem = ["pistola", "shotgun", "rifle", "cannon"]
    for codigo in ordem:
        if codigo in st.armas and codigo not in st.jogador.arsenal:
            st.jogador.arsenal.add(codigo)
            arma = st.armas[codigo]
            st.jogador.ammo[codigo] = arma.municao_max
            st.mensagem = "Arma coletada: " + arma.nome
            return
    st.mensagem = "Municao extra"


def andar(st, tecla):
    """Movimenta o jogador na direcao indicada pela tecla W/A/S/D
    (modo 2D). Retorna True se houve alguma acao."""
    fase = st.fase_atual
    if fase is None:
        return False
    direcao = _TECLA_PARA_DIR.get(tecla.lower())
    if direcao is None:
        return False
    st.jogador.aplicar_direcao(direcao)
    dx, dy = _delta_da_direcao(direcao)
    nx = int(round(st.jogador.x)) + dx
    ny = int(round(st.jogador.y)) + dy
    if not _dentro_do_mapa(fase, nx, ny):
        st.mensagem = "Limite do mapa"
        return True
    ch = _celula(fase, nx, ny)
    if ch == "#":
        st.mensagem = "Parede"
        return True
    if st.inimigo_em(nx, ny) is not None:
        st.mensagem = "Inimigo na frente"
        return True
    if st.boss_em(nx, ny) is not None:
        st.mensagem = "Boss bloqueando"
        return True
    st.jogador.x = float(nx)
    st.jogador.y = float(ny)
    if ch == "X":
        if st.saida_liberada():
            st.mensagem = "Saida alcancada"
            fase.concluida = True
        else:
            st.mensagem = "Saida bloqueada"
        return True
    coletou = _coletar_item(st, ch, nx, ny)
    if coletou is None:
        st.mensagem = "Andou para " + direcao
    return True


def andar_raycast(st, tecla):
    """Movimenta o jogador para frente/tras na direcao do angulo
    atual (modo raycast)."""
    fase = st.fase_atual
    if fase is None:
        return False
    t = tecla.lower()
    if t == "w":
        sentido = 1.0
    elif t == "s":
        sentido = -1.0
    else:
        return False
    passo = max(0.1, st.passo_movimento)
    dxu, dyu = _delta_do_angulo(st.jogador.angulo)
    nx = st.jogador.x + dxu * passo * sentido
    ny = st.jogador.y + dyu * passo * sentido
    cell_x = int(round(nx))
    cell_y = int(round(ny))
    if not _dentro_do_mapa(fase, cell_x, cell_y):
        st.mensagem = "Limite do mapa"
        return True
    ch = _celula(fase, cell_x, cell_y)
    if ch == "#":
        st.mensagem = "Parede"
        return True
    if st.inimigo_em(cell_x, cell_y) is not None:
        st.mensagem = "Inimigo na frente"
        return True
    if st.boss_em(cell_x, cell_y) is not None:
        st.mensagem = "Boss bloqueando"
        return True
    cell_x_ant = st.jogador.cell_x()
    cell_y_ant = st.jogador.cell_y()
    st.jogador.x = nx
    st.jogador.y = ny
    if (cell_x, cell_y) == (cell_x_ant, cell_y_ant):
        st.mensagem = "Andou para " + st.jogador.direcao
        return True
    if ch == "X":
        if st.saida_liberada():
            st.mensagem = "Saida alcancada"
            fase.concluida = True
        else:
            st.mensagem = "Saida bloqueada"
        return True
    coletou = _coletar_item(st, ch, cell_x, cell_y)
    if coletou is None:
        st.mensagem = "Andou para " + st.jogador.direcao
    return True


def virar_esq(st):
    """Gira o angulo do jogador para a esquerda (modo raycast)."""
    passo = st.passo_rotacao
    novo = (st.jogador.angulo - passo) % 360.0
    st.jogador.aplicar_angulo(novo)
    st.mensagem = "Olhando para " + st.jogador.direcao
    return True


def virar_dir(st):
    """Gira o angulo do jogador para a direita (modo raycast)."""
    passo = st.passo_rotacao
    novo = (st.jogador.angulo + passo) % 360.0
    st.jogador.aplicar_angulo(novo)
    st.mensagem = "Olhando para " + st.jogador.direcao
    return True


def _aplicar_dano_tiro_alvo(st, arma, alvo, eh_boss):
    """Helper compartilhado para aplicar dano em uma instancia."""
    alvo.vida -= arma.dano
    if alvo.vida <= 0:
        alvo.vivo = False
        if eh_boss:
            st.mensagem = alvo.nome + " derrotado"
            tipo_b = st.bosses.get(alvo.codigo)
            if tipo_b is not None and tipo_b.bloqueia_saida:
                st.vitoria = True
        else:
            st.mensagem = "Inimigo derrotado"
    else:
        if eh_boss:
            st.mensagem = "Boss atingido"
        else:
            st.mensagem = "Inimigo atingido"


def _atirar_cardinal(st, arma):
    """Tiro em uma das quatro direcoes cardinais (modo 2D)."""
    fase = st.fase_atual
    dx, dy = _delta_da_direcao(st.jogador.direcao)
    px = int(round(st.jogador.x))
    py = int(round(st.jogador.y))
    alcance = max(1, arma.alcance)
    st.mensagem = "Tiro"
    for passo_idx in range(1, alcance + 1):
        tx = px + dx * passo_idx
        ty = py + dy * passo_idx
        if not _dentro_do_mapa(fase, tx, ty):
            return
        if _celula(fase, tx, ty) == "#":
            return
        boss = st.boss_em(tx, ty)
        if boss is not None:
            _aplicar_dano_tiro_alvo(st, arma, boss, eh_boss=True)
            return
        ini = st.inimigo_em(tx, ty)
        if ini is not None:
            _aplicar_dano_tiro_alvo(st, arma, ini, eh_boss=False)
            return


def _atirar_raycast(st, arma):
    """Tiro continuo na direcao do angulo (modo raycast)."""
    fase = st.fase_atual
    dxu, dyu = _delta_do_angulo(st.jogador.angulo)
    alcance = max(1, arma.alcance)
    passo = 0.1
    x = st.jogador.x
    y = st.jogador.y
    dist = 0.0
    cell_anterior = (st.jogador.cell_x(), st.jogador.cell_y())
    st.mensagem = "Tiro"
    while dist < alcance:
        x += dxu * passo
        y += dyu * passo
        dist += passo
        cx = int(round(x))
        cy = int(round(y))
        if (cx, cy) == cell_anterior:
            continue
        cell_anterior = (cx, cy)
        if not _dentro_do_mapa(fase, cx, cy):
            return
        if _celula(fase, cx, cy) == "#":
            return
        boss = st.boss_em(cx, cy)
        if boss is not None:
            _aplicar_dano_tiro_alvo(st, arma, boss, eh_boss=True)
            return
        ini = st.inimigo_em(cx, cy)
        if ini is not None:
            _aplicar_dano_tiro_alvo(st, arma, ini, eh_boss=False)
            return


def atirar(st):
    """Dispara a arma equipada. Em modo raycast usa o angulo,
    em modo 2D usa a direcao cardinal."""
    fase = st.fase_atual
    if fase is None:
        return False
    arma = st.arma_atual()
    if arma is None:
        st.mensagem = "Sem arma equipada"
        return True
    ammo = st.jogador.ammo.get(arma.codigo, 0)
    if ammo <= 0:
        st.mensagem = "Sem municao"
        return True
    st.jogador.ammo[arma.codigo] = ammo - 1
    if st.modo_renderizacao == "raycast":
        _atirar_raycast(st, arma)
    else:
        _atirar_cardinal(st, arma)
    return True


def recarregar(st):
    """Recarrega a arma atual ate o maximo."""
    arma = st.arma_atual()
    if arma is None:
        st.mensagem = "Sem arma equipada"
        return True
    atual = st.jogador.ammo.get(arma.codigo, 0)
    if atual >= arma.municao_max:
        st.mensagem = "Carregador cheio"
        return True
    st.jogador.ammo[arma.codigo] = arma.municao_max
    st.mensagem = "Recarregado"
    return True


def _ordem_arsenal(st):
    """Lista de codigos do arsenal em ordem fixa."""
    ordem = ["pistola", "shotgun", "rifle", "cannon"]
    return [c for c in ordem if c in st.jogador.arsenal]


def _trocar_arma(st, passo):
    arsenal = _ordem_arsenal(st)
    if not arsenal:
        st.mensagem = "Sem armas"
        return True
    if st.jogador.arma not in arsenal:
        st.jogador.arma = arsenal[0]
        st.mensagem = "Arma equipada: " + st.armas[st.jogador.arma].nome
        return True
    if len(arsenal) == 1:
        st.mensagem = "Apenas uma arma"
        return True
    idx = arsenal.index(st.jogador.arma)
    novo = (idx + passo) % len(arsenal)
    st.jogador.arma = arsenal[novo]
    st.mensagem = "Arma equipada: " + st.armas[st.jogador.arma].nome
    return True


def proxima_arma(st):
    return _trocar_arma(st, 1)


def arma_anterior(st):
    return _trocar_arma(st, -1)


def sair(st):
    st.rodando = False
    st.mensagem = "Saindo..."
    return False

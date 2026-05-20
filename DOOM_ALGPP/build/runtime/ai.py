"""
runtime/ai.py
Comportamento dinamico de inimigos e boss.

Cada inimigo declarado em inimigos.algpp define seus parametros:
    vida, dano, cor, movimento (perseguir|parado), cadencia,
    ataque (corpo|distancia).

A funcao atualizar(st) eh chamada pelo loop principal a cada
"AI tick" (intervalo controlado pelo main, nao por frame). Ela:

    1. Move cada inimigo elegivel daquele tick (perseguir).
    2. Soma o dano de quem ficou adjacente ao jogador.
    3. Trata o ataque a distancia do SPITTER.
    4. Move o boss conforme sua cadencia.
    5. Aplica o dano do boss se ele estiver proximo.
    6. Aplica o dano total (limitado por dano_max_por_tick).
    7. Atualiza estado de vitoria/derrota.

Nada eh hardcoded aqui: os valores vem do GameState (que por sua
vez vem dos arquivos .algpp).
"""


def _dentro_do_mapa(fase, x, y):
    if fase is None or not fase.mapa:
        return False
    if y < 1 or y > len(fase.mapa):
        return False
    linha = fase.mapa[y - 1]
    if x < 1 or x > len(linha):
        return False
    return True


def _celula_livre(st, fase, x, y, ignorar=None):
    """Retorna True se um inimigo pode mover para (x, y).
    Bloqueia paredes, jogador, outros inimigos vivos e o boss."""
    if not _dentro_do_mapa(fase, x, y):
        return False
    if fase.mapa[y - 1][x - 1] == "#":
        return False
    if st.jogador.x == x and st.jogador.y == y:
        return False
    for outro in fase.inimigos_instancia:
        if outro is ignorar:
            continue
        if outro.vivo and outro.x == x and outro.y == y:
            return False
    bi = fase.boss_instancia
    if bi is not None and bi is not ignorar:
        if bi.vivo and bi.x == x and bi.y == y:
            return False
    return True


def _passos_perseguir(ix, iy, px, py):
    """Lista de tentativas de passo ordenadas pelo eixo mais relevante."""
    dx = 0
    dy = 0
    if px > ix:
        dx = 1
    elif px < ix:
        dx = -1
    if py > iy:
        dy = 1
    elif py < iy:
        dy = -1
    diff_x = abs(px - ix)
    diff_y = abs(py - iy)
    tentativas = []
    if diff_x >= diff_y:
        if dx != 0:
            tentativas.append((dx, 0))
        if dy != 0:
            tentativas.append((0, dy))
    else:
        if dy != 0:
            tentativas.append((0, dy))
        if dx != 0:
            tentativas.append((dx, 0))
    return tentativas


def _adjacente_ao_jogador(x, y, jx, jy):
    """Considera adjacente em 8 direcoes (corpo a corpo)."""
    return abs(x - jx) <= 1 and abs(y - jy) <= 1 and (x, y) != (jx, jy)


def _linha_de_visao_limpa(fase, x1, y1, x2, y2, alcance):
    """Verifica se (x1,y1)->(x2,y2) esta em linha reta (horizontal,
    vertical ou diagonal exata), dentro do alcance, sem parede."""
    dx_total = x2 - x1
    dy_total = y2 - y1
    if dx_total == 0 and dy_total == 0:
        return False
    if dx_total != 0 and dy_total != 0 and abs(dx_total) != abs(dy_total):
        return False
    dist = max(abs(dx_total), abs(dy_total))
    if dist > alcance:
        return False
    sx = 0 if dx_total == 0 else (1 if dx_total > 0 else -1)
    sy = 0 if dy_total == 0 else (1 if dy_total > 0 else -1)
    x = x1 + sx
    y = y1 + sy
    while (x, y) != (x2, y2):
        if not _dentro_do_mapa(fase, x, y):
            return False
        if fase.mapa[y - 1][x - 1] == "#":
            return False
        x += sx
        y += sy
    return True


def _mover_inimigo(st, fase, ini):
    """Tenta mover o inimigo um passo na direcao do jogador."""
    if ini.codigo not in st.inimigos:
        return
    tipo = st.inimigos[ini.codigo]
    if tipo.movimento != "perseguir":
        return
    for (sdx, sdy) in _passos_perseguir(
        ini.x, ini.y, st.jogador.x, st.jogador.y
    ):
        nx = ini.x + sdx
        ny = ini.y + sdy
        if _celula_livre(st, fase, nx, ny, ignorar=ini):
            ini.x = nx
            ini.y = ny
            return


def _atacar_jogador_corpo(st, ini):
    """Se inimigo esta adjacente, devolve o dano. Caso contrario 0."""
    if not _adjacente_ao_jogador(
        ini.x, ini.y, st.jogador.x, st.jogador.y
    ):
        return 0
    tipo = st.inimigos.get(ini.codigo)
    if tipo is None:
        return 0
    if tipo.ataque == "distancia":
        return 0
    return tipo.dano


def _ataque_distancia(st, fase, ini):
    """SPITTER e similares: atacam em linha reta se houver visao.
    O alcance vem do tipo declarado em inimigos.algpp."""
    tipo = st.inimigos.get(ini.codigo)
    if tipo is None:
        return 0
    if tipo.ataque != "distancia":
        return 0
    alcance = max(1, tipo.alcance)
    if not _linha_de_visao_limpa(
        fase, ini.x, ini.y, st.jogador.x, st.jogador.y, alcance
    ):
        return 0
    return tipo.dano


def _mover_boss(st, fase):
    """Move o boss um passo na direcao do jogador, se possivel."""
    bi = fase.boss_instancia
    if bi is None or not bi.vivo:
        return
    for (sdx, sdy) in _passos_perseguir(
        bi.x, bi.y, st.jogador.x, st.jogador.y
    ):
        nx = bi.x + sdx
        ny = bi.y + sdy
        if _celula_livre(st, fase, nx, ny, ignorar=bi):
            bi.x = nx
            bi.y = ny
            return


def _ataque_boss(st, fase):
    """Se o boss estiver perto do jogador, devolve seu dano."""
    bi = fase.boss_instancia
    if bi is None or not bi.vivo:
        return 0
    tipo = st.bosses.get(bi.codigo)
    if tipo is None:
        return 0
    dx = abs(bi.x - st.jogador.x)
    dy = abs(bi.y - st.jogador.y)
    if max(dx, dy) <= max(1, tipo.alcance):
        return tipo.dano
    return 0


def _aplicar_dano_total(st, dano, fonte):
    """Aplica dano respeitando o cap por tick. Atualiza derrota."""
    if dano <= 0:
        return
    cap = max(1, st.dano_max_por_tick)
    if dano > cap:
        dano = cap
    st.jogador.vida -= dano
    st.jogador.dano_recente = dano
    if st.jogador.vida <= 0:
        st.jogador.vida = 0
        st.jogador.vivo = False
        st.derrota = True
        st.mensagem = "Voce foi derrotado"
        return
    if fonte:
        st.mensagem = fonte + " atacou (-{})".format(dano)


def atualizar(st, tick):
    """Executa um tick de AI: move e ataca."""
    st.ai_tick = tick
    fase = st.fase_atual
    if fase is None:
        return
    if not st.jogador.vivo:
        return
    if st.derrota or st.vitoria:
        return
    st.jogador.dano_recente = 0
    dano_acumulado = 0
    ultimo_tipo = None
    for ini in fase.inimigos_instancia:
        if not ini.vivo:
            continue
        tipo = st.inimigos.get(ini.codigo)
        if tipo is None:
            continue
        cadencia = max(1, tipo.cadencia)
        if tick % cadencia != 0:
            continue
        _mover_inimigo(st, fase, ini)
        d = _atacar_jogador_corpo(st, ini)
        if d <= 0:
            d = _ataque_distancia(st, fase, ini)
        if d > 0:
            dano_acumulado += d
            ultimo_tipo = tipo.codigo
    bi = fase.boss_instancia
    if bi is not None and bi.vivo:
        tipo_b = st.bosses.get(bi.codigo)
        if tipo_b is not None:
            cad_b = max(1, tipo_b.cadencia)
            if tick % cad_b == 0:
                _mover_boss(st, fase)
                d = _ataque_boss(st, fase)
                if d > 0:
                    dano_acumulado += d
                    ultimo_tipo = tipo_b.codigo
    if dano_acumulado > 0:
        _aplicar_dano_total(st, dano_acumulado, ultimo_tipo)
    _verificar_vitoria(st)


def _verificar_vitoria(st):
    """Marca vitoria quando o boss da fase eh derrotado, se houver."""
    fase = st.fase_atual
    if fase is None:
        return
    bi = fase.boss_instancia
    if bi is not None and not bi.vivo:
        tipo = st.bosses.get(bi.codigo)
        if tipo is not None and tipo.bloqueia_saida:
            if not st.vitoria:
                st.mensagem = bi.nome + " derrotado. Saida liberada"
                st.vitoria = True

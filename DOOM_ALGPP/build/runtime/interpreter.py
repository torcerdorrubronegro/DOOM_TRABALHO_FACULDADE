"""
runtime/interpreter.py
Consome a lista de Declaracoes produzida pelo parser e monta um
GameState pronto para ser executado.

Tambem prepara as instancias de inimigo e boss para a fase ativa,
varrendo o mapa em busca de letras conhecidas (vindas dos tipos
declarados em inimigos.algpp e bosses.algpp).
"""

import textwrap

from runtime.game_state import (
    GameState, Jogador, Fase, Arma, Inimigo, InimigoInstancia,
    Boss, BossInstancia, Sprite,
)


def _para_inteiro(valor, padrao=0):
    try:
        return int(valor)
    except (TypeError, ValueError):
        return padrao


def montar_estado(declaracoes):
    """Recebe a lista de Declaracoes do parser e devolve um GameState."""
    st = GameState()
    for decl in declaracoes:
        _aplicar_decl(st, decl)
    _indexar_letras(st)
    _preparar_arsenal_inicial(st)
    if st.fase_inicial_nome and st.fase_atual is None:
        fase = st.buscar_fase(st.fase_inicial_nome)
        if fase is not None:
            _ativar_fase(st, fase)
    return st


def _aplicar_decl(st, decl):
    tipo_decl = decl.tipo_decl
    if tipo_decl == "algoritmo":
        st.titulo = decl.nome or st.titulo
        for filho in decl.filhos:
            _aplicar_decl(st, filho)
        return
    if tipo_decl == "configuracao":
        c = decl.campos
        if "titulo" in c:
            st.titulo = c["titulo"]
        if "largura" in c:
            st.largura_tela = _para_inteiro(c["largura"], st.largura_tela)
        if "altura" in c:
            st.altura_tela = _para_inteiro(c["altura"], st.altura_tela)
        if "fps" in c:
            st.fps = _para_inteiro(c["fps"], st.fps)
        if "input" in c:
            st.input_tempo_real = (c["input"] == "tempo_real")
        if "renderizacao" in c:
            valor = c["renderizacao"]
            if valor in ("mapa", "raycast"):
                st.modo_renderizacao = valor
        if "fov" in c:
            st.fov = _para_inteiro(c["fov"], st.fov)
        if "raios" in c:
            st.raios = _para_inteiro(c["raios"], st.raios)
        if "distancia_visao" in c:
            st.distancia_visao = _para_inteiro(
                c["distancia_visao"], st.distancia_visao
            )
        if "mostrar_minimapa" in c:
            st.mostrar_minimapa = (c["mostrar_minimapa"] == "sim")
        return
    if tipo_decl == "cores":
        for papel, cor in decl.campos.items():
            st.cores[papel] = cor if isinstance(cor, str) else "branco"
        return
    if tipo_decl == "jogador":
        c = decl.campos
        if "vida" in c:
            st.jogador.vida = _para_inteiro(c["vida"], st.jogador.vida)
        if "vida_max" in c:
            st.jogador.vida_max = _para_inteiro(
                c["vida_max"], st.jogador.vida_max
            )
        if "posicao" in c and isinstance(c["posicao"], list):
            st.jogador.x = float(_para_inteiro(
                c["posicao"][0], int(st.jogador.x)
            ))
            st.jogador.y = float(_para_inteiro(
                c["posicao"][1], int(st.jogador.y)
            ))
        if "direcao" in c:
            st.jogador.aplicar_direcao(c["direcao"])
        if "arma_inicial" in c:
            st.jogador.arma = c["arma_inicial"]
        return
    if tipo_decl == "fase":
        fase = Fase(decl.nome or "fase_sem_nome")
        c = decl.campos
        if "tamanho" in c and isinstance(c["tamanho"], list):
            fase.largura = _para_inteiro(c["tamanho"][0], fase.largura)
            fase.altura = _para_inteiro(c["tamanho"][1], fase.altura)
        if "jogador" in c and isinstance(c["jogador"], list):
            fase.jogador_x = _para_inteiro(c["jogador"][0], fase.jogador_x)
            fase.jogador_y = _para_inteiro(c["jogador"][1], fase.jogador_y)
            if len(c["jogador"]) >= 3:
                fase.jogador_dir = c["jogador"][2]
        if "objetivo" in c:
            fase.objetivo = c["objetivo"]
        if "boss" in c:
            valor = c["boss"]
            if isinstance(valor, list) and len(valor) >= 1:
                fase.boss = valor[0]
                if len(valor) >= 3:
                    fase.boss_x = _para_inteiro(valor[1], 0)
                    fase.boss_y = _para_inteiro(valor[2], 0)
            elif isinstance(valor, str):
                fase.boss = valor
        if "mapa" in c:
            fase.mapa = _normalizar_mapa(c["mapa"], fase.largura, fase.altura)
        st.fases.append(fase)
        return
    if tipo_decl == "arma":
        a = Arma(decl.nome or "arma")
        c = decl.campos
        a.nome = c.get("nome", a.nome)
        a.dano = _para_inteiro(c.get("dano"), a.dano)
        a.municao = _para_inteiro(c.get("municao"), a.municao)
        a.municao_max = _para_inteiro(c.get("municao_max"), a.municao_max)
        a.alcance = _para_inteiro(c.get("alcance"), a.alcance)
        a.cor = c.get("cor", a.cor)
        st.armas[a.codigo] = a
        return
    if tipo_decl == "inimigo":
        ini = Inimigo(decl.nome or "inimigo")
        c = decl.campos
        ini.letra = c.get("letra", ini.letra)
        ini.vida = _para_inteiro(c.get("vida"), ini.vida)
        ini.dano = _para_inteiro(c.get("dano"), ini.dano)
        ini.cor = c.get("cor", ini.cor)
        ini.movimento = c.get("movimento", ini.movimento)
        ini.cadencia = _para_inteiro(c.get("cadencia"), ini.cadencia)
        ini.ataque = c.get("ataque", ini.ataque)
        ini.alcance = _para_inteiro(c.get("alcance"), ini.alcance)
        st.inimigos[ini.codigo] = ini
        return
    if tipo_decl == "boss":
        b = Boss(decl.nome or "boss")
        c = decl.campos
        b.nome = c.get("nome", b.nome)
        b.letra = c.get("letra", b.letra)
        b.vida = _para_inteiro(c.get("vida"), b.vida)
        b.vida_max = _para_inteiro(c.get("vida_max"), b.vida)
        b.dano = _para_inteiro(c.get("dano"), b.dano)
        b.cadencia = _para_inteiro(c.get("cadencia"), b.cadencia)
        b.alcance = _para_inteiro(c.get("alcance"), b.alcance)
        b.cor = c.get("cor", b.cor)
        b.bloqueia_saida = (c.get("bloqueia_saida", "sim") == "sim")
        st.bosses[b.codigo] = b
        return
    if tipo_decl == "sprite":
        sp = Sprite(decl.nome or "sprite")
        c = decl.campos
        sp.cor = c.get("cor", sp.cor)
        if "linhas" in c:
            sp.linhas = _normalizar_linhas_sprite(c["linhas"])
        st.sprites[sp.codigo] = sp
        return
    if tipo_decl == "iniciar_fase":
        st.fase_inicial_nome = decl.campos.get("nome")
        return


def _indexar_letras(st):
    """Cria mapas letra->codigo para inimigos e bosses, para que o
    interpretador saiba o que cada caractere do mapa significa."""
    st.inimigos_por_letra = {}
    for codigo, tipo in st.inimigos.items():
        if tipo.letra:
            st.inimigos_por_letra[tipo.letra] = codigo
    st.bosses_por_letra = {}
    for codigo, tipo in st.bosses.items():
        if tipo.letra:
            st.bosses_por_letra[tipo.letra] = codigo


def _preparar_arsenal_inicial(st):
    """Define o arsenal inicial: arma equipada desbloqueada e cheia."""
    if st.jogador.arma and st.jogador.arma in st.armas:
        st.jogador.arsenal.add(st.jogador.arma)
        for codigo, arma in st.armas.items():
            if codigo == st.jogador.arma:
                st.jogador.ammo[codigo] = arma.municao_max
            else:
                st.jogador.ammo.setdefault(codigo, 0)


def _normalizar_linhas_sprite(linhas_brutas):
    """Remove indentacao comum e linhas em branco no inicio/fim,
    preservando a forma do desenho. Aceita strings cruas com CR/LF."""
    limpas = [linha.rstrip("\r").rstrip() for linha in linhas_brutas]
    while limpas and not limpas[0].strip():
        limpas.pop(0)
    while limpas and not limpas[-1].strip():
        limpas.pop()
    if not limpas:
        return []
    texto = "\n".join(limpas)
    dedented = textwrap.dedent(texto)
    return dedented.split("\n")


def _normalizar_mapa(linhas_brutas, largura, altura):
    """Ajusta o mapa para a largura/altura declaradas, preenchendo
    com '.'. Caracteres alem da largura sao cortados."""
    mapa = []
    for raw in linhas_brutas:
        linha = raw.rstrip("\r")
        corpo = linha.lstrip()
        if len(corpo) < largura:
            corpo = corpo + ("." * (largura - len(corpo)))
        elif len(corpo) > largura:
            corpo = corpo[:largura]
        mapa.append(list(corpo))
    while len(mapa) < altura:
        mapa.append(list("." * largura))
    if len(mapa) > altura:
        mapa = mapa[:altura]
    return mapa


def _ativar_fase(st, fase):
    """Carrega a fase como ativa, instancia inimigos/boss a partir do
    mapa e posiciona o jogador. Mantem vida/arsenal/municao/chave do
    jogador entre fases, mas zera mapa/inimigos/boss/flags da fase."""
    st.fase_atual = fase
    st.fase_index = st.indice_da_fase(fase)
    fase.inimigos_instancia = []
    fase.boss_instancia = None
    fase.concluida = False
    _spawnar_inimigos_do_mapa(st, fase)
    _spawnar_boss_da_fase(st, fase)
    st.jogador.x = float(fase.jogador_x)
    st.jogador.y = float(fase.jogador_y)
    st.jogador.aplicar_direcao(fase.jogador_dir)
    st.status = fase.objetivo or "Explore a fase"
    st.mensagem = "Fase: " + fase.nome
    st.vitoria = False
    st.transicao_inicio = None


def avancar_fase(st):
    """Encaminha o jogador para a proxima fase. Se nao houver,
    marca vitoria_final. Mantem vida, arsenal, municao e chave."""
    prox = st.proxima_fase()
    if prox is None:
        st.vitoria_final = True
        st.mensagem = "Voce venceu a campanha"
        return False
    _ativar_fase(st, prox)
    return True


def _spawnar_inimigos_do_mapa(st, fase):
    """Varre o mapa, troca letras de inimigo por '.' e cria instancias."""
    if not fase.mapa:
        return
    for y, linha in enumerate(fase.mapa):
        for x, ch in enumerate(linha):
            codigo = st.inimigos_por_letra.get(ch)
            if codigo is None:
                continue
            tipo = st.inimigos.get(codigo)
            if tipo is None:
                continue
            inst = InimigoInstancia(
                codigo=codigo,
                x=x + 1,
                y=y + 1,
                vida=tipo.vida,
                letra=tipo.letra,
                cor=tipo.cor,
            )
            fase.inimigos_instancia.append(inst)
            fase.mapa[y][x] = "."


def _spawnar_boss_da_fase(st, fase):
    """Cria a instancia de boss da fase, se houver. Aceita declaracao
    via 'boss <codigo> <X> <Y>' ou marcador O no mapa."""
    if fase.boss and fase.boss in st.bosses:
        tipo = st.bosses[fase.boss]
        bx = fase.boss_x if fase.boss_x else 0
        by = fase.boss_y if fase.boss_y else 0
        if (bx == 0 or by == 0) and fase.mapa:
            for y, linha in enumerate(fase.mapa):
                for x, ch in enumerate(linha):
                    if ch == tipo.letra:
                        bx = x + 1
                        by = y + 1
                        fase.mapa[y][x] = "."
                        break
                if bx and by:
                    break
        if bx and by and fase.mapa:
            yy = by - 1
            xx = bx - 1
            if 0 <= yy < len(fase.mapa) and 0 <= xx < len(fase.mapa[yy]):
                if fase.mapa[yy][xx] == tipo.letra:
                    fase.mapa[yy][xx] = "."
        if bx and by:
            fase.boss_instancia = BossInstancia(
                codigo=tipo.codigo,
                x=bx,
                y=by,
                vida=tipo.vida_max or tipo.vida,
                vida_max=tipo.vida_max or tipo.vida,
                letra=tipo.letra,
                cor=tipo.cor,
                nome=tipo.nome,
            )


def ativar_fase(st, fase):
    """Versao publica de _ativar_fase para uso externo."""
    _ativar_fase(st, fase)

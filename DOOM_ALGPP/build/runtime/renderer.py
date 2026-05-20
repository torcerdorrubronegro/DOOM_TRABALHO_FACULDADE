"""
runtime/renderer.py
Renderer principal. Despacha para o renderer apropriado conforme
st.modo_renderizacao:

    - "mapa"    : visao 2D top-down (a versao classica desde o PP0)
    - "raycast" : visao pseudo-3D em primeira pessoa (PP6.5)

A funcao publica desenhar(st) eh chamada pelo main loop. Ambos os
renderers leem o mesmo GameState; a logica do jogo (gameplay, ai,
interpreter, parser) nao precisa saber qual esta ativo.
"""

from runtime import terminal
from runtime.colors import paint


def _setinha(direcao):
    return {
        "norte": "^",
        "leste": ">",
        "sul":   "v",
        "oeste": "<",
    }.get(direcao, "@")


def _cor_celula(ch, cores):
    if ch == "#":
        return cores.get("parede", "cinza")
    if ch == ".":
        return cores.get("chao", "preto")
    if ch == "X":
        return cores.get("saida", "azul")
    if ch == "K":
        return cores.get("item", "amarelo")
    if ch == "A":
        return cores.get("item", "amarelo")
    if ch == "C":
        return cores.get("chave", "amarelo")
    if ch == "W":
        return cores.get("arma", "ciano")
    return cores.get("hud", "branco")


def _barra(atual, maximo, largura=10, simbolo="#"):
    """Monta uma barra do estilo [#####.....] com 'largura' celulas."""
    if maximo <= 0:
        cheio = 0
    else:
        cheio = (atual * largura) // maximo
        if cheio < 0:
            cheio = 0
        if cheio > largura:
            cheio = largura
    return "[" + (simbolo * cheio) + ("." * (largura - cheio)) + "]"


def _linha_hud(st):
    arma = st.arma_atual()
    ammo = st.ammo_arma()
    ammo_max = st.ammo_max_arma()
    nome_arma = arma.nome if arma else "-"
    dano = arma.dano if arma else 0
    chave = "SIM" if st.jogador.tem_chave else "NAO"
    barra_vida = _barra(st.jogador.vida, st.jogador.vida_max, 10)
    barra_ammo = _barra(ammo, ammo_max, 10, "*")
    return ("VIDA {} {}/{}   "
            "ARMA {} {} {}/{}  DANO {}   CHAVE {}").format(
        barra_vida, st.jogador.vida, st.jogador.vida_max,
        nome_arma, barra_ammo, ammo, ammo_max, dano, chave,
    )


def _linha_arsenal(st):
    ordem = ["pistola", "shotgun", "rifle", "cannon"]
    pedacos = []
    for codigo in ordem:
        if codigo not in st.armas:
            continue
        a = st.armas[codigo]
        if codigo not in st.jogador.arsenal:
            marca = "-"
        elif codigo == st.jogador.arma:
            marca = ">"
        else:
            marca = "+"
        pedacos.append("{} {}".format(marca, a.nome))
    return "ARSENAL: " + "   ".join(pedacos)


def _desenhar_mapa(st):
    """Monta as linhas do mapa com instancias sobrepostas."""
    fase = st.fase_atual
    if fase is None or not fase.mapa:
        return [paint("Sem fase carregada", st.cor_de("hud"))]
    sobre = {}
    for ini in fase.inimigos_instancia:
        if ini.vivo:
            sobre[(ini.x, ini.y)] = (ini.letra, ini.cor)
    bi = fase.boss_instancia
    if bi is not None and bi.vivo:
        sobre[(bi.x, bi.y)] = (bi.letra, bi.cor)
    cor_jog = st.cor_de("jogador")
    linhas = []
    for y, linha in enumerate(fase.mapa):
        buffer = ""
        for x, ch in enumerate(linha):
            px = x + 1
            py = y + 1
            if px == st.jogador.cell_x() and py == st.jogador.cell_y():
                buffer += paint(_setinha(st.jogador.direcao), cor_jog)
                continue
            chave = (px, py)
            if chave in sobre:
                letra, cor = sobre[chave]
                buffer += paint(letra, cor)
                continue
            buffer += paint(ch, _cor_celula(ch, st.cores))
        linhas.append(buffer)
    return linhas


def _linha_boss(st):
    fase = st.fase_atual
    if fase is None or fase.boss_instancia is None:
        return None
    bi = fase.boss_instancia
    if not bi.vivo:
        return paint(bi.nome + " DERROTADO", st.cor_de("boss"))
    barra = _barra(bi.vida, bi.vida_max, 14, "#")
    txt = "{} {} {}/{}".format(bi.nome, barra, bi.vida, bi.vida_max)
    return paint(txt, st.cor_de("boss"))


def desenhar(st):
    """Despacha para o renderer apropriado conforme st.modo_renderizacao."""
    if getattr(st, "modo_renderizacao", "mapa") == "raycast":
        from runtime import renderer_raycast
        renderer_raycast.desenhar(st)
        return
    _desenhar_2d(st)


def _desenhar_2d(st):
    """Desenha o frame em modo mapa (2D top-down)."""
    terminal.home()
    cor_hud = st.cor_de("hud")
    cor_obj = st.cor_de("hud")
    cor_dano = st.cor_de("inimigo")
    linhas = []
    linhas.append(paint(st.titulo, cor_hud))
    linhas.append("")
    linhas.append(paint(_linha_hud(st), cor_hud))
    linhas.append(paint(_linha_arsenal(st), cor_hud))
    linha_boss = _linha_boss(st)
    if linha_boss is not None:
        linhas.append(linha_boss)
    if st.jogador.dano_recente > 0:
        linhas.append(paint(
            "DANO RECEBIDO -" + str(st.jogador.dano_recente),
            cor_dano,
        ))
    linhas.append("")
    linhas.extend(_desenhar_mapa(st))
    linhas.append("")
    linhas.append(paint("OBJETIVO: " + st.status, cor_obj))
    if st.fase_atual is not None:
        inimigos_vivos = st.inimigos_vivos()
        info = "Inimigos restantes: {}   Saida: {}".format(
            inimigos_vivos,
            "LIBERADA" if st.saida_liberada() else "BLOQUEADA",
        )
        linhas.append(paint(info, cor_hud))
    if st.derrota:
        linhas.append(paint("VOCE PERDEU", cor_dano))
    elif st.vitoria_final:
        linhas.append(paint("VOCE VENCEU A CAMPANHA",
                             st.cor_de("jogador")))
    elif st.fase_atual is not None and st.fase_atual.concluida:
        if st.tem_proxima_fase():
            prox = st.proxima_fase()
            linhas.append(paint(
                "Fase concluida. Proxima: " + prox.nome,
                st.cor_de("jogador"),
            ))
        else:
            linhas.append(paint("Fase concluida",
                                 st.cor_de("jogador")))
    elif st.vitoria:
        linhas.append(paint("VOCE VENCEU", st.cor_de("jogador")))
    linhas.append(paint(st.mensagem, cor_hud))
    linhas.append("")
    linhas.append(paint(
        "W/A/S/D mover   F atira   R recarrega   Z/X troca arma   Q sair",
        cor_hud,
    ))
    saida = "\n".join(_limpar_eol(linha) for linha in linhas) + "\033[J"
    terminal.escrever(saida + "\n")
    terminal.descarregar()


def _limpar_eol(linha):
    """Acrescenta limpeza ate fim da linha para evitar lixo na renderizacao."""
    return linha + "\033[K"

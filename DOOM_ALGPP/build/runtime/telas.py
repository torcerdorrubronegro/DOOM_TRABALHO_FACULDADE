"""
runtime/telas.py
Telas standalone do DoomALG++: menu inicial, creditos, vitoria
final e derrota. Cada funcao limpa a tela, desenha conteudo
estatico e fica em um pequeno loop esperando uma tecla.

Essas telas nao dependem do raycast nem do modo 2D do jogo. Elas
usam diretamente o terminal e a thread de input do runtime.
"""

import time

from runtime import terminal, input_thread
from runtime.colors import paint


_CENTRO = 80


def _centralizar(texto, largura):
    if len(texto) >= largura:
        return texto
    espaco = (largura - len(texto)) // 2
    return (" " * espaco) + texto


def _escrever_centro(texto, cor, largura):
    return paint(_centralizar(texto, largura), cor)


def _esperar_tecla(timeout_total=None):
    """Espera o jogador apertar uma tecla. Retorna a tecla (lower).
    Se timeout_total expirar, retorna None."""
    input_thread.descarregar_fila()
    inicio = time.monotonic()
    while True:
        tecla = input_thread.proxima_tecla(timeout=0.05)
        if tecla is not None:
            return tecla.lower()
        if timeout_total is not None:
            if time.monotonic() - inicio > timeout_total:
                return None


def _esperar_uma_de(opcoes, timeout_total=None):
    """Espera ate o jogador apertar uma das teclas em 'opcoes'."""
    input_thread.descarregar_fila()
    inicio = time.monotonic()
    while True:
        tecla = input_thread.proxima_tecla(timeout=0.05)
        if tecla is not None:
            t = tecla.lower()
            if t in opcoes:
                return t
        if timeout_total is not None:
            if time.monotonic() - inicio > timeout_total:
                return None


def menu(st):
    """Mostra o menu inicial. Retorna 'jogar', 'creditos' ou 'sair'."""
    largura = st.largura_tela or _CENTRO
    cor_hud = st.cor_de("hud")
    cor_jog = st.cor_de("jogador")
    cor_dest = st.cor_de("item")
    terminal.limpar_tela()
    linhas = [""]
    linhas.append(_escrever_centro("D O O M A L G + +", cor_jog, largura))
    linhas.append("")
    linhas.append(_escrever_centro(st.titulo or "DoomALG++", cor_hud, largura))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro("1 - Jogar", cor_dest, largura))
    linhas.append(_escrever_centro("2 - Creditos", cor_dest, largura))
    linhas.append(_escrever_centro("3 - Sair", cor_dest, largura))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro(
        "Pressione a tecla da opcao desejada",
        cor_hud, largura,
    ))
    terminal.escrever("\n".join(linhas) + "\n")
    terminal.descarregar()
    t = _esperar_uma_de({"1", "2", "3", "q"})
    if t == "1":
        return "jogar"
    if t == "2":
        return "creditos"
    return "sair"


def creditos(st):
    """Mostra a tela de creditos. Volta ao menu apos uma tecla."""
    largura = st.largura_tela or _CENTRO
    cor_hud = st.cor_de("hud")
    cor_jog = st.cor_de("jogador")
    terminal.limpar_tela()
    linhas = [""]
    linhas.append(_escrever_centro("C R E D I T O S", cor_jog, largura))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro("DoomALG", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro("Alunos:", cor_hud, largura))
    linhas.append(_escrever_centro(
        "Marcell Alves Resende", cor_hud, largura))
    linhas.append(_escrever_centro("RA: 5178278", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Pedro Andrade Santos", cor_hud, largura))
    linhas.append(_escrever_centro("RA: 5180749", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Davi Augusto Alves de Assis", cor_hud, largura))
    linhas.append(_escrever_centro("RA: 5181548", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro("Disciplina:", cor_hud, largura))
    linhas.append(_escrever_centro(
        "ALGORITMOS E ESTRUTURAS DE DADOS", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro("Professor:", cor_hud, largura))
    linhas.append(_escrever_centro(
        "MAXWELL GOMES DA SILVA", cor_hud, largura))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro(
        "Pressione qualquer tecla para voltar",
        cor_hud, largura,
    ))
    terminal.escrever("\n".join(linhas) + "\n")
    terminal.descarregar()
    _esperar_tecla()


def tela_vitoria(st):
    """Tela mostrada apos derrotar o boss final e concluir a campanha."""
    largura = st.largura_tela or _CENTRO
    cor_hud = st.cor_de("hud")
    cor_jog = st.cor_de("jogador")
    cor_boss = st.cor_de("boss")
    terminal.limpar_tela()
    linhas = [""]
    linhas.append("")
    linhas.append(_escrever_centro("V O C E   V E N C E U",
                                     cor_jog, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Campanha concluida", cor_hud, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Boss derrotado: OVERLORD ASCII", cor_boss, largura))
    linhas.append("")
    fases_total = len(st.fases)
    linhas.append(_escrever_centro(
        "Fases vencidas: {}/{}".format(fases_total, fases_total),
        cor_hud, largura,
    ))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro(
        "Pressione qualquer tecla para voltar ao menu",
        cor_hud, largura,
    ))
    terminal.escrever("\n".join(linhas) + "\n")
    terminal.descarregar()
    _esperar_tecla()


def tela_derrota(st):
    """Tela mostrada quando o jogador morre."""
    largura = st.largura_tela or _CENTRO
    cor_hud = st.cor_de("hud")
    cor_dano = st.cor_de("inimigo")
    terminal.limpar_tela()
    fase_nome = st.fase_atual.nome if st.fase_atual else "-"
    linhas = [""]
    linhas.append("")
    linhas.append(_escrever_centro("V O C E   P E R D E U",
                                     cor_dano, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Fase alcancada: " + fase_nome,
        cor_hud, largura,
    ))
    linhas.append("")
    linhas.append("")
    linhas.append(_escrever_centro(
        "Pressione qualquer tecla para voltar ao menu",
        cor_hud, largura,
    ))
    terminal.escrever("\n".join(linhas) + "\n")
    terminal.descarregar()
    _esperar_tecla()


def tela_saida(st):
    """Tela curta exibida antes de encerrar o programa."""
    largura = st.largura_tela or _CENTRO
    cor_hud = st.cor_de("hud")
    cor_jog = st.cor_de("jogador")
    terminal.limpar_tela()
    linhas = [""]
    linhas.append(_escrever_centro(
        "Obrigado por jogar DoomALG++", cor_jog, largura))
    linhas.append("")
    linhas.append(_escrever_centro(
        "Ate a proxima.", cor_hud, largura))
    terminal.escrever("\n".join(linhas) + "\n")
    terminal.descarregar()

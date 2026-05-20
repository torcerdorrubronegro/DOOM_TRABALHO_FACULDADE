"""
runtime/terminal.py
Controle basico de terminal: limpar tela, posicionar cursor, esconder cursor.
Funciona em Windows e Unix (ANSI).
"""

import os
import sys

_ANSI_PREPARADO = False


def preparar():
    """
    Liga suporte ANSI no Windows quando possivel.
    No Windows 10+ os codigos ANSI funcionam apos uma chamada inicial
    ao subsistema do console (basta um os.system("")) ou colorama.
    """
    global _ANSI_PREPARADO
    if _ANSI_PREPARADO:
        return
    if os.name == "nt":
        try:
            import colorama
            colorama.just_fix_windows_console()
        except Exception:
            os.system("")
    _ANSI_PREPARADO = True


def limpar_tela():
    """Limpa a tela inteira."""
    sys.stdout.write("\033[2J")
    sys.stdout.write("\033[H")
    sys.stdout.flush()


def home():
    """Move o cursor para a posicao 1,1 sem limpar a tela."""
    sys.stdout.write("\033[H")
    sys.stdout.flush()


def posicionar(linha, coluna):
    """Move o cursor para (linha, coluna), ambas comecando em 1."""
    sys.stdout.write("\033[{};{}H".format(linha, coluna))


def esconder_cursor():
    sys.stdout.write("\033[?25l")
    sys.stdout.flush()


def mostrar_cursor():
    sys.stdout.write("\033[?25h")
    sys.stdout.flush()


def escrever(texto):
    sys.stdout.write(texto)


def descarregar():
    sys.stdout.flush()

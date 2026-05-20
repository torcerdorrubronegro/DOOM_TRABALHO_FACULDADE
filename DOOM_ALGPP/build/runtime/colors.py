"""
runtime/colors.py
Mapeia nomes de cor do Portugol++ para codigos ANSI.
As cores sao declaradas no bloco "cores" do script .algpp.
"""

RESET = "\033[0m"

_FG = {
    "preto":    "\033[30m",
    "vermelho": "\033[31m",
    "verde":    "\033[32m",
    "amarelo":  "\033[33m",
    "azul":     "\033[34m",
    "magenta":  "\033[35m",
    "ciano":    "\033[36m",
    "branco":   "\033[37m",
    "cinza":    "\033[90m",
}

_BG = {
    "preto":    "\033[40m",
    "vermelho": "\033[41m",
    "verde":    "\033[42m",
    "amarelo":  "\033[43m",
    "azul":     "\033[44m",
    "magenta":  "\033[45m",
    "ciano":    "\033[46m",
    "branco":   "\033[47m",
    "cinza":    "\033[100m",
}


def fg(nome):
    """Retorna o codigo ANSI de cor de frente para o nome dado."""
    return _FG.get(nome.lower() if isinstance(nome, str) else "", "")


def bg(nome):
    """Retorna o codigo ANSI de cor de fundo para o nome dado."""
    return _BG.get(nome.lower() if isinstance(nome, str) else "", "")


def paint(texto, cor_frente=None, cor_fundo=None):
    """Aplica cores ANSI a um texto e fecha com RESET."""
    saida = ""
    if cor_frente:
        saida += fg(cor_frente)
    if cor_fundo:
        saida += bg(cor_fundo)
    saida += str(texto)
    saida += RESET
    return saida


def disponiveis():
    """Lista as cores reconhecidas pelo runtime."""
    return sorted(_FG.keys())

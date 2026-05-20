"""
runtime/parser.py
Parser inicial do Portugol++ (.algpp).

Reconhece blocos delimitados por palavras-chave do tipo
abertura ... fimabertura. Dentro de um bloco, cada linha pode ser:

    - uma chave-valor simples ("vida 150")
    - um sub-bloco delimitado por sua propria palavra de fechamento
      (apenas dentro de blocos que admitem aninhamento)
    - um bloco de texto cru entre "X inicio" e "fimX" (mapa, linhas)
    - um comando ("usar arquivo", "iniciar fase nome")

O resultado eh uma lista de declaracoes, cada uma com tipo, nome
opcional e um dicionario de campos. Esse formato eh consumido pelo
interpretador (runtime/interpreter.py) para montar o estado do jogo.
"""

import os
import re


class Declaracao:
    """Representa um bloco analisado do script .algpp."""

    def __init__(self, tipo_decl, nome=None):
        self.tipo_decl = tipo_decl
        self.nome = nome
        self.campos = {}
        self.linhas_brutas = []
        self.filhos = []

    def __repr__(self):
        return "Declaracao(tipo={}, nome={}, campos={}, filhos={})".format(
            self.tipo_decl, self.nome, self.campos, len(self.filhos)
        )


class ErroDeSintaxe(Exception):
    pass


_BLOCOS_FECHAMENTO = {
    "algoritmo":    "fimalgoritmo",
    "configuracao": "fimconfiguracao",
    "cores":        "fimcores",
    "jogador":      "fimjogador",
    "fase":         "fimfase",
    "arma":         "fimarma",
    "inimigo":      "fiminimigo",
    "boss":         "fimboss",
    "sprite":       "fimsprite",
}

_BLOCOS_BRUTOS = {
    "mapa":   "fimmapa",
    "linhas": "fimlinhas",
}

_BLOCOS_QUE_CONTEM_BLOCOS = {"algoritmo"}


def _tokenizar_linha(linha):
    """Quebra a linha em tokens preservando strings entre aspas."""
    padrao = r'"([^"]*)"|(\S+)'
    tokens = []
    for m in re.finditer(padrao, linha):
        if m.group(1) is not None:
            tokens.append(("str", m.group(1)))
        else:
            tokens.append(("ident", m.group(2)))
    return tokens


def _ler_arquivo(caminho):
    with open(caminho, "r", encoding="utf-8") as fh:
        return fh.read().splitlines()


def parsear_arquivo(caminho, base_dir=None, vistos=None):
    """
    Analisa um arquivo .algpp e retorna lista de Declaracoes de topo.
    Resolve diretivas "usar" relativas a base_dir.
    """
    if base_dir is None:
        base_dir = os.path.dirname(os.path.abspath(caminho))
    if vistos is None:
        vistos = set()
    caminho_abs = os.path.abspath(caminho)
    if caminho_abs in vistos:
        return []
    vistos.add(caminho_abs)
    linhas = _ler_arquivo(caminho_abs)
    decls = []
    _parsear_linhas(linhas, 0, fim_esperado=None,
                     destino=decls, decl_pai=None,
                     base_dir=base_dir, vistos=vistos,
                     pai_aceita_blocos=True)
    return decls


def _parsear_linhas(linhas, idx, fim_esperado, destino, decl_pai,
                     base_dir, vistos, pai_aceita_blocos):
    """
    Percorre as linhas a partir de idx ate encontrar fim_esperado
    (ou fim do arquivo se fim_esperado for None).

    destino: lista que recebe as declaracoes desse nivel (raiz ou filhos).
    decl_pai: a Declaracao em que estamos (None no nivel raiz).
    pai_aceita_blocos: se True, identificadores de bloco abrem sub-blocos;
                       se False, sao tratados como chave-valor.

    Retorna o indice apos o fechamento.
    """
    while idx < len(linhas):
        linha_bruta = linhas[idx]
        linha = linha_bruta.strip()
        if linha == "" or linha.startswith("#"):
            idx += 1
            continue
        tokens = _tokenizar_linha(linha)
        if not tokens:
            idx += 1
            continue
        primeiro = tokens[0][1]
        if fim_esperado is not None and primeiro == fim_esperado:
            return idx + 1
        if primeiro == "usar" and len(tokens) >= 2:
            nome_arq = tokens[1][1]
            sub = parsear_arquivo(os.path.join(base_dir, nome_arq),
                                  base_dir=base_dir, vistos=vistos)
            destino.extend(sub)
            idx += 1
            continue
        if primeiro == "iniciar" and len(tokens) >= 3 and tokens[1][1] == "fase":
            d = Declaracao("iniciar_fase")
            d.campos["nome"] = tokens[2][1]
            destino.append(d)
            idx += 1
            continue
        if (primeiro in _BLOCOS_BRUTOS and len(tokens) >= 2
                and tokens[1][1] == "inicio" and decl_pai is not None):
            fim_bruto = _BLOCOS_BRUTOS[primeiro]
            bruto = []
            idx += 1
            while idx < len(linhas):
                linha_bruta2 = linhas[idx]
                if linha_bruta2.strip() == fim_bruto:
                    break
                bruto.append(linha_bruta2)
                idx += 1
            if idx >= len(linhas):
                raise ErroDeSintaxe(
                    "Bloco '{}' nao foi fechado com '{}'".format(
                        primeiro, fim_bruto
                    )
                )
            decl_pai.campos[primeiro] = bruto
            idx += 1
            continue
        if pai_aceita_blocos and primeiro in _BLOCOS_FECHAMENTO:
            fim = _BLOCOS_FECHAMENTO[primeiro]
            nome = None
            if len(tokens) >= 2:
                nome = tokens[1][1]
            decl_novo = Declaracao(primeiro, nome=nome)
            destino_filho = (decl_novo.filhos
                             if primeiro in _BLOCOS_QUE_CONTEM_BLOCOS
                             else decl_novo.filhos)
            aceita = primeiro in _BLOCOS_QUE_CONTEM_BLOCOS
            idx_fim = _parsear_linhas(linhas, idx + 1, fim,
                                       destino_filho, decl_novo,
                                       base_dir, vistos,
                                       pai_aceita_blocos=aceita)
            destino.append(decl_novo)
            idx = idx_fim
            continue
        if decl_pai is not None:
            valores = tokens[1:]
            if len(valores) == 0:
                decl_pai.campos[primeiro] = True
            elif len(valores) == 1:
                decl_pai.campos[primeiro] = valores[0][1]
            else:
                decl_pai.campos[primeiro] = [v[1] for v in valores]
            idx += 1
            continue
        raise ErroDeSintaxe(
            "Linha inesperada no nivel raiz: {}".format(linha)
        )
    if fim_esperado is not None:
        raise ErroDeSintaxe(
            "Bloco nao foi fechado, esperava '{}'".format(fim_esperado)
        )
    return idx


def listar_blocos_suportados():
    """Lista todos os blocos reconhecidos pelo parser."""
    return sorted(_BLOCOS_FECHAMENTO.keys()) + sorted(_BLOCOS_BRUTOS.keys())

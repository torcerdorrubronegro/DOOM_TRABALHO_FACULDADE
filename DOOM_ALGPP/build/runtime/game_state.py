"""
runtime/game_state.py
Estado de execucao do DoomALG++.

Distincao importante:

    - As classes Arma, Inimigo, Boss, Sprite descrevem TIPOS.
      Sao a leitura crua dos arquivos .algpp.

    - As classes InimigoInstancia e BossInstancia descrevem
      ocorrencias daquele tipo dentro de uma fase. Tem posicao,
      vida e estado de vivo/morto.

A logica do jogo deve consultar e modificar este estado em vez de
guardar variaveis soltas em outros modulos.
"""


_DIRECAO_PARA_ANGULO = {
    "leste": 0.0,
    "sul":   90.0,
    "oeste": 180.0,
    "norte": 270.0,
}


def angulo_de_direcao(direcao):
    """Converte um nome cardinal em angulo em graus."""
    return _DIRECAO_PARA_ANGULO.get(direcao, 0.0)


def direcao_de_angulo(angulo):
    """Aproxima um angulo (graus) ao cardinal mais proximo."""
    a = angulo % 360.0
    if a < 45.0 or a >= 315.0:
        return "leste"
    if a < 135.0:
        return "sul"
    if a < 225.0:
        return "oeste"
    return "norte"


class Jogador:
    """Estado do jogador. O arsenal e a municao vivem aqui.

    A posicao (x, y) eh float para suportar movimento livre no modo
    raycast. No modo 2D ela continua valendo um inteiro logico.
    O angulo eh mantido em graus; a direcao cardinal eh derivada.
    """

    def __init__(self):
        self.x = 1.0
        self.y = 1.0
        self.direcao = "leste"
        self.angulo = 0.0
        self.vida = 100
        self.vida_max = 100
        self.arma = "pistola"
        self.arsenal = set()
        self.ammo = {}
        self.tem_chave = False
        self.vivo = True
        self.dano_recente = 0

    def cell_x(self):
        """Coluna inteira em que o jogador esta (1-indexado)."""
        return int(round(self.x))

    def cell_y(self):
        """Linha inteira em que o jogador esta (1-indexado)."""
        return int(round(self.y))

    def aplicar_direcao(self, nome_cardinal):
        """Define direcao cardinal e angulo correspondente."""
        self.direcao = nome_cardinal
        self.angulo = angulo_de_direcao(nome_cardinal)

    def aplicar_angulo(self, novo_angulo):
        """Define angulo livre (graus) e atualiza direcao cardinal."""
        self.angulo = novo_angulo % 360.0
        self.direcao = direcao_de_angulo(self.angulo)


class Fase:
    def __init__(self, nome):
        self.nome = nome
        self.largura = 24
        self.altura = 12
        self.mapa = []
        self.jogador_x = 1
        self.jogador_y = 1
        self.jogador_dir = "leste"
        self.objetivo = ""
        self.boss = None
        self.boss_x = 0
        self.boss_y = 0
        self.inimigos_instancia = []
        self.boss_instancia = None
        self.concluida = False


class Arma:
    def __init__(self, codigo):
        self.codigo = codigo
        self.nome = codigo.upper()
        self.dano = 1
        self.municao = 0
        self.municao_max = 0
        self.alcance = 5
        self.cor = "branco"


class Inimigo:
    """Definicao de tipo de inimigo, carregada de inimigos.algpp."""

    def __init__(self, codigo):
        self.codigo = codigo
        self.letra = "?"
        self.vida = 1
        self.dano = 1
        self.cor = "vermelho"
        self.movimento = "perseguir"
        self.cadencia = 2
        self.ataque = "corpo"
        self.alcance = 1


class InimigoInstancia:
    """Ocorrencia de inimigo dentro da fase, com posicao e vida."""

    def __init__(self, codigo, x, y, vida, letra="?", cor="vermelho"):
        self.codigo = codigo
        self.x = x
        self.y = y
        self.vida = vida
        self.vivo = True
        self.letra = letra
        self.cor = cor


class Boss:
    """Definicao de tipo de boss, carregada de bosses.algpp."""

    def __init__(self, codigo):
        self.codigo = codigo
        self.nome = codigo.upper()
        self.letra = "O"
        self.vida = 10
        self.vida_max = 10
        self.dano = 10
        self.cadencia = 3
        self.alcance = 3
        self.cor = "magenta"
        self.bloqueia_saida = True


class BossInstancia:
    def __init__(self, codigo, x, y, vida, vida_max, letra="O",
                 cor="magenta", nome=None):
        self.codigo = codigo
        self.x = x
        self.y = y
        self.vida = vida
        self.vida_max = vida_max
        self.vivo = True
        self.letra = letra
        self.cor = cor
        self.nome = nome or codigo.upper()


class Sprite:
    def __init__(self, codigo):
        self.codigo = codigo
        self.cor = "branco"
        self.linhas = []


class GameState:
    """Estado completo do runtime."""

    def __init__(self):
        self.titulo = "DoomALG++"
        self.largura_tela = 80
        self.altura_tela = 24
        self.fps = 30
        self.input_tempo_real = True
        self.cores = {}
        self.jogador = Jogador()
        self.fases = []
        self.armas = {}
        self.inimigos = {}
        self.bosses = {}
        self.sprites = {}
        self.fase_atual = None
        self.fase_index = -1
        self.fase_inicial_nome = None
        self.rodando = True
        self.status = "Use W A S D para mover, F atira, Q para sair"
        self.mensagem = ""
        self.inimigos_por_letra = {}
        self.bosses_por_letra = {}
        self.ai_tick = 0
        self.derrota = False
        self.vitoria = False
        self.vitoria_final = False
        self.dano_max_por_tick = 24
        self.transicao_inicio = None
        self.transicao_duracao = 1.5
        self.modo_renderizacao = "mapa"
        self.fov = 60
        self.raios = 80
        self.distancia_visao = 18
        self.mostrar_minimapa = True
        self.passo_rotacao = 15.0
        self.passo_movimento = 0.5

    def buscar_fase(self, nome):
        for f in self.fases:
            if f.nome == nome:
                return f
        return None

    def cor_de(self, papel):
        return self.cores.get(papel, "branco")

    def arma_atual(self):
        """Retorna o tipo (Arma) da arma atualmente equipada, se houver."""
        return self.armas.get(self.jogador.arma)

    def ammo_arma(self, codigo=None):
        """Retorna a municao atual de uma arma, padrao = arma equipada."""
        codigo = codigo or self.jogador.arma
        return self.jogador.ammo.get(codigo, 0)

    def ammo_max_arma(self, codigo=None):
        """Retorna a municao maxima daquela arma."""
        codigo = codigo or self.jogador.arma
        arma = self.armas.get(codigo)
        if arma is None:
            return 0
        return arma.municao_max

    def inimigo_em(self, x, y):
        """Retorna a instancia de inimigo viva em (x,y), se houver."""
        fase = self.fase_atual
        if fase is None:
            return None
        for ini in fase.inimigos_instancia:
            if ini.vivo and ini.x == x and ini.y == y:
                return ini
        return None

    def boss_em(self, x, y):
        """Retorna a instancia de boss vivo em (x,y), se houver."""
        fase = self.fase_atual
        if fase is None:
            return None
        bi = fase.boss_instancia
        if bi is not None and bi.vivo and bi.x == x and bi.y == y:
            return bi
        return None

    def inimigos_vivos(self):
        """Conta inimigos vivos na fase atual."""
        fase = self.fase_atual
        if fase is None:
            return 0
        return sum(1 for i in fase.inimigos_instancia if i.vivo)

    def saida_liberada(self):
        """Saida fica liberada se nao houver boss bloqueando ou se ele
        ja estiver morto. Chaves nao bloqueiam por enquanto."""
        fase = self.fase_atual
        if fase is None:
            return False
        bi = fase.boss_instancia
        if bi is not None and bi.vivo:
            tipo = self.bosses.get(bi.codigo)
            if tipo is not None and tipo.bloqueia_saida:
                return False
        return True

    def indice_da_fase(self, fase):
        """Retorna o indice de uma fase em self.fases ou -1."""
        for i, f in enumerate(self.fases):
            if f is fase:
                return i
        return -1

    def tem_proxima_fase(self):
        """Existe alguma fase apos a atual na ordem carregada."""
        if self.fase_index < 0:
            return False
        return self.fase_index + 1 < len(self.fases)

    def proxima_fase(self):
        """Retorna a proxima fase na ordem ou None."""
        if not self.tem_proxima_fase():
            return None
        return self.fases[self.fase_index + 1]

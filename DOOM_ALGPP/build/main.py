"""
main.py
Ponto de entrada do DoomALG++ Runtime.

Fluxo de alto nivel:
    1. Prepara o terminal e a thread de input.
    2. Le e parseia scripts/doom.algpp uma unica vez.
    3. Roda um loop de telas:
         menu -> jogo -> tela final (vitoria ou derrota) -> menu.
       O bloco de creditos eh acessivel pelo menu.
    4. Sair limpo restaurando cursor e terminal.

Durante o jogo, tres ritmos coexistem:
    - leitura de teclado: nao bloqueante (~10 ms);
    - tick de IA: intervalo fixo (~0.5 s);
    - render: limitado pelo fps configurado.

A logica de jogo (movimento, tiro, recarga, troca de arma, coleta,
IA, ataques) vive em runtime/gameplay.py e runtime/ai.py. Os dados
(armas, inimigos, bosses, fases, sprites) vem dos arquivos .algpp.
"""

import os
import sys
import time

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

from runtime import terminal, input_thread, gameplay, ai, telas
from runtime.parser import parsear_arquivo, ErroDeSintaxe
from runtime.interpreter import montar_estado, avancar_fase
from runtime.renderer import desenhar


INTERVALO_AI = 0.5
INTERVALO_INPUT = 0.01
TEMPO_VITORIA_FINAL = 0.5
TEMPO_DERROTA = 1.5


def _resolver_caminho_script(nome="doom.algpp"):
    """Procura scripts/<nome> ao lado do main.py, no bundle do
    PyInstaller (sys._MEIPASS) ou no diretorio atual."""
    candidatos = [os.path.join(BASE_DIR, "scripts", nome)]
    meipass = getattr(sys, "_MEIPASS", None)
    if meipass:
        candidatos.append(os.path.join(meipass, "scripts", nome))
    candidatos.append(os.path.join(os.getcwd(), "scripts", nome))
    for c in candidatos:
        if os.path.isfile(c):
            return c
    return candidatos[0]


_TECLAS_MOVIMENTO_2D = {"w", "s", "a", "d"}


def _aplicar_tecla(st, tecla):
    """Dispara a acao correspondente a tecla.

    No modo 2D, W/A/S/D movem o jogador em quatro direcoes.
    No modo raycast, W/S avancam/recuam no angulo e A/D giram.
    Em ambos os modos, F atira, R recarrega, Z/X trocam de arma
    e Q sai. Retorna False quando o jogador pediu para sair."""
    if tecla is None:
        return True
    t = tecla.lower()
    if st.modo_renderizacao == "raycast":
        if t in ("w", "s"):
            gameplay.andar_raycast(st, t)
            return True
        if t == "a":
            gameplay.virar_esq(st)
            return True
        if t == "d":
            gameplay.virar_dir(st)
            return True
    else:
        if t in _TECLAS_MOVIMENTO_2D:
            gameplay.andar(st, t)
            return True
    if t == "f":
        gameplay.atirar(st)
        return True
    if t == "r":
        gameplay.recarregar(st)
        return True
    if t == "z":
        gameplay.arma_anterior(st)
        return True
    if t == "x":
        gameplay.proxima_arma(st)
        return True
    if t == "q":
        gameplay.sair(st)
        return False
    return True


def _processar_transicao(st, agora):
    """Avanca para a proxima fase se a atual concluiu e o tempo de
    transicao acabou. Retorna True se a fase mudou."""
    fase = st.fase_atual
    if fase is None or not fase.concluida:
        return False
    if st.transicao_inicio is None:
        st.transicao_inicio = agora
        st.mensagem = "Fase concluida"
        return False
    if agora - st.transicao_inicio < st.transicao_duracao:
        return False
    if st.tem_proxima_fase():
        avancar_fase(st)
        return True
    avancar_fase(st)
    return False


def _loop_jogo(st):
    """Loop principal de gameplay. Retorna quando o jogador morre,
    vence a campanha ou pede para sair."""
    intervalo_render = 1.0 / max(1, st.fps)
    desenhar(st)
    ultimo_render = time.monotonic()
    ultimo_ai = ultimo_render
    tick = 0
    while st.rodando:
        agora = time.monotonic()
        tecla = input_thread.proxima_tecla(timeout=0.0)
        if tecla is not None:
            _aplicar_tecla(st, tecla)
        if not st.rodando:
            return
        if not st.vitoria_final and not st.derrota:
            fase = st.fase_atual
            if fase is None or not fase.concluida:
                if agora - ultimo_ai >= INTERVALO_AI:
                    tick += 1
                    ai.atualizar(st, tick)
                    ultimo_ai = agora
            else:
                _processar_transicao(st, agora)
        if agora - ultimo_render >= intervalo_render:
            desenhar(st)
            ultimo_render = agora
        if st.derrota:
            desenhar(st)
            time.sleep(TEMPO_DERROTA)
            return
        if st.vitoria_final:
            desenhar(st)
            time.sleep(TEMPO_VITORIA_FINAL)
            return
        time.sleep(INTERVALO_INPUT)


def _executar_uma_partida(decls):
    """Carrega um GameState novo a partir dos decls e roda uma
    partida ate o fim. Retorna o GameState final."""
    st = montar_estado(decls)
    _loop_jogo(st)
    return st


def executar(caminho_script=None):
    """Loop de telas: menu -> jogo -> tela final -> menu.
    Sai do programa apenas quando o jogador escolhe Sair no menu."""
    if caminho_script is None:
        caminho_script = _resolver_caminho_script()
    if not os.path.isfile(caminho_script):
        print("Nao encontrei o script principal:", caminho_script)
        print("Esperado em build/scripts/doom.algpp")
        return 1
    try:
        decls = parsear_arquivo(caminho_script)
    except ErroDeSintaxe as e:
        print("Erro de sintaxe no Portugol++:", e)
        return 2
    terminal.preparar()
    terminal.limpar_tela()
    terminal.esconder_cursor()
    input_thread.iniciar()
    estado_inicial = montar_estado(decls)
    try:
        while True:
            opcao = telas.menu(estado_inicial)
            if opcao == "sair":
                break
            if opcao == "creditos":
                telas.creditos(estado_inicial)
                continue
            if opcao == "jogar":
                terminal.limpar_tela()
                st = _executar_uma_partida(decls)
                if st.derrota:
                    telas.tela_derrota(st)
                elif st.vitoria_final:
                    telas.tela_vitoria(st)
                terminal.limpar_tela()
        telas.tela_saida(estado_inicial)
    finally:
        input_thread.parar()
        terminal.mostrar_cursor()
        terminal.escrever("\n")
        terminal.descarregar()
    return 0


if __name__ == "__main__":
    sys.exit(executar())

"""
runtime/input_thread.py
Captura de teclado sem precisar de Enter.

No Windows usa msvcrt.kbhit / msvcrt.getwch (sem bloquear o jogo).
Em Unix usa termios + select para o mesmo efeito.

A thread coloca cada tecla em uma fila (queue.Queue) que o loop
principal consome.
"""

import os
import queue
import sys
import threading
import time


_fila = queue.Queue()
_parar = threading.Event()
_thread = None


def _ler_win():
    import msvcrt
    while not _parar.is_set():
        if msvcrt.kbhit():
            try:
                ch = msvcrt.getwch()
            except Exception:
                ch = ""
            if ch:
                _fila.put(ch)
        else:
            time.sleep(0.01)


def _ler_unix():
    import select
    import termios
    import tty
    fd = sys.stdin.fileno()
    antigo = termios.tcgetattr(fd)
    try:
        tty.setcbreak(fd)
        while not _parar.is_set():
            r, _, _ = select.select([sys.stdin], [], [], 0.05)
            if r:
                ch = sys.stdin.read(1)
                if ch:
                    _fila.put(ch)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, antigo)


def iniciar():
    """Inicia a thread de captura de teclado."""
    global _thread
    if _thread is not None:
        return
    _parar.clear()
    alvo = _ler_win if os.name == "nt" else _ler_unix
    _thread = threading.Thread(target=alvo, daemon=True)
    _thread.start()


def parar():
    """Sinaliza a thread para encerrar."""
    _parar.set()


def proxima_tecla(timeout=0.0):
    """
    Retorna a proxima tecla da fila ou None se nao houver.
    Se timeout > 0, espera por esse tempo no maximo.
    """
    try:
        if timeout > 0:
            return _fila.get(timeout=timeout)
        return _fila.get_nowait()
    except queue.Empty:
        return None


def descarregar_fila():
    """Esvazia a fila atual (util ao trocar de tela)."""
    while True:
        try:
            _fila.get_nowait()
        except queue.Empty:
            return

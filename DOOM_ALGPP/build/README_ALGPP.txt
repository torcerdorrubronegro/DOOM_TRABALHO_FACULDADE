DoomALG++ Runtime
=================

Esta pasta contem o codigo-fonte da segunda versao do trabalho.
A primeira versao (doom.alg, Portugol/VisuALG) fica em DOOM_ALG/
e nao deve ser modificada.

Como funciona:
    - o jogo eh descrito em arquivos .algpp (Portugol++);
    - o Python le, interpreta e renderiza no terminal;
    - o terminal aceita teclas sem ENTER, mostra cores ANSI e
      desenha o mundo em primeira pessoa por raycasting 2.5D.

O Python NAO eh o jogo. O Python eh o runtime.


ESTRUTURA
---------

build/
  main.py                  ponto de entrada
  build_exe.bat            empacota tudo em ..\doom.exe
  requirements.txt         dependencias Python
  README_ALGPP.txt         este arquivo
  runtime/
    terminal.py            limpar tela, posicionar cursor
    colors.py              tabela de cores ANSI
    renderer.py            despachante entre 2D e raycast
    renderer_raycast.py    renderer pseudo-3D
    input_thread.py        captura sem ENTER
    parser.py              le .algpp e produz declaracoes
    interpreter.py         transforma declaracoes em GameState
    game_state.py          dados de runtime
    gameplay.py            acoes do jogador
    ai.py                  IA dos inimigos e do boss
    telas.py               menu, creditos, vitoria, derrota
  scripts/
    doom.algpp             script principal e configuracao
    fases.algpp            mapas e objetivos
    armas.algpp            definicao das armas
    inimigos.algpp         tipos de inimigo
    bosses.algpp           chefes
    sprites.algpp          sprites ASCII grandes
  docs/
    SINTAXE_ALGPP.txt      referencia da sintaxe Portugol++


COMO RODAR COM PYTHON
---------------------

1. Ter Python 3.8 ou superior instalado.
2. Abrir um terminal nesta pasta build\.
3. (Recomendado no Windows) instalar colorama:

       python -m pip install -r requirements.txt

4. Executar:

       python main.py


MENU INICIAL
------------

Ao iniciar, aparece o menu com tres opcoes:

    1 - Jogar
    2 - Creditos
    3 - Sair

Pressione a tecla correspondente. Q tambem sai do menu.


CONTROLES DURANTE O JOGO
------------------------

A configuracao padrao usa o renderer raycast 2.5D. Os controles
sao do estilo FPS classico:

    W   andar para frente (na direcao do olhar)
    S   recuar
    A   girar a esquerda 15 graus
    D   girar a direita 15 graus
    F   atirar com a arma equipada
    R   recarregar a arma
    Z   arma anterior
    X   proxima arma
    Q   sair (volta ao menu)

Itens no chao sao coletados ao andar sobre eles:

    K   kit de vida
    A   municao
    C   chave
    W   arma coletavel (libera a proxima arma da campanha)

A saida da fase aparece como X. Algumas fases exigem chave; a
ultima exige derrotar o chefe.

Modo 2D top-down ainda existe e pode ser ativado em
scripts/doom.algpp trocando:

    renderizacao raycast
        por
    renderizacao mapa

No modo 2D, W/A/S/D voltam a ser quatro direcoes cardinais.


HUD
---

O HUD mostra, em qualquer modo:

    - vida com barra e numeros;
    - arma atual e municao com barra;
    - dano da arma;
    - chave coletada (sim/nao);
    - nome da fase;
    - objetivo da fase;
    - inimigos restantes;
    - se a saida esta liberada;
    - mensagem curta da ultima acao;
    - barra de vida do chefe, quando ele aparece.

Em raycast, o HUD vai no topo e no rodape, deixando a cena
central limpa.


RAYCASTING 2.5D
---------------

Para cada coluna da tela:

    1. Calcula o angulo do raio a partir do FOV e do angulo do
       jogador.
    2. Avanca em passos pequenos pelo mapa ate bater em parede
       ou estourar a distancia maxima.
    3. Corrige o efeito olho-de-peixe multiplicando pela
       diferenca de angulo.
    4. Calcula a altura da coluna de parede pela distancia.
    5. Desenha teto, parede e chao na coluna.

Entidades (inimigos vivos, boss vivo, itens, saida) sao
projetadas em cima das colunas usando o sprite declarado em
sprites.algpp. Cada entidade passa pelo depth buffer antes de
ser pintada, entao paredes na frente escondem o sprite.

A arma equipada eh desenhada centralizada na parte inferior da
cena, usando o sprite arma_<codigo>.

E raycasting 2.5D, nao raytracing real. Nao ha sombras suaves,
reflexos nem assets externos.


COMO GERAR doom.exe
-------------------

Na pasta build\, executar:

    build_exe.bat

O script instala dependencias (colorama, pyinstaller) e
empacota com --onefile. O arquivo final eh gerado em:

    DOOM_ALGPP\doom.exe


COMO O JOGO EH DESCRITO
-----------------------

scripts/doom.algpp eh o script principal. Ele:

    - declara configuracao, cores e estado inicial do jogador;
    - importa os outros arquivos .algpp com "usar";
    - inicia a primeira fase com "iniciar fase".

Cada fase tem seu mapa ASCII em "mapa inicio ... fimmapa".
Cada arma, inimigo, boss e sprite tem seu proprio bloco em
arquivos separados. Sprites grandes ficam em sprites.algpp.

A sintaxe completa esta em docs/SINTAXE_ALGPP.txt.


O QUE ESTA PRONTO
-----------------

PP0  estrutura base do runtime
PP6.5 raycasting 2.5D
PP7  armas, tiros, itens, recarga, troca de arma
PP8  inimigos com IA por tick, boss, dano, derrota, vitoria
PP8.1 progressao de fases pelo X
PP9  sprites grandes, HUD colorido, menu, creditos e telas
     de vitoria/derrota


O QUE VEM DEPOIS
----------------

PP10 polimento final e doom.exe definitivo

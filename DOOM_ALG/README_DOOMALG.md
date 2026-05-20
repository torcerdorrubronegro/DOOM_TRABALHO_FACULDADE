README - DoomALG
================

Projeto: DoomALG
Disciplina: ALGORITMOS E ESTRUTURAS DE DADOS
Professor: MAXWELL GOMES DA SILVA

Alunos:
Marcell Alves Resende             RA: 5178278
Pedro Andrade Santos              RA: 5180749
Davi Augusto Alves de Assis       RA: 5181548


============================================================
PARTE 1 - MARCELL - VISAO GERAL
============================================================

DoomALG e um jogo em primeira pessoa em texto, feito em
Portugol para rodar no VisuALG 3.

A entrega principal do trabalho e:

    DOOM_ALG/doom.alg

Essa e a versao oficial para avaliacao.

O jogo tem:
- menu;
- modo normal;
- modo apresentacao;
- ajuda;
- creditos;
- 5 fases;
- armas;
- municao;
- inimigos;
- chefe final;
- itens;
- chave;
- saida;
- vitoria;
- derrota.

Fala curta sugerida:
"Nosso projeto e o DoomALG. A versao principal foi feita em
Portugol e roda diretamente no VisuALG. O jogador atravessa
fases, coleta itens, usa armas, enfrenta inimigos e precisa
derrotar o chefe final para vencer."


============================================================
PARTE 2 - PEDRO - COMO ABRIR E JOGAR
============================================================

Como abrir:

1. Abra o VisuALG 3.
2. Abra o arquivo doom.alg.
3. Pressione F9.
4. Escolha uma opcao no menu.

Menu:

    1 - Jogar
    2 - Modo apresentacao
    3 - Ajuda
    4 - Creditos
    5 - Sair

Controles:

    W   andar para frente
    S   recuar
    A   girar para esquerda
    D   girar para direita
    F   atirar
    R   recarregar
    Z   arma anterior
    X   proxima arma
    H   ajuda
    Q   sair para o menu

Comandos compostos:

O VisuALG precisa de ENTER para ler comandos. Para deixar o
jogo mais rapido, o DoomALG aceita ate 8 comandos em uma
unica entrada.

Exemplos:

    WWW       anda tres vezes
    FFR       atira, atira e recarrega
    ZXF       troca arma e atira
    AWAWDS    combina giro e movimento

Fala curta sugerida:
"O jogo usa controles simples. Como o VisuALG nao captura
tecla em tempo real, criamos comandos compostos. Assim, em
vez de apertar ENTER para cada passo, o jogador pode digitar
WWW ou FFR e o jogo executa tudo em sequencia."


============================================================
PARTE 3 - PEDRO - ITENS, ARMAS E OBJETIVOS
============================================================

Itens:

    K   kit de vida
    A   municao
    C   chave
    W   arma coletavel
    X   saida

Armas:

    PISTOLA
    SHOTGUN
    RIFLE
    CANNON

A pistola comeca desbloqueada. As outras armas aparecem ao
longo das fases por meio do item W.

Objetivo das fases:

    Fase 1 - chegar na saida.
    Fase 2 - pegar a chave e chegar na saida.
    Fase 3 - enfrentar inimigos variados e chegar na saida.
    Fase 4 - pegar a chave, liberar o caminho e chegar na saida.
    Fase 5 - derrotar o chefe final e vencer.

Fala curta sugerida:
"Cada fase tem um objetivo. Em algumas basta chegar ate o X.
Em outras, a saida fica bloqueada ate pegar uma chave ou
derrotar o chefe. As armas melhoram durante a campanha:
pistola, shotgun, rifle e cannon."


============================================================
PARTE 4 - DAVI - LOGICA DA VERSAO VISUALG
============================================================

A versao em VisuALG usa:

- matriz para o mapa;
- matriz para a tela;
- vetores para inimigos;
- vetores para armas;
- procedimentos para dividir a logica;
- condicionais para regras do jogo;
- lacos de repeticao para menu, fases e comandos.

O mapa tem 12 linhas por 24 colunas.

Cada celula do mapa guarda um caractere:

    .   chao
    #   parede
    K   kit
    A   municao
    C   chave
    W   arma
    X   saida

A tela e montada em outra matriz, com 36 linhas por 120
colunas. O jogo primeiro escreve tudo nessa matriz e depois
imprime a tela completa.

A visao em primeira pessoa da versao VisuALG e simulada por
faixas. O jogo verifica a distancia ate paredes, itens,
inimigos e chefe, e desenha a cena em ASCII.

Fala curta sugerida:
"A parte tecnica principal e que o jogo usa duas matrizes:
uma para o mapa e outra para montar a tela. Tambem usamos
vetores para controlar armas e inimigos. A visao em primeira
pessoa e uma simulacao feita com faixas de distancia."


============================================================
PARTE 5 - DAVI - INIMIGOS E CHEFE
============================================================

Inimigos:

    G   GRUNT       basico
    B   BRUTE       mais resistente
    S   STALKER     mais rapido
    P   SPITTER     ataque a distancia
    N   SENTINEL    guarda areas

Os inimigos ficam em vetores com posicao, vida, tipo e estado
de vivo ou morto.

Eles perseguem o jogador por turno. A logica tenta aproximar
o inimigo pelo eixo mais importante, respeitando paredes,
outros inimigos e a posicao do chefe.

Chefe final:

    OVERLORD ASCII

Na fase 5, a saida fica bloqueada enquanto o chefe estiver
vivo. Quando a vida do chefe chega a zero, a saida e liberada.

Fala curta sugerida:
"Os inimigos possuem tipos diferentes. Alguns perseguem mais
rapido, outros causam mais dano, e o SPITTER consegue atacar
a distancia. Na ultima fase existe o OVERLORD, que bloqueia
a saida ate ser derrotado."


============================================================
PARTE 6 - MARCELL - MODO APRESENTACAO
============================================================

O modo apresentacao e a opcao 2 do menu.

Ele foi criado para demonstrar o projeto com mais seguranca.

Nesse modo:
- o jogador tem mais vida;
- a municao e maior;
- algumas armas comecam liberadas;
- existem menos inimigos;
- o chefe final fica mais acessivel.

Fala curta sugerida:
"Para a apresentacao, criamos um modo proprio. Ele nao muda a
ideia do jogo, mas deixa a demonstracao mais segura e mais
rapida, evitando que o jogador morra cedo demais."


============================================================
PARTE 7 - MARCELL - VERSAO ADICIONAL DOOMALG++
============================================================

A versao DoomALG++ fica em:

    DOOM_ALGPP/

Ela e uma versao adicional. Nao substitui o doom.alg.

A ideia e:

    Codigo Portugol++ em arquivos .algpp
    -> parser em Python
    -> interpretador em Python
    -> terminal com cores
    -> input sem ENTER
    -> threads
    -> raycasting 2.5D

O Python nao e apresentado como o jogo principal. Ele funciona
como runtime, ou seja, como o programa que le e executa os
arquivos Portugol++.

O codigo do jogo fica em:

    DOOM_ALGPP/build/scripts/

Arquivos principais:

    doom.algpp       configuracao principal
    fases.algpp      mapas e objetivos
    armas.algpp      armas
    inimigos.algpp   tipos de inimigo
    bosses.algpp     chefe
    sprites.algpp    desenhos ASCII

Para executar:

    cd DOOM_ALGPP\build
    python main.py

Para gerar o executavel:

    cd DOOM_ALGPP\build
    build_exe.bat

Fala curta sugerida:
"Alem da entrega em VisuALG, fizemos uma versao adicional:
DoomALG++. Nela, o jogo continua descrito em uma sintaxe
inspirada em Portugol, mas um runtime em Python interpreta
esse codigo e permite cores, input sem ENTER, threads e
raycasting 2.5D."


============================================================
PARTE 8 - FECHAMENTO - TODOS
============================================================

Frase de fechamento sugerida:

"Com o DoomALG, aplicamos os conceitos de algoritmos em um
jogo completo: matrizes, vetores, procedimentos, repeticoes,
condicionais, entrada e saida. A versao em VisuALG e a
entrega oficial. A versao DoomALG++ e um adicional para
mostrar como a mesma ideia pode evoluir com um runtime
proprio."

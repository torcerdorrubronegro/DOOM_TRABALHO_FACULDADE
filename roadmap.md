ROADMAP FINAL — DOOMALG + DOOMALG++

============================================================
0. OBJETIVO GERAL
============================================================

Projeto:
DoomALG

Disciplina:
ALGORITMOS E ESTRUTURAS DE DADOS

Professor:
MAXWELL GOMES DA SILVA

Alunos:
Marcell Alves Resende
RA: 5178278

Pedro Andrade Santos
RA: 5180749

Davi Augusto Alves de Assis
RA: 5181548

Objetivo principal:
Entregar um jogo feito em Portugol para rodar no VisuALG 3, atendendo ao roteiro oficial do trabalho.

Objetivo adicional:
Mostrar uma versão extra chamada DoomALG++, escrita em Portugol++ e executada por um runtime em Python, como demonstração técnica complementar.

Importante:
A versão oficial é o doom.alg.
A versão DoomALG++ é adicional e não substitui a entrega em VisualG.

============================================================
1. ESTRUTURA FINAL DO REPOSITORIO
============================================================

Estrutura recomendada para o GitHub:

DOOM_TRABALHO_FACULDADE/
│
├── README.md
│
├── DOOM_ALG/
│   ├── doom.alg
│   ├── README_DOOMALG.txt
│   ├── EXPLICACAO_TECNICA.txt
│   ├── ROTEIRO_APRESENTACAO.txt
│   └── roadmap.md
│
├── DOOM_ALGPP/
│   ├── doom.exe
│   └── build/
│       ├── main.py
│       ├── build_exe.bat
│       ├── requirements.txt
│       ├── README_ALGPP.txt
│       │
│       ├── runtime/
│       │   ├── terminal.py
│       │   ├── input_thread.py
│       │   ├── renderer.py
│       │   ├── renderer_raycast.py
│       │   ├── parser.py
│       │   ├── interpreter.py
│       │   ├── game_state.py
│       │   ├── gameplay.py
│       │   ├── ai.py
│       │   ├── colors.py
│       │   ├── telas.py
│       │   └── audio_stub.py
│       │
│       ├── scripts/
│       │   ├── doom.algpp
│       │   ├── fases.algpp
│       │   ├── armas.algpp
│       │   ├── inimigos.algpp
│       │   ├── bosses.algpp
│       │   └── sprites.algpp
│       │
│       └── docs/
│           ├── EXPLICACAO_ALGPP.txt
│           └── SINTAXE_ALGPP.txt
│
└── docs/
    └── imagens_ou_anexos_opcionais/

============================================================
2. README.md DA RAIZ
============================================================

O README.md da raiz deve ser o arquivo principal do repositório.

Ele deve explicar:

1. Nome do projeto.
2. Integrantes e RAs.
3. Disciplina.
4. Professor.
5. Qual é a entrega principal.
6. Como abrir o doom.alg no VisuALG.
7. Como executar com F9.
8. Controles principais.
9. Documentação técnica resumida.
10. Manual de utilização.
11. Explicação de que DOOM_ALGPP é extra.

Texto recomendado para deixar claro:

"Este repositório contém a versão principal do trabalho em VisuALG, localizada em DOOM_ALG/doom.alg. A pasta DOOM_ALGPP contém uma versão adicional e experimental, chamada DoomALG++, criada para demonstrar uma evolução visual do projeto com Portugol++ interpretado por Python. A entrega oficial solicitada pela disciplina é a versão em VisuALG."

============================================================
3. VERSAO OFICIAL — DOOM_ALG
============================================================

Arquivo principal:
DOOM_ALG/doom.alg

Execução:
VisuALG 3, tecla F9.

Status:
Finalizado.

Essa é a versão que deve ser considerada a entrega oficial.

Ela atende ao roteiro porque possui:
- entrada e saída com leia/escreval;
- condicionais;
- laços de repetição;
- matrizes;
- vetores;
- procedimentos;
- jogo interativo;
- documentação;
- manual de uso;
- GitHub público.

O roteiro do professor pede uso de entrada/saída, condicionais, laços e recomenda vetores, matrizes e procedimentos. O doom.alg usa esses pontos de forma direta. :contentReference[oaicite:2]{index=2}

============================================================
4. FUNCIONALIDADES DO DOOM_ALG
============================================================

O doom.alg possui:

- menu principal;
- modo normal;
- modo apresentação;
- ajuda;
- créditos;
- 5 fases;
- visão em primeira pessoa textual;
- minimapa;
- HUD;
- vida;
- munição;
- armas;
- recarga;
- itens;
- chave;
- saída bloqueada;
- comandos compostos;
- inimigos;
- boss final;
- vitória;
- derrota.

Armas:
- PISTOLA;
- SHOTGUN;
- RIFLE;
- CANNON.

Itens:
- K = kit de vida;
- A = munição;
- C = chave;
- W = arma coletável;
- X = saída.

Inimigos:
- GRUNT;
- BRUTE;
- STALKER;
- SPITTER;
- SENTINEL.

Boss:
- OVERLORD ASCII.

Fases:
1. CORREDOR INICIAL
2. ARSENAL ESQUECIDO
3. CAMARA DOS PILARES
4. LABIRINTO DE ACO
5. NUCLEO FINAL

============================================================
5. DOCUMENTACAO DA VERSAO OFICIAL
============================================================

Arquivos atuais:

DOOM_ALG/README_DOOMALG.txt
Explica como abrir, executar, jogar, controles, itens, armas, inimigos, chefe, modo normal e modo apresentação. :contentReference[oaicite:3]{index=3}

DOOM_ALG/EXPLICACAO_TECNICA.txt
Explica mapa, tela, renderização, movimento, comandos compostos, inimigos, chefe, armas, itens, objetivos, modo apresentação, limitações e soluções usadas. :contentReference[oaicite:4]{index=4}

DOOM_ALG/ROTEIRO_APRESENTACAO.txt
Divide a apresentação entre Marcell, Pedro e Davi, com roteiro curto, roteiro longo, plano B e ordem da demonstração. :contentReference[oaicite:5]{index=5}

DOOM_ALG/roadmap.md
Histórico e planejamento do projeto.

Atenção:
Esses arquivos podem continuar em .txt, mas o repositório precisa ter um README.md na raiz resumindo tudo.

============================================================
6. VERSAO EXTRA — DOOM_ALGPP
============================================================

Nome:
DoomALG++

Status:
Adicional / experimental / demonstrativo.

Objetivo:
Mostrar uma evolução do projeto usando uma linguagem própria inspirada em Portugol, chamada Portugol++ ou ALGPP.

Regra principal:
O jogo continua descrito em arquivos .algpp.
Python não é o jogo principal.
Python é o runtime que interpreta, renderiza, captura teclado e executa.

Fluxo:

scripts .algpp
→ parser Python
→ interpreter Python
→ game state
→ renderer terminal
→ input sem Enter
→ threads
→ doom.exe

============================================================
7. ESTRUTURA DO DOOM_ALGPP
============================================================

DOOM_ALGPP/
│
├── doom.exe
│
└── build/
    ├── main.py
    ├── build_exe.bat
    ├── requirements.txt
    ├── README_ALGPP.txt
    │
    ├── runtime/
    │   ├── terminal.py
    │   ├── input_thread.py
    │   ├── renderer.py
    │   ├── renderer_raycast.py
    │   ├── parser.py
    │   ├── interpreter.py
    │   ├── game_state.py
    │   ├── gameplay.py
    │   ├── ai.py
    │   ├── colors.py
    │   ├── telas.py
    │   └── audio_stub.py
    │
    ├── scripts/
    │   ├── doom.algpp
    │   ├── fases.algpp
    │   ├── armas.algpp
    │   ├── inimigos.algpp
    │   ├── bosses.algpp
    │   └── sprites.algpp
    │
    └── docs/
        ├── EXPLICACAO_ALGPP.txt
        └── SINTAXE_ALGPP.txt

============================================================
8. STATUS ATUAL DO DOOM_ALGPP
============================================================

PP0 — BASE DO RUNTIME
Status: concluída.

Criado:
- main.py;
- runtime;
- scripts;
- docs;
- build_exe.bat;
- requirements.txt.

PP1 — TERMINAL COM CORES
Status: concluída parcialmente.

Já existe:
- terminal com ANSI;
- colorama;
- renderer colorido;
- tabela de cores.

Ainda pode melhorar:
- flicker;
- contraste;
- uso da tela;
- composição visual.

PP2 — INPUT SEM ENTER
Status: concluída.

Já existe:
- W/S/A/D;
- F/R/Z/X;
- Q;
- leitura sem Enter.

PP3 — THREADS
Status: concluída parcialmente.

Já existe:
- thread de input;
- loop de render;
- tick de IA.

Ainda pode melhorar:
- sincronização;
- suavidade;
- controle de FPS;
- separação entre render e lógica.

PP4 — PARSER PORTUGOL++
Status: concluída parcialmente.

Já reconhece:
- algoritmo/fimalgoritmo;
- usar;
- configuracao;
- cores;
- jogador;
- fase;
- mapa;
- arma;
- inimigo;
- boss;
- sprite;
- objetivo;
- iniciar fase.

Ainda pode expandir:
- configurações visuais;
- alcance de visão;
- velocidade de giro;
- textura de parede;
- textura de chão;
- parâmetros de câmera.

PP5 — MAPA E MOVIMENTO
Status: concluída.

Já existe:
- mapa carregado de .algpp;
- jogador;
- posição;
- colisão;
- direção;
- saída;
- pickups.

PP6.5 — RAYCASTING 2.5D
Status: concluída.

Já existe:
- visão em pseudo-3D;
- paredes em perspectiva;
- teto;
- chão;
- depth buffer;
- minimapa;
- entidades projetadas;
- tiro por ângulo;
- modo 2D preservado.

Ainda precisa melhorar:
- profundidade;
- textura;
- leitura de chão;
- leitura de teto;
- contraste;
- escala de sprites;
- FOV;
- sensação de FPS.

PP7 — ARMAS, TIRO E ITENS
Status: concluída.

Já existe:
- pistola;
- shotgun;
- rifle;
- cannon;
- tiro;
- dano;
- recarga;
- troca de arma;
- K/A/C/W/X.

Ainda precisa melhorar:
- sprites das armas;
- feedback de tiro;
- flash;
- mira;
- armas apontadas para frente.

PP8 — INIMIGOS E BOSS DINAMICOS
Status: concluída.

Já existe:
- GRUNT;
- BRUTE;
- STALKER;
- SPITTER;
- SENTINEL;
- OVERLORD;
- IA por tick;
- dano;
- morte;
- vitória;
- derrota.

Ainda precisa melhorar:
- alcance dos monstros;
- campo de visão;
- ataque justo;
- comportamento previsível;
- leitura visual dos inimigos.

PP8.1 — PROGRESSAO DE FASES
Status: concluída.

Corrigido:
- X passa de fase;
- última fase ativa vitória;
- boss vivo bloqueia saída;
- boss morto libera saída.

PP9 — HUD, TELAS E SPRITES GRANDES
Status: concluída parcialmente.

Já existe:
- menu;
- créditos;
- tela de vitória;
- tela de derrota;
- HUD;
- sprites;
- arma visível;
- entidades no raycast.

Ainda precisa melhorar muito:
- sprites das armas;
- sprites dos itens;
- sprites dos monstros;
- boss;
- mapa;
- raycasting;
- HUD;
- feedback de dano;
- feedback de tiro.

============================================================
9. PROXIMA FASE DO DOOM_ALGPP
============================================================

PP9.5 — POLIMENTO VISUAL E JOGABILIDADE FPS

Objetivo:
Melhorar fortemente o visual e a sensação de jogo antes de criar mais fases ou empacotar.

Essa fase vem antes da PP10.

Prioridades:

1. Melhorar sprites das armas
- pistola deve parecer pistola;
- shotgun deve parecer shotgun;
- rifle deve parecer rifle;
- cannon deve parecer cannon;
- armas devem parecer apontadas para frente;
- sprites devem ficar em scripts/sprites.algpp.

2. Melhorar sprites dos itens
- kit reconhecível;
- munição reconhecível;
- chave reconhecível;
- arma coletável reconhecível;
- saída clara.

3. Melhorar sprites dos monstros
- GRUNT básico;
- BRUTE pesado;
- STALKER agressivo;
- SPITTER criatura de ataque à distância;
- SENTINEL guarda;
- OVERLORD boss final.

4. Melhorar visual do mapa
- paredes mais legíveis;
- chão menos poluído;
- teto discreto;
- mais profundidade;
- melhor contraste;
- salas e corredores reconhecíveis.

5. Melhorar raycasting
- escala das paredes;
- escala dos sprites;
- depth buffer;
- distância de desenho;
- FOV;
- entidades não atravessarem parede.

6. Melhorar rotação do jogador
- A/D devem girar de forma mais natural;
- reduzir giro brusco;
- melhorar sensação de câmera;
- manter controles simples.

7. Melhorar movimento
- W/S devem parecer mais fluidos;
- manter colisão;
- evitar travar em cantos;
- não deixar rápido demais.

8. Melhorar alcance dos monstros
- corpo a corpo claro;
- SPITTER com distância entendível;
- boss forte, mas justo;
- dados continuam vindo de .algpp.

9. Melhorar feedback
- tiro;
- recarga;
- sem munição;
- dano recebido;
- inimigo atingido;
- boss atingido;
- item coletado;
- saída bloqueada;
- saída liberada.

Critério:
python main.py deve abrir um jogo mais bonito, legível e apresentável.

============================================================
10. FASES FUTURAS DO DOOM_ALGPP
============================================================

PP10 — CAMPANHA COMPLETA

Objetivo:
Expandir DoomALG++ para campanha completa.

Somente iniciar depois da PP9.5.

Implementar:
- pelo menos 5 fases;
- progressão de armas;
- progressão de dificuldade;
- mapas melhores;
- itens distribuídos;
- boss final;
- modo apresentação opcional.

PP10.5 — BALANCEAMENTO GERAL

Objetivo:
Ajustar:
- vida;
- munição;
- dano;
- cadência;
- alcance dos monstros;
- alcance do boss;
- distribuição de itens;
- duração da demo.

PP11 — EMPACOTAR EM doom.exe

Objetivo:
Gerar executável final com PyInstaller.

Saída:
DOOM_ALGPP/doom.exe

O código-fonte continua em:
DOOM_ALGPP/build/

PP11.5 — TESTE DO EXECUTAVEL

Verificar:
- abre por duplo clique;
- scripts embutidos funcionam;
- cores aparecem;
- input sem Enter funciona;
- fecha limpo;
- não exige Python no computador da apresentação.

PP12 — DOCUMENTACAO DO ALGPP

Atualizar:
- README_ALGPP.txt;
- SINTAXE_ALGPP.txt;
- EXPLICACAO_ALGPP.txt.

Explicar:
- Portugol++;
- runtime Python;
- scripts .algpp;
- raycasting;
- cores;
- input sem Enter;
- threads;
- geração do exe.

PP13 — APRESENTACAO DAS DUAS VERSOES

Ordem:
1. Mostrar DOOM_ALG/doom.alg no VisuALG.
2. Explicar que essa é a entrega oficial.
3. Rodar modo apresentação.
4. Mostrar movimento, tiro, minimapa, boss.
5. Abrir DOOM_ALGPP/doom.exe.
6. Explicar que é adicional.
7. Mostrar cores, input sem Enter e visão 3D por raycasting.
8. Encerrar reforçando que a versão exigida é a do VisuALG.

============================================================
11. ENTREGA NO GITHUB
============================================================

O repositório deve ser público.

Deve conter obrigatoriamente:
- README.md na raiz;
- DOOM_ALG/doom.alg;
- documentação técnica;
- manual de utilização.

O README.md da raiz deve apontar claramente para:
- versão oficial: DOOM_ALG/doom.alg;
- documentação: DOOM_ALG/README_DOOMALG.txt;
- explicação técnica: DOOM_ALG/EXPLICACAO_TECNICA.txt;
- roteiro: DOOM_ALG/ROTEIRO_APRESENTACAO.txt;
- adicional: DOOM_ALGPP/.

Critério:
O professor deve conseguir abrir o GitHub, encontrar o doom.alg e executar no VisuALG sem depender do DoomALG++.

============================================================
12. REGRAS GERAIS
============================================================

Para DOOM_ALG:
- não alterar doom.alg sem necessidade;
- não adicionar recursos novos;
- só correções críticas.

Para DOOM_ALGPP:
- trabalhar apenas em DOOM_ALGPP/build;
- manter scripts .algpp como fonte dos dados;
- Python é runtime;
- não hardcodar jogo inteiro em Python;
- não empacotar antes de estar visualmente bom;
- não expandir campanha antes do visual estar legível.

============================================================
13. FRASE OFICIAL PARA APRESENTAR
============================================================

"A primeira versão roda diretamente no VisuALG, como pedido no trabalho. A segunda versão é um adicional: criamos uma sintaxe inspirada em Portugol, chamada Portugol++, e usamos Python apenas como runtime para interpretar esse código e renderizar recursos que o VisuALG não oferece, como cores, input sem Enter e visão em raycasting."
# DoomALG

Projeto da disciplina **ALGORITMOS E ESTRUTURAS DE DADOS**.

Professor: **MAXWELL GOMES DA SILVA**

Integrantes:

- Marcell Alves Resende - RA: 5178278
- Pedro Andrade Santos - RA: 5180749
- Davi Augusto Alves de Assis - RA: 5181548

## Entrega principal

A entrega principal do trabalho esta em:

```text
DOOM_ALG/doom.alg
```

Esse arquivo deve ser aberto no **VisuALG 3** e executado com **F9**.

A pasta `DOOM_ALGPP/` contem uma versao adicional chamada **DoomALG++**. Ela nao substitui a versao em VisuALG. Ela serve apenas como demonstracao extra de uma evolucao do projeto, usando uma sintaxe inspirada em Portugol interpretada por Python.

## Estrutura do repositorio

```text
DOOM_TRABALHO_FACULDADE/
|
|-- README.md
|
|-- DOOM_ALG/
|   |-- doom.alg
|   |-- README_DOOMALG.txt
|   |-- EXPLICACAO_TECNICA.txt
|   |-- ROTEIRO_APRESENTACAO.txt
|   |-- POSSIVEIS_DUVIDAS.txt
|   |-- roadmap.md
|
|-- DOOM_ALGPP/
|   |-- doom.exe
|   |-- build/
|       |-- main.py
|       |-- build_exe.bat
|       |-- requirements.txt
|       |-- README_ALGPP.txt
|       |-- runtime/
|       |-- scripts/
|       |-- docs/
```

## Como executar a versao oficial

1. Abra o VisuALG 3.
2. Abra o arquivo `DOOM_ALG/doom.alg`.
3. Pressione F9.
4. No menu do jogo, escolha uma opcao.

Menu:

```text
1 - Jogar
2 - Modo apresentacao
3 - Ajuda
4 - Creditos
5 - Sair
```

## Controles da versao em VisuALG

```text
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
```

O VisuALG exige ENTER para ler comandos. Por isso, o DoomALG aceita comandos compostos de ate 8 letras.

Exemplos:

```text
WWW     anda 3 vezes
FFR     atira, atira e recarrega
ZXF     troca arma e atira
AWAWDS  combina giros e movimento
```

## Objetivo do jogo

O jogador deve atravessar 5 fases, enfrentar inimigos, coletar itens, usar armas, encontrar chaves e chegar ate a saida. Na ultima fase, a saida so libera depois que o chefe final e derrotado.

Fases:

1. CORREDOR INICIAL
2. ARSENAL ESQUECIDO
3. CAMARA DOS PILARES
4. LABIRINTO DE ACO
5. NUCLEO FINAL

## Itens

```text
K   kit de vida
A   municao
C   chave
W   arma coletavel
X   saida da fase
```

## Armas

```text
PISTOLA
SHOTGUN
RIFLE
CANNON
```

A pistola comeca liberada. As outras armas sao liberadas ao longo das fases.

## Inimigos

```text
G   GRUNT
B   BRUTE
S   STALKER
P   SPITTER
N   SENTINEL
```

O chefe final e o **OVERLORD ASCII**.

## Modo apresentacao

O modo apresentacao foi criado para demonstrar o jogo em sala com menos risco de morrer rapidamente.

Ele possui:

- mais vida;
- mais municao;
- armas liberadas mais cedo;
- menos inimigos;
- chefe final mais acessivel.

## DoomALG++

A pasta `DOOM_ALGPP/` contem uma versao adicional.

Ela usa:

```text
scripts .algpp
-> parser em Python
-> interpretador em Python
-> terminal com cores
-> input sem ENTER
-> threads
-> raycasting 2.5D
```

O jogo continua descrito em uma sintaxe inspirada em Portugol. O Python funciona como runtime: ele le os arquivos `.algpp`, monta o estado do jogo, renderiza o terminal e captura o teclado sem ENTER.

Para executar com Python:

```bat
cd DOOM_ALGPP\build
python -m pip install -r requirements.txt
python main.py
```

Para gerar o executavel:

```bat
cd DOOM_ALGPP\build
build_exe.bat
```

O executavel final fica em:

```text
DOOM_ALGPP/doom.exe
```

## Divisao da apresentacao

### Marcell

Apresenta o projeto, explica a entrega principal, abre o jogo no VisuALG e conduz a demonstracao.

### Pedro

Explica os controles, comandos compostos, armas, itens, chave, saida e modo apresentacao.

### Davi

Explica a logica interna: matriz do mapa, matriz da tela, inimigos, boss, fases, objetivos e a ideia da versao DoomALG++.

## Documentos de apoio

```text
DOOM_ALG/README_DOOMALG.txt
DOOM_ALG/EXPLICACAO_TECNICA.txt
DOOM_ALG/ROTEIRO_APRESENTACAO.txt
DOOM_ALG/POSSIVEIS_DUVIDAS.txt
DOOM_ALGPP/build/README_ALGPP.txt
DOOM_ALGPP/build/docs/SINTAXE_ALGPP.txt
```

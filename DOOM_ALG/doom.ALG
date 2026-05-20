algoritmo "DoomALG"

var
   tela: vetor[1..36,1..120] de caractere
   mapa: vetor[1..12,1..24] de caractere
   spriteIniG: vetor[1..7,1..15] de caractere
   spriteIniM: vetor[1..5,1..11] de caractere
   spriteIniP: vetor[1..3,1..7] de caractere
   spriteSaiG: vetor[1..6,1..14] de caractere
   spriteSaiP: vetor[1..4,1..10] de caractere
   spriteArmaN: vetor[1..8,1..31] de caractere
   spriteArmaT: vetor[1..8,1..31] de caractere
   spriteArmaV: vetor[1..8,1..31] de caractere
   digito: vetor[0..9] de caractere
   inimigoX: vetor[1..10] de inteiro
   inimigoY: vetor[1..10] de inteiro
   inimigoVivo: vetor[1..10] de logico
   inimigoTipo: vetor[1..10] de inteiro
   inimigoVida: vetor[1..10] de inteiro
   spriteBossG: vetor[1..5,1..11] de caractere
   spriteBossM: vetor[1..7,1..15] de caractere
   spriteBossP: vetor[1..9,1..21] de caractere
   spriteShotN: vetor[1..8,1..31] de caractere
   spriteShotT: vetor[1..8,1..31] de caractere
   spriteShotV: vetor[1..8,1..31] de caractere
   spriteShotR: vetor[1..8,1..31] de caractere
   spriteRifleN: vetor[1..8,1..31] de caractere
   spriteRifleT: vetor[1..8,1..31] de caractere
   spriteRifleV: vetor[1..8,1..31] de caractere
   spriteRifleR: vetor[1..8,1..31] de caractere
   spriteCannN: vetor[1..8,1..31] de caractere
   spriteCannT: vetor[1..8,1..31] de caractere
   spriteCannV: vetor[1..8,1..31] de caractere
   spriteCannR: vetor[1..8,1..31] de caractere
   spriteItemK: vetor[1..3,1..7] de caractere
   spriteItemA: vetor[1..3,1..7] de caractere
   spriteItemC: vetor[1..3,1..7] de caractere
   spriteItemW: vetor[1..3,1..7] de caractere
   armaAtual: inteiro
   armaDesbloqueada: vetor[1..4] de logico
   armaAmmo: vetor[1..4] de inteiro
   armaAmmoMax: vetor[1..4] de inteiro
   armaDano: vetor[1..4] de inteiro
   armaNome: vetor[1..4] de caractere
   temChave: logico
   wPickupArma: inteiro
   ultimoItemColetado: caractere
   armasColetadasTot: inteiro
   chavesColetadas: inteiro
   exigeChave: logico
   saidaLiberada: logico
   faseNome: vetor[1..5] de caractere
   tutorialMostrado: logico
   modoDemo: logico
   entradaCmd: caractere
   letraCmd: caractere
   indiceCmd: inteiro
   totalCmd: inteiro
   limiteCmd: inteiro
   executadosCmd: inteiro
   andouQtd: inteiro
   disparosQtd: inteiro
   trocouArmaQtd: inteiro
   seqAtiva: logico
   foiAcao: logico
   pxAntes: inteiro
   pyAntes: inteiro
   resumoCmd: caractere
   limiteAtingido: logico
   bossAtivo: logico
   bossTipoFase: inteiro
   bossX: inteiro
   bossY: inteiro
   bossVivo: logico
   bossVida: inteiro
   bossVidaMax: inteiro
   bossDano: inteiro
   bossNome: caractere
   bossAtacadoFrame: inteiro
   bossDerrotadoEsteJogo: logico
   bossIntroMostrada: logico
   bossBloqueiaSaida: logico
   vitoriaFinalAtiva: logico
   distFaixa: vetor[1..5] de inteiro
   chrFaixa: vetor[1..5] de caractere
   altFaixa: vetor[1..5] de inteiro
   colIniFaixa: vetor[1..5] de inteiro
   colFimFaixa: vetor[1..5] de inteiro
   dxTab: vetor[0..7] de inteiro
   dyTab: vetor[0..7] de inteiro
   lxTab: vetor[0..7] de inteiro
   lyTab: vetor[0..7] de inteiro
   anguloTab: vetor[0..7] de inteiro
   nomeDirTab: vetor[0..7] de caractere
   charDirTab: vetor[0..7] de caractere
   opcao: caractere
   cmd: caractere
   teclaEspera: caractere
   statusMsg: caractere
   armaMsg: caractere
   dirNome: caractere
   dirIcone: caractere
   ch: caractere
   tmpStr: caractere
   barStr: caractere
   fase: inteiro
   vida: inteiro
   vidaMax: inteiro
   ammo: inteiro
   ammoMax: inteiro
   numIni: inteiro
   iniVivos: inteiro
   px: inteiro
   py: inteiro
   dx: inteiro
   dy: inteiro
   lx: inteiro
   ly: inteiro
   dirOct: inteiro
   dirAngulo: inteiro
   nx: inteiro
   ny: inteiro
   passoRay: inteiro
   distF: inteiro
   distL: inteiro
   distMax: inteiro
   colCentro: inteiro
   colBaseSp: inteiro
   linBaseSp: inteiro
   alt: inteiro
   topo: inteiro
   base: inteiro
   spTipo: inteiro
   estadoArma: inteiro
   tiroFrame: inteiro
   danoFrame: inteiro
   vidaBarN: inteiro
   ammoBarN: inteiro
   contFaixa: inteiro
   i: inteiro
   j: inteiro
   k: inteiro
   t: inteiro
   v: inteiro
   dig: inteiro
   pontos: inteiro
   turnos: inteiro
   turnosInimigos: inteiro
   acertouFrame: inteiro
   ammoColetadas: inteiro
   kitsColetados: inteiro
   inimigosMortos: inteiro
   objetivoStr: caractere
   spriteArmaR: vetor[1..8,1..31] de caractere
   bloqueou: logico
   acertou: logico
   faseFim: logico
   ativoMenu: logico
   ativoJogo: logico
   jogou: logico

procedimento ptStr(s: caractere; L: inteiro; C: inteiro)
var k: inteiro
    n: inteiro
inicio
   n <- compr(s)
   para k de 1 ate n faca
   se (L >= 1) e (L <= 36) e (C+k-1 >= 1) e (C+k-1 <= 120) entao
         tela[L, C+k-1] <- copia(s, k, 1)
      fimse
   fimpara
fimprocedimento

procedimento ptChar(chx: caractere; Lin: inteiro; Col: inteiro)
inicio
   se (Lin >= 1) e (Lin <= 36) e (Col >= 1) e (Col <= 120) entao
      tela[Lin, Col] <- chx
   fimse
fimprocedimento

procedimento ptInt(n: inteiro; L: inteiro; C: inteiro)
var v: inteiro
    d: inteiro
    temp: caractere
inicio
   temp <- ""
   v <- n
   se v < 0 entao
      v <- -v
   fimse
   se v = 0 entao
      temp <- "0"
   senao
      enquanto v > 0 faca
         d <- v mod 10
         temp <- digito[d] + temp
         v <- v div 10
      fimenquanto
   fimse
   se n < 0 entao
      temp <- "-" + temp
   fimse
   ptStr(temp, L, C)
fimprocedimento

procedimento ptInt3(n: inteiro; L: inteiro; C: inteiro)
var v: inteiro
    d: inteiro
    temp: caractere
    cnt: inteiro
inicio
   temp <- ""
   v <- n
   se v < 0 entao
      v <- 0
   fimse
   se v = 0 entao
      temp <- "0"
   senao
      enquanto v > 0 faca
         d <- v mod 10
         temp <- digito[d] + temp
         v <- v div 10
      fimenquanto
   fimse
   cnt <- compr(temp)
   enquanto cnt < 3 faca
      temp <- "0" + temp
      cnt <- cnt + 1
   fimenquanto
   ptStr(temp, L, C)
fimprocedimento

procedimento limparBuffer()
var i: inteiro
    j: inteiro
inicio
   para i de 1 ate 36 faca
      para j de 1 ate 120 faca
         tela[i,j] <- " "
      fimpara
   fimpara
fimprocedimento

procedimento imprimirTela()
var i: inteiro
    j: inteiro
    linhaStr: caractere
inicio
   limpatela
   para i de 1 ate 36 faca
      linhaStr <- ""
      para j de 1 ate 120 faca
         linhaStr <- linhaStr + tela[i,j]
      fimpara
      escreval(linhaStr)
   fimpara
fimprocedimento

procedimento inicializarTabelas()
inicio
   dxTab[0] <-  0
   dyTab[0] <- -1
   lxTab[0] <-  1
   lyTab[0] <-  0
   anguloTab[0] <- 0
   nomeDirTab[0] <- "NORTE     "
   charDirTab[0] <- "^"
   dxTab[1] <-  1
   dyTab[1] <- -1
   lxTab[1] <-  1
   lyTab[1] <-  1
   anguloTab[1] <- 45
   nomeDirTab[1] <- "NORDESTE  "
   charDirTab[1] <- "/"
   dxTab[2] <-  1
   dyTab[2] <-  0
   lxTab[2] <-  0
   lyTab[2] <-  1
   anguloTab[2] <- 90
   nomeDirTab[2] <- "LESTE     "
   charDirTab[2] <- ">"
   dxTab[3] <-  1
   dyTab[3] <-  1
   lxTab[3] <- -1
   lyTab[3] <-  1
   anguloTab[3] <- 135
   nomeDirTab[3] <- "SUDESTE   "
   charDirTab[3] <- "Z"
   dxTab[4] <-  0
   dyTab[4] <-  1
   lxTab[4] <- -1
   lyTab[4] <-  0
   anguloTab[4] <- 180
   nomeDirTab[4] <- "SUL       "
   charDirTab[4] <- "v"
   dxTab[5] <- -1
   dyTab[5] <-  1
   lxTab[5] <- -1
   lyTab[5] <- -1
   anguloTab[5] <- 225
   nomeDirTab[5] <- "SUDOESTE  "
   charDirTab[5] <- "L"
   dxTab[6] <- -1
   dyTab[6] <-  0
   lxTab[6] <-  0
   lyTab[6] <- -1
   anguloTab[6] <- 270
   nomeDirTab[6] <- "OESTE     "
   charDirTab[6] <- "<"
   dxTab[7] <- -1
   dyTab[7] <- -1
   lxTab[7] <-  1
   lyTab[7] <- -1
   anguloTab[7] <- 315
   nomeDirTab[7] <- "NOROESTE  "
   charDirTab[7] <- "F"
fimprocedimento

procedimento atualizarDirecao()
inicio
   dx <- dxTab[dirOct]
   dy <- dyTab[dirOct]
   lx <- lxTab[dirOct]
   ly <- lyTab[dirOct]
   dirAngulo <- anguloTab[dirOct]
   dirNome <- nomeDirTab[dirOct]
   dirIcone <- charDirTab[dirOct]
fimprocedimento

procedimento carregar_spriteIniG()
inicio
   spriteIniG[1,1] <- " "
   spriteIniG[1,2] <- " "
   spriteIniG[1,3] <- " "
   spriteIniG[1,4] <- "\"
   spriteIniG[1,5] <- "\"
   spriteIniG[1,6] <- " "
   spriteIniG[1,7] <- " "
   spriteIniG[1,8] <- " "
   spriteIniG[1,9] <- " "
   spriteIniG[1,10] <- " "
   spriteIniG[1,11] <- "/"
   spriteIniG[1,12] <- "/"
   spriteIniG[1,13] <- " "
   spriteIniG[1,14] <- " "
   spriteIniG[1,15] <- " "
   spriteIniG[2,1] <- " "
   spriteIniG[2,2] <- " "
   spriteIniG[2,3] <- " "
   spriteIniG[2,4] <- " "
   spriteIniG[2,5] <- "\"
   spriteIniG[2,6] <- "\"
   spriteIniG[2,7] <- "_"
   spriteIniG[2,8] <- "_"
   spriteIniG[2,9] <- "_"
   spriteIniG[2,10] <- "/"
   spriteIniG[2,11] <- "/"
   spriteIniG[2,12] <- " "
   spriteIniG[2,13] <- " "
   spriteIniG[2,14] <- " "
   spriteIniG[2,15] <- " "
   spriteIniG[3,1] <- " "
   spriteIniG[3,2] <- " "
   spriteIniG[3,3] <- " "
   spriteIniG[3,4] <- "/"
   spriteIniG[3,5] <- "="
   spriteIniG[3,6] <- "="
   spriteIniG[3,7] <- "="
   spriteIniG[3,8] <- "="
   spriteIniG[3,9] <- "="
   spriteIniG[3,10] <- "="
   spriteIniG[3,11] <- "="
   spriteIniG[3,12] <- "\"
   spriteIniG[3,13] <- " "
   spriteIniG[3,14] <- " "
   spriteIniG[3,15] <- " "
   spriteIniG[4,1] <- " "
   spriteIniG[4,2] <- " "
   spriteIniG[4,3] <- " "
   spriteIniG[4,4] <- "|"
   spriteIniG[4,5] <- " "
   spriteIniG[4,6] <- "X"
   spriteIniG[4,7] <- "X"
   spriteIniG[4,8] <- " "
   spriteIniG[4,9] <- "X"
   spriteIniG[4,10] <- "X"
   spriteIniG[4,11] <- " "
   spriteIniG[4,12] <- "|"
   spriteIniG[4,13] <- " "
   spriteIniG[4,14] <- " "
   spriteIniG[4,15] <- " "
   spriteIniG[5,1] <- " "
   spriteIniG[5,2] <- " "
   spriteIniG[5,3] <- " "
   spriteIniG[5,4] <- "|"
   spriteIniG[5,5] <- " "
   spriteIniG[5,6] <- " "
   spriteIniG[5,7] <- " "
   spriteIniG[5,8] <- "/"
   spriteIniG[5,9] <- "\"
   spriteIniG[5,10] <- " "
   spriteIniG[5,11] <- " "
   spriteIniG[5,12] <- "|"
   spriteIniG[5,13] <- " "
   spriteIniG[5,14] <- " "
   spriteIniG[5,15] <- " "
   spriteIniG[6,1] <- " "
   spriteIniG[6,2] <- " "
   spriteIniG[6,3] <- " "
   spriteIniG[6,4] <- "|"
   spriteIniG[6,5] <- " "
   spriteIniG[6,6] <- "\"
   spriteIniG[6,7] <- "v"
   spriteIniG[6,8] <- "v"
   spriteIniG[6,9] <- "v"
   spriteIniG[6,10] <- "v"
   spriteIniG[6,11] <- "/"
   spriteIniG[6,12] <- "|"
   spriteIniG[6,13] <- " "
   spriteIniG[6,14] <- " "
   spriteIniG[6,15] <- " "
   spriteIniG[7,1] <- " "
   spriteIniG[7,2] <- " "
   spriteIniG[7,3] <- " "
   spriteIniG[7,4] <- "\"
   spriteIniG[7,5] <- "="
   spriteIniG[7,6] <- "="
   spriteIniG[7,7] <- "="
   spriteIniG[7,8] <- "="
   spriteIniG[7,9] <- "="
   spriteIniG[7,10] <- "="
   spriteIniG[7,11] <- "="
   spriteIniG[7,12] <- "/"
   spriteIniG[7,13] <- " "
   spriteIniG[7,14] <- " "
   spriteIniG[7,15] <- " "
fimprocedimento

procedimento carregar_spriteIniM()
inicio
   spriteIniM[1,1] <- " "
   spriteIniM[1,2] <- "\"
   spriteIniM[1,3] <- "\"
   spriteIniM[1,4] <- "_"
   spriteIniM[1,5] <- "_"
   spriteIniM[1,6] <- "_"
   spriteIniM[1,7] <- "_"
   spriteIniM[1,8] <- "_"
   spriteIniM[1,9] <- "/"
   spriteIniM[1,10] <- "/"
   spriteIniM[1,11] <- " "
   spriteIniM[2,1] <- " "
   spriteIniM[2,2] <- "|"
   spriteIniM[2,3] <- " "
   spriteIniM[2,4] <- "X"
   spriteIniM[2,5] <- "X"
   spriteIniM[2,6] <- " "
   spriteIniM[2,7] <- "X"
   spriteIniM[2,8] <- "X"
   spriteIniM[2,9] <- " "
   spriteIniM[2,10] <- "|"
   spriteIniM[2,11] <- " "
   spriteIniM[3,1] <- " "
   spriteIniM[3,2] <- "|"
   spriteIniM[3,3] <- " "
   spriteIniM[3,4] <- " "
   spriteIniM[3,5] <- " "
   spriteIniM[3,6] <- "/"
   spriteIniM[3,7] <- "\"
   spriteIniM[3,8] <- " "
   spriteIniM[3,9] <- " "
   spriteIniM[3,10] <- "|"
   spriteIniM[3,11] <- " "
   spriteIniM[4,1] <- " "
   spriteIniM[4,2] <- "|"
   spriteIniM[4,3] <- " "
   spriteIniM[4,4] <- "v"
   spriteIniM[4,5] <- "v"
   spriteIniM[4,6] <- "v"
   spriteIniM[4,7] <- "v"
   spriteIniM[4,8] <- "v"
   spriteIniM[4,9] <- " "
   spriteIniM[4,10] <- "|"
   spriteIniM[4,11] <- " "
   spriteIniM[5,1] <- " "
   spriteIniM[5,2] <- " "
   spriteIniM[5,3] <- "\"
   spriteIniM[5,4] <- "="
   spriteIniM[5,5] <- "="
   spriteIniM[5,6] <- "="
   spriteIniM[5,7] <- "="
   spriteIniM[5,8] <- "="
   spriteIniM[5,9] <- "/"
   spriteIniM[5,10] <- " "
   spriteIniM[5,11] <- " "
fimprocedimento

procedimento carregar_spriteIniP()
inicio
   spriteIniP[1,1] <- "\"
   spriteIniP[1,2] <- "\"
   spriteIniP[1,3] <- "_"
   spriteIniP[1,4] <- "_"
   spriteIniP[1,5] <- "_"
   spriteIniP[1,6] <- "/"
   spriteIniP[1,7] <- "/"
   spriteIniP[2,1] <- "|"
   spriteIniP[2,2] <- "X"
   spriteIniP[2,3] <- "-"
   spriteIniP[2,4] <- "X"
   spriteIniP[2,5] <- "-"
   spriteIniP[2,6] <- "X"
   spriteIniP[2,7] <- "|"
   spriteIniP[3,1] <- "\"
   spriteIniP[3,2] <- "V"
   spriteIniP[3,3] <- "V"
   spriteIniP[3,4] <- "V"
   spriteIniP[3,5] <- "V"
   spriteIniP[3,6] <- "V"
   spriteIniP[3,7] <- "/"
fimprocedimento

procedimento bossGRow(linha: inteiro; texto: caractere)
var j: inteiro
inicio
   para j de 1 ate 11 faca
      spriteBossG[linha, j] <- copia(texto, j, 1)
   fimpara
fimprocedimento

procedimento bossMRow(linha: inteiro; texto: caractere)
var j: inteiro
inicio
   para j de 1 ate 15 faca
      spriteBossM[linha, j] <- copia(texto, j, 1)
   fimpara
fimprocedimento

procedimento bossPRow(linha: inteiro; texto: caractere)
var j: inteiro
inicio
   para j de 1 ate 21 faca
      spriteBossP[linha, j] <- copia(texto, j, 1)
   fimpara
fimprocedimento

procedimento carregar_spriteBossG()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   bossGRow(1, bs + bs + bs + "_____" + fs + fs + fs)
   bossGRow(2, "/=========" + bs)
   bossGRow(3, "|  XXXXX  |")
   bossGRow(4, "|" + bs + bs + "VVVVV" + fs + fs + "|")
   bossGRow(5, " " + bs + "=======" + fs + " ")
fimprocedimento

procedimento carregar_spriteBossM()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   bossMRow(1, "   " + bs + bs + bs + "___" + fs + fs + fs + "   ")
   bossMRow(2, "  /=========" + bs + "  ")
   bossMRow(3, "  |   XXX   |  ")
   bossMRow(4, "  | XX | XX |  ")
   bossMRow(5, "  |" + bs + bs + "=======" + fs + fs + "|")
   bossMRow(6, "  | VVVVVVV |  ")
   bossMRow(7, "   " + bs + "=======" + fs + "   ")
fimprocedimento

procedimento carregar_spriteBossP()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   bossPRow(1, "    " + bs + bs + bs + bs + "_______" + fs + fs + fs + fs + "  ")
   bossPRow(2, "   /" + bs + bs + "         " + fs + fs + bs + "   ")
   bossPRow(3, "  |  " + bs + "=========" + fs + "  |  ")
   bossPRow(4, "  | |  XX | XX  | |  ")
   bossPRow(5, "  | |  /=====" + bs + "  | |  ")
   bossPRow(6, "  | | VVVVVVVVV | |  ")
   bossPRow(7, "  | |___________| |  ")
   bossPRow(8, "   " + bs + bs + "===========" + fs + fs + "   ")
   bossPRow(9, "    " + bs + "===========" + fs + "    ")
fimprocedimento

procedimento armaRow15(linhaIdx: inteiro; texto: caractere; codigoArma: inteiro; estadoArmaParam: inteiro)
var j: inteiro
    cc: caractere
    comp: inteiro
inicio
   comp <- compr(texto)
   para j de 1 ate 31 faca
      se j <= comp entao
         cc <- copia(texto, j, 1)
      senao
         cc <- " "
      fimse
      se (codigoArma = 1) e (estadoArmaParam = 1) entao
         spriteArmaN[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 1) e (estadoArmaParam = 2) entao
         spriteArmaT[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 1) e (estadoArmaParam = 3) entao
         spriteArmaV[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 1) e (estadoArmaParam = 4) entao
         spriteArmaR[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 2) e (estadoArmaParam = 1) entao
         spriteShotN[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 2) e (estadoArmaParam = 2) entao
         spriteShotT[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 2) e (estadoArmaParam = 3) entao
         spriteShotV[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 2) e (estadoArmaParam = 4) entao
         spriteShotR[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 3) e (estadoArmaParam = 1) entao
         spriteRifleN[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 3) e (estadoArmaParam = 2) entao
         spriteRifleT[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 3) e (estadoArmaParam = 3) entao
         spriteRifleV[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 3) e (estadoArmaParam = 4) entao
         spriteRifleR[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 4) e (estadoArmaParam = 1) entao
         spriteCannN[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 4) e (estadoArmaParam = 2) entao
         spriteCannT[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 4) e (estadoArmaParam = 3) entao
         spriteCannV[linhaIdx, j] <- cc
      fimse
      se (codigoArma = 4) e (estadoArmaParam = 4) entao
         spriteCannR[linhaIdx, j] <- cc
      fimse
   fimpara
fimprocedimento

procedimento carregar_spriteShotN()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 2, 1)
   armaRow15(2, "             o o               ", 2, 1)
   armaRow15(3, "           _" + fs + "   " + bs + "_             ", 2, 1)
   armaRow15(4, "       ___" + fs + "=====" + bs + bs + "___          ", 2, 1)
   armaRow15(5, "      [___o___o___]            ", 2, 1)
   armaRow15(6, "          |_______|            ", 2, 1)
   armaRow15(7, "                               ", 2, 1)
   armaRow15(8, "                               ", 2, 1)
fimprocedimento

procedimento carregar_spriteShotT()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 2, 2)
   armaRow15(2, "            ** **              ", 2, 2)
   armaRow15(3, "           _" + fs + "   " + bs + "_             ", 2, 2)
   armaRow15(4, "       ___" + fs + "=====" + bs + bs + "___          ", 2, 2)
   armaRow15(5, "      [___o___o___]            ", 2, 2)
   armaRow15(6, "          |_______|            ", 2, 2)
   armaRow15(7, "                               ", 2, 2)
   armaRow15(8, "                               ", 2, 2)
fimprocedimento

procedimento carregar_spriteShotV()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 2, 3)
   armaRow15(2, "             X X               ", 2, 3)
   armaRow15(3, "           _" + fs + "   " + bs + "_             ", 2, 3)
   armaRow15(4, "       ___" + fs + "=====" + bs + bs + "___          ", 2, 3)
   armaRow15(5, "      [___o___o___]            ", 2, 3)
   armaRow15(6, "          |_______|            ", 2, 3)
   armaRow15(7, "                               ", 2, 3)
   armaRow15(8, "                               ", 2, 3)
fimprocedimento

procedimento carregar_spriteShotR()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 2, 4)
   armaRow15(2, "             o o               ", 2, 4)
   armaRow15(3, "           _" + fs + "   " + bs + "_             ", 2, 4)
   armaRow15(4, "       ___" + fs + "=====" + bs + bs + "___          ", 2, 4)
   armaRow15(5, "      [___o___o___]            ", 2, 4)
   armaRow15(6, "        [oo]_______|           ", 2, 4)
   armaRow15(7, "                               ", 2, 4)
   armaRow15(8, "                               ", 2, 4)
fimprocedimento

procedimento carregar_spriteRifleN()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 3, 1)
   armaRow15(2, "              o                ", 3, 1)
   armaRow15(3, "             -|-               ", 3, 1)
   armaRow15(4, "      _____" + fs + "===" + bs + "_____          ", 3, 1)
   armaRow15(5, "     " + fs + "____---o---____" + bs + "         ", 3, 1)
   armaRow15(6, "          " + fs + "_______" + bs + "            ", 3, 1)
   armaRow15(7, "                               ", 3, 1)
   armaRow15(8, "                               ", 3, 1)
fimprocedimento

procedimento carregar_spriteRifleT()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 3, 2)
   armaRow15(2, "             ***               ", 3, 2)
   armaRow15(3, "             -|-               ", 3, 2)
   armaRow15(4, "      _____" + fs + "===" + bs + "_____          ", 3, 2)
   armaRow15(5, "     " + fs + "____---o---____" + bs + "         ", 3, 2)
   armaRow15(6, "          " + fs + "_______" + bs + "            ", 3, 2)
   armaRow15(7, "                               ", 3, 2)
   armaRow15(8, "                               ", 3, 2)
fimprocedimento

procedimento carregar_spriteRifleV()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 3, 3)
   armaRow15(2, "              X                ", 3, 3)
   armaRow15(3, "             -|-               ", 3, 3)
   armaRow15(4, "      _____" + fs + "===" + bs + "_____          ", 3, 3)
   armaRow15(5, "     " + fs + "____---o---____" + bs + "         ", 3, 3)
   armaRow15(6, "          " + fs + "_______" + bs + "            ", 3, 3)
   armaRow15(7, "                               ", 3, 3)
   armaRow15(8, "                               ", 3, 3)
fimprocedimento

procedimento carregar_spriteRifleR()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 3, 4)
   armaRow15(2, "              o                ", 3, 4)
   armaRow15(3, "             -|-               ", 3, 4)
   armaRow15(4, "      _____" + fs + "===" + bs + "_____          ", 3, 4)
   armaRow15(5, "     " + fs + "____---o---____" + bs + "         ", 3, 4)
   armaRow15(6, "        [#]" + fs + "_______" + bs + "           ", 3, 4)
   armaRow15(7, "                               ", 3, 4)
   armaRow15(8, "                               ", 3, 4)
fimprocedimento

procedimento carregar_spriteCannN()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 4, 1)
   armaRow15(2, "             (o)               ", 4, 1)
   armaRow15(3, "           __" + fs + "=" + bs + "__             ", 4, 1)
   armaRow15(4, "      ____" + fs + "=====" + bs + bs + "____         ", 4, 1)
   armaRow15(5, "     [_____##_##____]          ", 4, 1)
   armaRow15(6, "       |###|___|###|           ", 4, 1)
   armaRow15(7, "                               ", 4, 1)
   armaRow15(8, "                               ", 4, 1)
fimprocedimento

procedimento carregar_spriteCannT()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 4, 2)
   armaRow15(2, "           **(o)**             ", 4, 2)
   armaRow15(3, "           __" + fs + "=" + bs + "__             ", 4, 2)
   armaRow15(4, "      ____" + fs + "=====" + bs + bs + "____         ", 4, 2)
   armaRow15(5, "     [_____##_##____]          ", 4, 2)
   armaRow15(6, "       |###|___|###|           ", 4, 2)
   armaRow15(7, "                               ", 4, 2)
   armaRow15(8, "                               ", 4, 2)
fimprocedimento

procedimento carregar_spriteCannV()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 4, 3)
   armaRow15(2, "             (X)               ", 4, 3)
   armaRow15(3, "           __" + fs + "=" + bs + "__             ", 4, 3)
   armaRow15(4, "      ____" + fs + "=====" + bs + bs + "____         ", 4, 3)
   armaRow15(5, "     [_____##_##____]          ", 4, 3)
   armaRow15(6, "       |###|___|###|           ", 4, 3)
   armaRow15(7, "                               ", 4, 3)
   armaRow15(8, "                               ", 4, 3)
fimprocedimento

procedimento carregar_spriteCannR()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 4, 4)
   armaRow15(2, "             (o)               ", 4, 4)
   armaRow15(3, "           __" + fs + "=" + bs + "__             ", 4, 4)
   armaRow15(4, "      ____" + fs + "=====" + bs + bs + "____         ", 4, 4)
   armaRow15(5, "     [_____##_##____]          ", 4, 4)
   armaRow15(6, "  [##] |###|___|###|           ", 4, 4)
   armaRow15(7, "                               ", 4, 4)
   armaRow15(8, "                               ", 4, 4)
fimprocedimento

procedimento itemRow7(linhaIdx: inteiro; texto: caractere; codigoItem: inteiro)
var j: inteiro
    cc: caractere
inicio
   para j de 1 ate 7 faca
      cc <- copia(texto, j, 1)
      se codigoItem = 1 entao
         spriteItemK[linhaIdx, j] <- cc
      fimse
      se codigoItem = 2 entao
         spriteItemA[linhaIdx, j] <- cc
      fimse
      se codigoItem = 3 entao
         spriteItemC[linhaIdx, j] <- cc
      fimse
      se codigoItem = 4 entao
         spriteItemW[linhaIdx, j] <- cc
      fimse
   fimpara
fimprocedimento

procedimento carregar_spriteItemK()
inicio
   itemRow7(1, "+-----+", 1)
   itemRow7(2, "| KIT |", 1)
   itemRow7(3, "+-----+", 1)
fimprocedimento

procedimento carregar_spriteItemA()
inicio
   itemRow7(1, "+-----+", 2)
   itemRow7(2, "|*AMO*|", 2)
   itemRow7(3, "+-----+", 2)
fimprocedimento

procedimento carregar_spriteItemC()
inicio
   itemRow7(1, "+-----+", 3)
   itemRow7(2, "|CHAVE|", 3)
   itemRow7(3, "+-----+", 3)
fimprocedimento

procedimento carregar_spriteItemW()
inicio
   itemRow7(1, "+-----+", 4)
   itemRow7(2, "|ARMA!|", 4)
   itemRow7(3, "+-----+", 4)
fimprocedimento

procedimento carregar_spriteSaiG()
inicio
   spriteSaiG[1,1] <- "+"
   spriteSaiG[1,2] <- "="
   spriteSaiG[1,3] <- "="
   spriteSaiG[1,4] <- "="
   spriteSaiG[1,5] <- "="
   spriteSaiG[1,6] <- "="
   spriteSaiG[1,7] <- "="
   spriteSaiG[1,8] <- "="
   spriteSaiG[1,9] <- "="
   spriteSaiG[1,10] <- "="
   spriteSaiG[1,11] <- "="
   spriteSaiG[1,12] <- "="
   spriteSaiG[1,13] <- "="
   spriteSaiG[1,14] <- "+"
   spriteSaiG[2,1] <- "|"
   spriteSaiG[2,2] <- "|"
   spriteSaiG[2,3] <- " "
   spriteSaiG[2,4] <- " "
   spriteSaiG[2,5] <- "E"
   spriteSaiG[2,6] <- " "
   spriteSaiG[2,7] <- "X"
   spriteSaiG[2,8] <- " "
   spriteSaiG[2,9] <- "I"
   spriteSaiG[2,10] <- " "
   spriteSaiG[2,11] <- "T"
   spriteSaiG[2,12] <- " "
   spriteSaiG[2,13] <- "|"
   spriteSaiG[2,14] <- "|"
   spriteSaiG[3,1] <- "|"
   spriteSaiG[3,2] <- "|"
   spriteSaiG[3,3] <- " "
   spriteSaiG[3,4] <- " "
   spriteSaiG[3,5] <- "|"
   spriteSaiG[3,6] <- " "
   spriteSaiG[3,7] <- " "
   spriteSaiG[3,8] <- " "
   spriteSaiG[3,9] <- " "
   spriteSaiG[3,10] <- "|"
   spriteSaiG[3,11] <- " "
   spriteSaiG[3,12] <- " "
   spriteSaiG[3,13] <- "|"
   spriteSaiG[3,14] <- "|"
   spriteSaiG[4,1] <- "|"
   spriteSaiG[4,2] <- "|"
   spriteSaiG[4,3] <- " "
   spriteSaiG[4,4] <- " "
   spriteSaiG[4,5] <- "|"
   spriteSaiG[4,6] <- " "
   spriteSaiG[4,7] <- " "
   spriteSaiG[4,8] <- " "
   spriteSaiG[4,9] <- " "
   spriteSaiG[4,10] <- "|"
   spriteSaiG[4,11] <- " "
   spriteSaiG[4,12] <- " "
   spriteSaiG[4,13] <- "|"
   spriteSaiG[4,14] <- "|"
   spriteSaiG[5,1] <- "|"
   spriteSaiG[5,2] <- "|"
   spriteSaiG[5,3] <- " "
   spriteSaiG[5,4] <- " "
   spriteSaiG[5,5] <- "|"
   spriteSaiG[5,6] <- "_"
   spriteSaiG[5,7] <- "_"
   spriteSaiG[5,8] <- "_"
   spriteSaiG[5,9] <- "_"
   spriteSaiG[5,10] <- "|"
   spriteSaiG[5,11] <- " "
   spriteSaiG[5,12] <- " "
   spriteSaiG[5,13] <- "|"
   spriteSaiG[5,14] <- "|"
   spriteSaiG[6,1] <- "+"
   spriteSaiG[6,2] <- "="
   spriteSaiG[6,3] <- "="
   spriteSaiG[6,4] <- "="
   spriteSaiG[6,5] <- "="
   spriteSaiG[6,6] <- "="
   spriteSaiG[6,7] <- "="
   spriteSaiG[6,8] <- "="
   spriteSaiG[6,9] <- "="
   spriteSaiG[6,10] <- "="
   spriteSaiG[6,11] <- "="
   spriteSaiG[6,12] <- "="
   spriteSaiG[6,13] <- "="
   spriteSaiG[6,14] <- "+"
fimprocedimento

procedimento carregar_spriteSaiP()
inicio
   spriteSaiP[1,1] <- "+"
   spriteSaiP[1,2] <- "="
   spriteSaiP[1,3] <- "="
   spriteSaiP[1,4] <- "="
   spriteSaiP[1,5] <- "="
   spriteSaiP[1,6] <- "="
   spriteSaiP[1,7] <- "="
   spriteSaiP[1,8] <- "="
   spriteSaiP[1,9] <- "="
   spriteSaiP[1,10] <- "+"
   spriteSaiP[2,1] <- "|"
   spriteSaiP[2,2] <- " "
   spriteSaiP[2,3] <- " "
   spriteSaiP[2,4] <- "E"
   spriteSaiP[2,5] <- "X"
   spriteSaiP[2,6] <- "I"
   spriteSaiP[2,7] <- "T"
   spriteSaiP[2,8] <- " "
   spriteSaiP[2,9] <- " "
   spriteSaiP[2,10] <- "|"
   spriteSaiP[3,1] <- "|"
   spriteSaiP[3,2] <- " "
   spriteSaiP[3,3] <- " "
   spriteSaiP[3,4] <- " "
   spriteSaiP[3,5] <- "X"
   spriteSaiP[3,6] <- "X"
   spriteSaiP[3,7] <- " "
   spriteSaiP[3,8] <- " "
   spriteSaiP[3,9] <- " "
   spriteSaiP[3,10] <- "|"
   spriteSaiP[4,1] <- "+"
   spriteSaiP[4,2] <- "="
   spriteSaiP[4,3] <- "="
   spriteSaiP[4,4] <- "="
   spriteSaiP[4,5] <- "="
   spriteSaiP[4,6] <- "="
   spriteSaiP[4,7] <- "="
   spriteSaiP[4,8] <- "="
   spriteSaiP[4,9] <- "="
   spriteSaiP[4,10] <- "+"
fimprocedimento

procedimento carregar_spriteArmaN()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 1, 1)
   armaRow15(2, "              o                ", 1, 1)
   armaRow15(3, "            _" + fs + " " + bs + "_              ", 1, 1)
   armaRow15(4, "         __" + fs + "___" + bs + "__             ", 1, 1)
   armaRow15(5, "        [___o___]              ", 1, 1)
   armaRow15(6, "            " + bs + "__                ", 1, 1)
   armaRow15(7, "                               ", 1, 1)
   armaRow15(8, "                               ", 1, 1)
fimprocedimento

procedimento carregar_spriteArmaT()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 1, 2)
   armaRow15(2, "             ***               ", 1, 2)
   armaRow15(3, "            _" + fs + " " + bs + "_              ", 1, 2)
   armaRow15(4, "         __" + fs + "___" + bs + "__             ", 1, 2)
   armaRow15(5, "        [___o___]              ", 1, 2)
   armaRow15(6, "            " + bs + "__                ", 1, 2)
   armaRow15(7, "                               ", 1, 2)
   armaRow15(8, "                               ", 1, 2)
fimprocedimento

procedimento carregar_spriteArmaV()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 1, 3)
   armaRow15(2, "              X                ", 1, 3)
   armaRow15(3, "            _" + fs + " " + bs + "_              ", 1, 3)
   armaRow15(4, "         __" + fs + "___" + bs + "__             ", 1, 3)
   armaRow15(5, "        [___o___]              ", 1, 3)
   armaRow15(6, "            " + bs + "__                ", 1, 3)
   armaRow15(7, "                               ", 1, 3)
   armaRow15(8, "                               ", 1, 3)
fimprocedimento

procedimento carregar_spriteArmaR()
var bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   armaRow15(1, "                               ", 1, 4)
   armaRow15(2, "              o                ", 1, 4)
   armaRow15(3, "            _" + fs + " " + bs + "_              ", 1, 4)
   armaRow15(4, "         __" + fs + "___" + bs + "__             ", 1, 4)
   armaRow15(5, "        [___o___]              ", 1, 4)
   armaRow15(6, "          [#]" + bs + "__               ", 1, 4)
   armaRow15(7, "                               ", 1, 4)
   armaRow15(8, "                               ", 1, 4)
fimprocedimento

procedimento carregarDigitos()
inicio
   digito[0] <- "0"
   digito[1] <- "1"
   digito[2] <- "2"
   digito[3] <- "3"
   digito[4] <- "4"
   digito[5] <- "5"
   digito[6] <- "6"
   digito[7] <- "7"
   digito[8] <- "8"
   digito[9] <- "9"
fimprocedimento
procedimento inicializarSprites()
inicio
   carregarDigitos()
   inicializarTabelas()
   carregar_spriteIniG()
   carregar_spriteIniM()
   carregar_spriteIniP()
   carregar_spriteBossG()
   carregar_spriteBossM()
   carregar_spriteBossP()
   carregar_spriteSaiG()
   carregar_spriteSaiP()
   carregar_spriteArmaN()
   carregar_spriteArmaT()
   carregar_spriteArmaV()
   carregar_spriteArmaR()
   carregar_spriteShotN()
   carregar_spriteShotT()
   carregar_spriteShotV()
   carregar_spriteShotR()
   carregar_spriteRifleN()
   carregar_spriteRifleT()
   carregar_spriteRifleV()
   carregar_spriteRifleR()
   carregar_spriteCannN()
   carregar_spriteCannT()
   carregar_spriteCannV()
   carregar_spriteCannR()
   carregar_spriteItemK()
   carregar_spriteItemA()
   carregar_spriteItemC()
   carregar_spriteItemW()
fimprocedimento

procedimento desenharBorda()
var i: inteiro
inicio
   para i de 1 ate 120 faca
      tela[1,i] <- "="
      tela[36,i] <- "="
   fimpara
   para i de 1 ate 36 faca
      tela[i,1] <- "|"
      tela[i,120] <- "|"
   fimpara
   tela[1,1] <- "+"
   tela[1,120] <- "+"
   tela[36,1] <- "+"
   tela[36,120] <- "+"
fimprocedimento

procedimento desenharHUD()
var i: inteiro
inicio
   ptStr("    D O O M A L G        F A S E    ", 2, 14)
   ptInt(fase, 2, 52)
   ptStr("  :  ", 2, 53)
   ptStr(faseNome[fase], 2, 58)
   para i de 2 ate 119 faca
      tela[4,i] <- "-"
   fimpara
   tela[4,1] <- "+"
   tela[4,120] <- "+"
   ptStr("F:", 3, 3)
   ptInt(fase, 3, 5)
   ptStr("/5", 3, 6)
   ptStr("|", 3, 10)
   ptStr("VIDA[", 3, 12)
   barStr <- ""
   vidaBarN <- (vida * 10) div vidaMax
   se vidaBarN < 0 entao
      vidaBarN <- 0
   fimse
   se vidaBarN > 10 entao
      vidaBarN <- 10
   fimse
   para i de 1 ate 10 faca
      se i <= vidaBarN entao
         se vidaBarN > 6 entao
            barStr <- barStr + "#"
         senao
            se vidaBarN > 3 entao
               barStr <- barStr + "+"
            senao
               barStr <- barStr + "!"
            fimse
         fimse
      senao
         barStr <- barStr + "."
      fimse
   fimpara
   ptStr(barStr, 3, 17)
   ptStr("]", 3, 27)
   ptInt3(vida, 3, 29)
   ptStr("/", 3, 32)
   ptInt3(vidaMax, 3, 33)
   ptStr("|", 3, 37)
   ptStr("AMMO[", 3, 39)
   barStr <- ""
   ammoBarN <- (ammo * 10) div ammoMax
   se ammoBarN < 0 entao
      ammoBarN <- 0
   fimse
   se ammoBarN > 10 entao
      ammoBarN <- 10
   fimse
   para i de 1 ate 10 faca
      se i <= ammoBarN entao
         barStr <- barStr + "*"
      senao
         barStr <- barStr + "."
      fimse
   fimpara
   ptStr(barStr, 3, 44)
   ptStr("]", 3, 54)
   ptInt(ammo, 3, 56)
   ptStr("/", 3, 58)
   ptInt(ammoMax, 3, 59)
   ptStr("|", 3, 62)
   ptStr("DIR ", 3, 64)
   ptStr(dirNome, 3, 68)
   ptStr("|", 3, 78)
   ptStr("ANG ", 3, 80)
   ptInt3(dirAngulo, 3, 84)
   ptStr("|", 3, 88)
   ptStr("POS ", 3, 90)
   ptInt(px, 3, 94)
   ptStr(",", 3, 96)
   ptInt(py, 3, 97)
fimprocedimento

procedimento desenharMolduraFPS()
var i: inteiro
inicio
   para i de 3 ate 80 faca
      tela[5,i] <- "-"
      tela[31,i] <- "-"
   fimpara
   tela[5,3] <- "+"
   tela[5,80] <- "+"
   tela[31,3] <- "+"
   tela[31,80] <- "+"
   para i de 6 ate 30 faca
      tela[i,3] <- "|"
      tela[i,80] <- "|"
   fimpara
   ptStr("[ VISAO ]", 5, 37)
fimprocedimento

procedimento preencherTetoChao()
var i: inteiro
    j: inteiro
    colEsq: inteiro
    colDir: inteiro
    bs: caractere
    fs: caractere
inicio
   bs <- "\"
   fs <- "/"
   para i de 6 ate 16 faca
      para j de 4 ate 79 faca
         tela[i,j] <- " "
      fimpara
   fimpara
   para i de 8 ate 14 passo 3 faca
      colEsq <- 4 + (i-6)*4
      colDir <- 79 - (i-6)*4
      se (colEsq >= 4) e (colEsq <= 79) entao
         tela[i,colEsq] <- bs
      fimse
      se (colDir >= 4) e (colDir <= 79) entao
         tela[i,colDir] <- fs
      fimse
   fimpara
   para j de 18 ate 78 passo 20 faca
      tela[11,j] <- "."
   fimpara
   para j de 39 ate 45 passo 3 faca
      tela[16,j] <- "-"
   fimpara
   para i de 17 ate 30 faca
      para j de 4 ate 79 faca
         tela[i,j] <- " "
      fimpara
   fimpara
   para i de 19 ate 30 passo 4 faca
      colEsq <- 42 - (i-16)*4
      colDir <- 42 + (i-16)*4
      se (colEsq >= 4) e (colEsq <= 79) entao
         tela[i,colEsq] <- fs
      fimse
      se (colDir >= 4) e (colDir <= 79) entao
         tela[i,colDir] <- bs
      fimse
   fimpara
   para j de 24 ate 60 passo 18 faca
      tela[24,j] <- "."
   fimpara
   para j de 14 ate 70 passo 22 faca
      tela[29,j] <- "."
   fimpara
fimprocedimento

procedimento calcularFaixas()
var f: inteiro
    p: inteiro
    tx: inteiro
    ty: inteiro
    blq: logico
inicio
   colIniFaixa[1] <- 4
   colFimFaixa[1] <- 19
   colIniFaixa[2] <- 20
   colFimFaixa[2] <- 34
   colIniFaixa[3] <- 35
   colFimFaixa[3] <- 49
   colIniFaixa[4] <- 50
   colFimFaixa[4] <- 64
   colIniFaixa[5] <- 65
   colFimFaixa[5] <- 79
   para f de 1 ate 5 faca
      distFaixa[f] <- 0
      altFaixa[f] <- 0
      chrFaixa[f] <- " "
   fimpara
   para f de 1 ate 5 faca
      p <- 1
      blq <- falso
      enquanto (p <= 5) e (nao blq) faca
         tx <- px + p*dx + (f-3)*lx
         ty <- py + p*dy + (f-3)*ly
         se (tx < 1) ou (tx > 24) ou (ty < 1) ou (ty > 12) entao
            distFaixa[f] <- p
            blq <- verdadeiro
         senao
            se mapa[ty,tx] = "#" entao
               distFaixa[f] <- p
               blq <- verdadeiro
            fimse
         fimse
         p <- p + 1
      fimenquanto
   fimpara
   para f de 1 ate 5 faca
      se distFaixa[f] = 1 entao
         altFaixa[f] <- 20
         chrFaixa[f] <- "#"
      senao
         se distFaixa[f] = 2 entao
            altFaixa[f] <- 15
            chrFaixa[f] <- "+"
         senao
            se distFaixa[f] = 3 entao
               altFaixa[f] <- 11
               chrFaixa[f] <- "="
            senao
               se distFaixa[f] = 4 entao
                  altFaixa[f] <- 7
                  chrFaixa[f] <- "-"
               senao
                  se distFaixa[f] = 5 entao
                     altFaixa[f] <- 3
                     chrFaixa[f] <- "."
                  fimse
               fimse
            fimse
         fimse
      fimse
   fimpara
fimprocedimento

procedimento desenharParedes()
var f: inteiro
    i: inteiro
    j: inteiro
    h: inteiro
    centro: inteiro
    ltopo: inteiro
    lbase: inteiro
    cf: caractere
    borda: caractere
inicio
   centro <- 17
   para f de 1 ate 5 faca
      h <- altFaixa[f]
      cf <- chrFaixa[f]
      se h > 0 entao
         borda <- "|"
         ltopo <- centro - (h div 2)
         lbase <- ltopo + h - 1
         se ltopo < 6 entao
            ltopo <- 6
         fimse
         se lbase > 30 entao
            lbase <- 30
         fimse
         para i de ltopo ate lbase faca
            para j de colIniFaixa[f] ate colFimFaixa[f] faca
               se (i = ltopo) ou (i = lbase) entao
                  tela[i,j] <- "_"
               senao
                  se (j = colIniFaixa[f]) ou (j = colFimFaixa[f]) entao
                     tela[i,j] <- borda
                  senao
                     tela[i,j] <- " "
                     se distFaixa[f] = 1 entao
                        se ((i+j) mod 8 = 0) entao
                           tela[i,j] <- cf
                        fimse
                     fimse
                     se distFaixa[f] = 2 entao
                        se ((i+j) mod 10 = 0) entao
                           tela[i,j] <- cf
                        fimse
                     fimse
                     se distFaixa[f] >= 3 entao
                        se ((i+j) mod 12 = 0) entao
                           tela[i,j] <- cf
                        fimse
                     fimse
                  fimse
               fimse
            fimpara
         fimpara
         tela[ltopo,colIniFaixa[f]] <- "+"
         tela[ltopo,colFimFaixa[f]] <- "+"
         tela[lbase,colIniFaixa[f]] <- "+"
         tela[lbase,colFimFaixa[f]] <- "+"
         se (f = 1) ou (f = 5) entao
            se distFaixa[f] <= 3 entao
               para i de ltopo ate lbase faca
                  se (i mod 2 = 0) entao
                     tela[i,colIniFaixa[f]] <- "|"
                     tela[i,colFimFaixa[f]] <- "|"
                  fimse
               fimpara
            fimse
         fimse
      fimse
   fimpara
fimprocedimento

procedimento desenharLaterais()
var p: inteiro
    y: inteiro
    j: inteiro
    xEsq: inteiro
    yEsq: inteiro
    xDir: inteiro
    yDir: inteiro
    paredeEsq: logico
    paredeDir: logico
    linTop: inteiro
    linBase: inteiro
    colEsq1: inteiro
    colEsq2: inteiro
    colDir1: inteiro
    colDir2: inteiro
    marcaParede: caractere
inicio
   para p de 0 ate 3 faca
      xEsq <- px + p*dx - lx
      yEsq <- py + p*dy - ly
      xDir <- px + p*dx + lx
      yDir <- py + p*dy + ly
      paredeEsq <- falso
      paredeDir <- falso
      se (xEsq < 1) ou (xEsq > 24) ou (yEsq < 1) ou (yEsq > 12) entao
         paredeEsq <- verdadeiro
      senao
         se mapa[yEsq,xEsq] = "#" entao
            paredeEsq <- verdadeiro
         fimse
      fimse
      se (xDir < 1) ou (xDir > 24) ou (yDir < 1) ou (yDir > 12) entao
         paredeDir <- verdadeiro
      senao
         se mapa[yDir,xDir] = "#" entao
            paredeDir <- verdadeiro
         fimse
      fimse
      linTop <- 7 + p*2
      linBase <- 29 - p*3
      colEsq1 <- 4 + p*6
      colEsq2 <- colEsq1 + 6
      colDir2 <- 79 - p*5
      colDir1 <- colDir2 - 5
      marcaParede <- "#"
      se p = 1 entao
         marcaParede <- "+"
      fimse
      se p = 2 entao
         marcaParede <- "="
      fimse
      se p = 3 entao
         marcaParede <- "-"
      fimse
      se paredeEsq entao
         para y de linTop ate linBase faca
            tela[y,colEsq2] <- "|"
            se (y mod 4 = 0) entao
               para j de colEsq1 ate colEsq2-1 passo 3 faca
                  tela[y,j] <- marcaParede
               fimpara
            fimse
         fimpara
      fimse
      se paredeDir entao
         para y de linTop ate linBase faca
            tela[y,colDir1] <- "|"
            se (y mod 4 = 0) entao
               para j de colDir1+1 ate colDir2 passo 3 faca
                  tela[y,j] <- marcaParede
               fimpara
            fimse
         fimpara
      fimse
   fimpara
fimprocedimento

procedimento desenharSpriteIniG(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 7 faca
      para j de 1 ate 15 faca
         cc <- spriteIniG[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteIniM(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 5 faca
      para j de 1 ate 11 faca
         cc <- spriteIniM[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteIniP(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 3 faca
      para j de 1 ate 7 faca
         cc <- spriteIniP[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteSaiG(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 6 faca
      para j de 1 ate 14 faca
         cc <- spriteSaiG[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteSaiP(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 4 faca
      para j de 1 ate 10 faca
         cc <- spriteSaiP[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento labelTipoInimigo(tipoIni: inteiro; L: inteiro; C: inteiro)
inicio
fimprocedimento

procedimento desenharInimigos()
var k: inteiro
    p: inteiro
    offL: inteiro
    cx: inteiro
    cy: inteiro
    ax: inteiro
    ay: inteiro
    blq: logico
    bp: inteiro
    achouAlvo: logico
    pAlvo: inteiro
    offAlvo: inteiro
    colC: inteiro
    linC: inteiro
    tipoVis: inteiro
inicio
   para k de 1 ate numIni faca
      se inimigoVivo[k] entao
         ax <- inimigoX[k]
         ay <- inimigoY[k]
         achouAlvo <- falso
         pAlvo <- 0
         offAlvo <- 0
         para p de 1 ate 5 faca
            para offL de -2 ate 2 faca
               se nao achouAlvo entao
                  cx <- px + p*dx + offL*lx
                  cy <- py + p*dy + offL*ly
                  se (cx = ax) e (cy = ay) entao
                     achouAlvo <- verdadeiro
                     pAlvo <- p
                     offAlvo <- offL
                  fimse
               fimse
            fimpara
         fimpara
         se achouAlvo entao
            blq <- falso
            para bp de 1 ate pAlvo-1 faca
               se nao blq entao
                  cx <- px + bp*dx + offAlvo*lx
                  cy <- py + bp*dy + offAlvo*ly
                  se (cx >= 1) e (cx <= 24) e (cy >= 1) e (cy <= 12) entao
                     se mapa[cy,cx] = "#" entao
                        blq <- verdadeiro
                     fimse
                  senao
                     blq <- verdadeiro
                  fimse
               fimse
            fimpara
            se nao blq entao
               colC <- 42 + offAlvo*15
               tipoVis <- inimigoTipo[k]
               se pAlvo = 1 entao
                  linC <- 10
                  desenharSpriteIniG(linC, colC - 7)
                  labelTipoInimigo(tipoVis, linC - 1, colC)
               senao
                  se pAlvo = 2 entao
                     linC <- 12
                     desenharSpriteIniG(linC, colC - 7)
                     labelTipoInimigo(tipoVis, linC - 1, colC)
                  senao
                     se pAlvo = 3 entao
                        linC <- 14
                        desenharSpriteIniM(linC, colC - 5)
                        labelTipoInimigo(tipoVis, linC - 1, colC)
                     senao
                        linC <- 16
                        desenharSpriteIniP(linC, colC - 3)
                        labelTipoInimigo(tipoVis, linC - 1, colC)
                     fimse
                  fimse
               fimse
            fimse
         fimse
      fimse
   fimpara
fimprocedimento

procedimento desenharSpriteBossG(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 5 faca
      para j de 1 ate 11 faca
         cc <- spriteBossG[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteBossM(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 7 faca
      para j de 1 ate 15 faca
         cc <- spriteBossM[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSpriteBossP(L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 9 faca
      para j de 1 ate 21 faca
         cc <- spriteBossP[i,j]
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharBoss()
var p: inteiro
    offL: inteiro
    cx: inteiro
    cy: inteiro
    blq: logico
    bp: inteiro
    achouAlvo: logico
    pAlvo: inteiro
    offAlvo: inteiro
    colC: inteiro
    linC: inteiro
inicio
   se bossAtivo e bossVivo entao
      achouAlvo <- falso
      pAlvo <- 0
      offAlvo <- 0
      para p de 1 ate 5 faca
         para offL de -2 ate 2 faca
            se nao achouAlvo entao
               cx <- px + p*dx + offL*lx
               cy <- py + p*dy + offL*ly
               se (cx = bossX) e (cy = bossY) entao
                  achouAlvo <- verdadeiro
                  pAlvo <- p
                  offAlvo <- offL
               fimse
            fimse
         fimpara
      fimpara
      se achouAlvo entao
         blq <- falso
         para bp de 1 ate pAlvo-1 faca
            se nao blq entao
               cx <- px + bp*dx + offAlvo*lx
               cy <- py + bp*dy + offAlvo*ly
               se (cx >= 1) e (cx <= 24) e (cy >= 1) e (cy <= 12) entao
                  se mapa[cy,cx] = "#" entao
                     blq <- verdadeiro
                  fimse
               senao
                  blq <- verdadeiro
               fimse
            fimse
         fimpara
         se nao blq entao
            colC <- 42 + offAlvo*15
            se pAlvo = 1 entao
               linC <- 8
               desenharSpriteBossP(linC, colC - 10)
            fimse
            se pAlvo = 2 entao
               linC <- 10
               desenharSpriteBossP(linC, colC - 10)
            fimse
            se pAlvo = 3 entao
               linC <- 12
               desenharSpriteBossM(linC, colC - 7)
            fimse
            se pAlvo = 4 entao
               linC <- 13
               desenharSpriteBossG(linC, colC - 5)
            fimse
            se pAlvo = 5 entao
               linC <- 14
               desenharSpriteBossG(linC, colC - 5)
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento desenharSpriteItemCelula(codigoItem: inteiro; L: inteiro; C: inteiro)
var i: inteiro
    j: inteiro
    cc: caractere
inicio
   para i de 1 ate 3 faca
      para j de 1 ate 7 faca
         cc <- " "
         se codigoItem = 1 entao
            cc <- spriteItemK[i,j]
         fimse
         se codigoItem = 2 entao
            cc <- spriteItemA[i,j]
         fimse
         se codigoItem = 3 entao
            cc <- spriteItemC[i,j]
         fimse
         se codigoItem = 4 entao
            cc <- spriteItemW[i,j]
         fimse
         se cc <> " " entao
            se (L+i-1 >= 6) e (L+i-1 <= 30) e (C+j-1 >= 4) e (C+j-1 <= 79) entao
               tela[L+i-1, C+j-1] <- cc
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharItens()
var p: inteiro
    offL: inteiro
    cx: inteiro
    cy: inteiro
    blq: logico
    bp: inteiro
    achouAlvo: logico
    pAlvo: inteiro
    offAlvo: inteiro
    colC: inteiro
    linC: inteiro
    cellChar: caractere
    codigoItem: inteiro
    iMap: inteiro
    jMap: inteiro
    chrSimples: caractere
inicio
   para iMap de 1 ate 12 faca
      para jMap de 1 ate 24 faca
         cellChar <- mapa[iMap, jMap]
         codigoItem <- 0
         se cellChar = "K" entao
            codigoItem <- 1
         fimse
         se cellChar = "A" entao
            codigoItem <- 2
         fimse
         se cellChar = "C" entao
            codigoItem <- 3
         fimse
         se cellChar = "W" entao
            codigoItem <- 4
         fimse
         se codigoItem > 0 entao
            achouAlvo <- falso
            pAlvo <- 0
            offAlvo <- 0
            para p de 1 ate 5 faca
               para offL de -2 ate 2 faca
                  se nao achouAlvo entao
                     cx <- px + p*dx + offL*lx
                     cy <- py + p*dy + offL*ly
                     se (cx = jMap) e (cy = iMap) entao
                        achouAlvo <- verdadeiro
                        pAlvo <- p
                        offAlvo <- offL
                     fimse
                  fimse
               fimpara
            fimpara
            se achouAlvo entao
               blq <- falso
               para bp de 1 ate pAlvo-1 faca
                  se nao blq entao
                     cx <- px + bp*dx + offAlvo*lx
                     cy <- py + bp*dy + offAlvo*ly
                     se (cx >= 1) e (cx <= 24) e (cy >= 1) e (cy <= 12) entao
                        se mapa[cy,cx] = "#" entao
                           blq <- verdadeiro
                        fimse
                     senao
                        blq <- verdadeiro
                     fimse
                  fimse
               fimpara
               se nao blq entao
                  colC <- 42 + offAlvo*15
                  se pAlvo <= 3 entao
                     se pAlvo = 1 entao
                        linC <- 15
                     fimse
                     se pAlvo = 2 entao
                        linC <- 17
                     fimse
                     se pAlvo = 3 entao
                        linC <- 19
                     fimse
                     desenharSpriteItemCelula(codigoItem, linC, colC - 3)
                     ptStr("<", linC - 1, colC - 1)
                     ptStr(cellChar, linC - 1, colC)
                     ptStr(">", linC - 1, colC + 1)
                  senao
                     chrSimples <- cellChar
                     linC <- 23
                     se (colC >= 4) e (colC <= 79) entao
                        tela[linC, colC] <- chrSimples
                        tela[linC-1, colC] <- "."
                        tela[linC+1, colC] <- "."
                     fimse
                  fimse
               fimse
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento desenharSaida()
var ex: inteiro
    ey: inteiro
    p: inteiro
    offL: inteiro
    cx: inteiro
    cy: inteiro
    blq: logico
    bp: inteiro
    achouAlvo: logico
    pAlvo: inteiro
    offAlvo: inteiro
    colC: inteiro
    linC: inteiro
    achou: logico
    i: inteiro
    j: inteiro
inicio
   achou <- falso
   ex <- 0
   ey <- 0
   para i de 1 ate 12 faca
      para j de 1 ate 24 faca
         se mapa[i,j] = "X" entao
            ex <- j
            ey <- i
            achou <- verdadeiro
         fimse
      fimpara
   fimpara
   se achou entao
      achouAlvo <- falso
      pAlvo <- 0
      offAlvo <- 0
      para p de 1 ate 5 faca
         para offL de -2 ate 2 faca
            se nao achouAlvo entao
               cx <- px + p*dx + offL*lx
               cy <- py + p*dy + offL*ly
               se (cx = ex) e (cy = ey) entao
                  achouAlvo <- verdadeiro
                  pAlvo <- p
                  offAlvo <- offL
               fimse
            fimse
         fimpara
      fimpara
      se achouAlvo entao
         blq <- falso
         para bp de 1 ate pAlvo-1 faca
            se nao blq entao
               cx <- px + bp*dx + offAlvo*lx
               cy <- py + bp*dy + offAlvo*ly
               se (cx >= 1) e (cx <= 24) e (cy >= 1) e (cy <= 12) entao
                  se mapa[cy,cx] = "#" entao
                     blq <- verdadeiro
                  fimse
               senao
                  blq <- verdadeiro
               fimse
            fimse
         fimpara
         se nao blq entao
            colC <- 42 + offAlvo*15
            se pAlvo <= 2 entao
               linC <- 10
               desenharSpriteSaiG(linC, colC - 7)
               ptStr("<<< X >>>", linC - 1, colC - 4)
            senao
               linC <- 12
               desenharSpriteSaiP(linC, colC - 5)
               ptStr("< X >", linC - 1, colC - 2)
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento desenharSinalFPS()
var p: inteiro
    k: inteiro
    alvoX: inteiro
    alvoY: inteiro
    msgVisao: caractere
    blq: logico
    temIni: logico
    paredeEsq: logico
    paredeDir: logico
    xEsq: inteiro
    yEsq: inteiro
    xDir: inteiro
    yDir: inteiro
inicio
   msgVisao <- ""
   blq <- falso
   p <- 1
   enquanto (p <= 5) e (msgVisao = "") e (nao blq) faca
      alvoX <- px + p*dx
      alvoY <- py + p*dy
      se (alvoX < 1) ou (alvoX > 24) ou (alvoY < 1) ou (alvoY > 12) entao
         msgVisao <- "PAREDE AO FUNDO"
         blq <- verdadeiro
      senao
         se mapa[alvoY,alvoX] = "#" entao
            se p = 1 entao
               msgVisao <- "PAREDE BLOQUEANDO"
            senao
               msgVisao <- "PAREDE AO FUNDO"
            fimse
            blq <- verdadeiro
         senao
            se bossAtivo e bossVivo e (bossX = alvoX) e (bossY = alvoY) entao
               msgVisao <- "BOSS A FRENTE"
            fimse
            temIni <- falso
            para k de 1 ate numIni faca
               se inimigoVivo[k] entao
                  se (inimigoX[k] = alvoX) e (inimigoY[k] = alvoY) entao
                     temIni <- verdadeiro
                  fimse
               fimse
            fimpara
            se (msgVisao = "") e temIni entao
               msgVisao <- "INIMIGO A FRENTE"
            fimse
            se (msgVisao = "") e (mapa[alvoY,alvoX] = "X") entao
               se saidaLiberada entao
                  msgVisao <- "SAIDA LIBERADA"
               senao
                  msgVisao <- "SAIDA VISIVEL"
               fimse
            fimse
            se msgVisao = "" entao
               se mapa[alvoY,alvoX] = "K" entao
                  msgVisao <- "ITEM A FRENTE"
               fimse
               se (msgVisao = "") e (mapa[alvoY,alvoX] = "A") entao
                  msgVisao <- "ITEM A FRENTE"
               fimse
               se (msgVisao = "") e (mapa[alvoY,alvoX] = "C") entao
                  msgVisao <- "ITEM A FRENTE"
               fimse
               se (msgVisao = "") e (mapa[alvoY,alvoX] = "W") entao
                  msgVisao <- "ITEM A FRENTE"
               fimse
            fimse
         fimse
      fimse
      p <- p + 1
   fimenquanto
   se msgVisao = "" entao
      xEsq <- px - lx
      yEsq <- py - ly
      xDir <- px + lx
      yDir <- py + ly
      paredeEsq <- falso
      paredeDir <- falso
      se (xEsq < 1) ou (xEsq > 24) ou (yEsq < 1) ou (yEsq > 12) entao
         paredeEsq <- verdadeiro
      senao
         se mapa[yEsq,xEsq] = "#" entao
            paredeEsq <- verdadeiro
         fimse
      fimse
      se (xDir < 1) ou (xDir > 24) ou (yDir < 1) ou (yDir > 12) entao
         paredeDir <- verdadeiro
      senao
         se mapa[yDir,xDir] = "#" entao
            paredeDir <- verdadeiro
         fimse
      fimse
      se paredeEsq e paredeDir entao
         msgVisao <- "CORREDOR ESTREITO"
      fimse
      se (nao paredeEsq) e (nao paredeDir) entao
         msgVisao <- "SALA ABERTA"
      fimse
      se paredeEsq e (nao paredeDir) entao
         msgVisao <- "PAREDE A ESQUERDA"
      fimse
      se paredeDir e (nao paredeEsq) entao
         msgVisao <- "PAREDE A DIREITA"
      fimse
   fimse
fimprocedimento

procedimento desenharMiraFPS()
inicio
   tela[16,42] <- "+"
   tela[15,42] <- "."
   tela[17,42] <- "."
   tela[16,41] <- "-"
   tela[16,43] <- "-"
fimprocedimento

procedimento desenharArma()
inicio
   se armaAtual = 1 entao
      tela[28,42] <- "|"
      tela[29,41] <- "["
      tela[29,42] <- "_"
      tela[29,43] <- "]"
   fimse
   se armaAtual = 2 entao
      tela[28,41] <- "|"
      tela[28,43] <- "|"
      tela[29,39] <- "["
      tela[29,40] <- "="
      tela[29,41] <- "="
      tela[29,42] <- "="
      tela[29,43] <- "="
      tela[29,44] <- "]"
   fimse
   se armaAtual = 3 entao
      tela[28,42] <- "|"
      tela[29,39] <- "="
      tela[29,40] <- "="
      tela[29,41] <- "="
      tela[29,42] <- "|"
      tela[29,43] <- "="
      tela[29,44] <- "="
      tela[29,45] <- "="
   fimse
   se armaAtual = 4 entao
      tela[28,41] <- "("
      tela[28,42] <- "O"
      tela[28,43] <- ")"
      tela[29,39] <- "["
      tela[29,40] <- "#"
      tela[29,41] <- "#"
      tela[29,42] <- "#"
      tela[29,43] <- "#"
      tela[29,44] <- "]"
   fimse
   se estadoArma = 3 entao
      tela[27,42] <- "X"
   fimse
   se estadoArma = 4 entao
      tela[30,41] <- "["
      tela[30,42] <- "#"
      tela[30,43] <- "]"
   fimse
   se estadoArma = 2 entao
      se armaAtual = 1 entao
         tela[16,42] <- "*"
      fimse
      se armaAtual = 2 entao
         tela[16,41] <- "*"
         tela[16,43] <- "*"
      fimse
      se armaAtual = 3 entao
         tela[15,42] <- "*"
         tela[16,42] <- "*"
      fimse
      se armaAtual = 4 entao
         tela[15,42] <- "*"
         tela[16,41] <- "*"
         tela[16,43] <- "*"
         tela[17,42] <- "*"
      fimse
   fimse
   se acertouFrame >= 1 entao
      tela[16,38] <- "*"
      tela[16,54] <- "*"
      tela[17,36] <- "*"
      tela[17,56] <- "*"
   fimse
fimprocedimento

procedimento desenharVignetteDano()
var i: inteiro
inicio
   se danoFrame >= 1 entao
      para i de 4 ate 79 faca
         tela[6,i] <- "!"
         tela[30,i] <- "!"
      fimpara
      para i de 7 ate 29 faca
         tela[i,4] <- "!"
         tela[i,79] <- "!"
      fimpara
   fimse
fimprocedimento

procedimento desenharSlotArsenal(codigoArma: inteiro; linPainel: inteiro; nomePainel: caractere)
var marcaAbre: caractere
    marcaFecha: caractere
inicio
   marcaAbre <- "-"
   marcaFecha <- "-"
   se armaDesbloqueada[codigoArma] entao
      marcaAbre <- "+"
      marcaFecha <- "+"
   fimse
   se armaAtual = codigoArma entao
      marcaAbre <- ">"
      marcaFecha <- "<"
   fimse
   ptStr("                                   ", linPainel, 83)
   ptStr(marcaAbre, linPainel, 84)
   ptStr(nomePainel, linPainel, 85)
   se armaDesbloqueada[codigoArma] entao
      ptInt3(armaAmmo[codigoArma], linPainel, 96)
      ptStr("/", linPainel, 99)
      ptInt3(armaAmmoMax[codigoArma], linPainel, 100)
      ptStr(marcaFecha, linPainel, 103)
   senao
      ptStr("BLOQ", linPainel, 96)
      ptStr("--/--", linPainel, 101)
      ptStr(marcaFecha, linPainel, 106)
   fimse
fimprocedimento

procedimento desenharPainelArsenal()
var i: inteiro
inicio
   para i de 82 ate 119 faca
      tela[20,i] <- "-"
      tela[25,i] <- "-"
   fimpara
   tela[20,82] <- "+"
   tela[20,119] <- "+"
   tela[25,82] <- "+"
   tela[25,119] <- "+"
   para i de 21 ate 24 faca
      tela[i,82] <- "|"
      tela[i,119] <- "|"
      ptStr("                                   ", i, 83)
   fimpara
   ptStr("ARSENAL Z/X", 20, 96)
   desenharSlotArsenal(1, 21, "PISTOLA")
   desenharSlotArsenal(2, 22, "SHOTGUN")
   desenharSlotArsenal(3, 23, "RIFLE  ")
   desenharSlotArsenal(4, 24, "CANNON ")
fimprocedimento

procedimento desenharCartaoArma()
var i: inteiro
    bs: caractere
    estadoCard: caractere
inicio
   bs <- "\"
   estadoCard <- "OK"
   se estadoArma = 2 entao
      estadoCard <- "TIRO"
   fimse
   se estadoArma = 3 entao
      estadoCard <- "SEM"
   fimse
   se estadoArma = 4 entao
      estadoCard <- "REC"
   fimse
   para i de 82 ate 119 faca
      tela[26,i] <- "-"
   fimpara
   tela[26,82] <- "+"
   tela[26,119] <- "+"
   para i de 27 ate 32 faca
      tela[i,82] <- "|"
      tela[i,119] <- "|"
      ptStr("                                   ", i, 83)
   fimpara
   ptStr("ARMA ATUAL", 26, 96)
   ptStr(armaNome[armaAtual], 27, 84)
   ptInt3(armaAmmo[armaAtual], 27, 96)
   ptStr("/", 27, 99)
   ptInt3(armaAmmoMax[armaAtual], 27, 100)
   ptStr("D", 27, 105)
   ptInt(armaDano[armaAtual], 27, 106)
   ptStr(estadoCard, 27, 112)
   se armaAtual = 1 entao
      se estadoArma = 2 entao
         ptStr("             NN___>*", 28, 84)
      senao
         se estadoArma = 3 entao
            ptStr("             NN___X", 28, 84)
         senao
            ptStr("             NN___>", 28, 84)
         fimse
      fimse
      se estadoArma = 4 entao
         ptStr("          QQLFFDDFF  [#]", 30, 84)
      senao
         ptStr("          QQLFFDDFF", 30, 84)
      fimse
      ptStr("            OLJO____", 29, 84)
      ptStr("         QQOLFDBBDH" + bs + "__", 31, 84)
   fimse
   se armaAtual = 2 entao
      se estadoArma = 2 entao
         ptStr("QSUUWW==================>**", 28, 84)
      senao
         se estadoArma = 3 entao
            ptStr("QSUUWW=================X", 28, 84)
         senao
            ptStr("QSUUWW==================>", 28, 84)
         fimse
      fimse
      se estadoArma = 4 entao
         ptStr("       FFFFFFFHNL [oo]", 31, 84)
      senao
         ptStr("       FFFFFFFHNL" + bs + "____", 31, 84)
      fimse
      ptStr("LLNOOQUWWWW=============>", 29, 84)
      ptStr("  JJJNOOOQSUWWW======>", 30, 84)
   fimse
   se armaAtual = 3 entao
      se estadoArma = 2 entao
         ptStr("SUY JDDJ====================>*", 28, 84)
      senao
         se estadoArma = 3 entao
            ptStr("SUY JDDJ===================X", 28, 84)
         senao
            ptStr("SUY JDDJ====================>", 28, 84)
         fimse
      fimse
      se estadoArma = 4 entao
         ptStr("   LHDDDBBBDDDDD" + bs + "[#]", 31, 84)
      senao
         ptStr("   LHDDDBBBDDDDD" + bs + "____", 31, 84)
      fimse
      ptStr("OLOSLDDDJ==============o====>", 29, 84)
      ptStr("WUSJFLHOLJLLFBBFH=======>", 30, 84)
   fimse
   se armaAtual = 4 entao
      se estadoArma = 2 entao
         ptStr("       JJ [====O====>***", 28, 84)
      senao
         se estadoArma = 3 entao
            ptStr("       JJ [====X====>", 28, 84)
         senao
            ptStr("       JJ [====O====>", 28, 84)
         fimse
      fimse
      se estadoArma = 4 entao
         ptStr("  USODBBBBHFJNSUW [##]", 31, 84)
      senao
         ptStr("  USODBBBBHFJNSUW", 31, 84)
      fimse
      ptStr("      OOOQ [########]", 29, 84)
      ptStr("    UQNNNLOU========>", 30, 84)
   fimse
   ptStr("F TIRO R REC Z/X TROCA", 32, 88)
fimprocedimento

procedimento desenharMinimapa()
var i: inteiro
    j: inteiro
    cc: caractere
    ehIni: logico
    k: inteiro
    tipoMin: inteiro
    chrIni: caractere
inicio
   para j de 83 ate 118 faca
      tela[5,j] <- "-"
      tela[19,j] <- "-"
   fimpara
   tela[5,83] <- "+"
   tela[5,118] <- "+"
   tela[19,83] <- "+"
   tela[19,118] <- "+"
   para i de 6 ate 18 faca
      tela[i,83] <- "|"
      tela[i,118] <- "|"
   fimpara
   ptStr("[ MAPA 2D ]", 5, 96)
   para i de 1 ate 12 faca
      para j de 1 ate 24 faca
         cc <- mapa[i,j]
         ehIni <- falso
         tipoMin <- 0
         para k de 1 ate numIni faca
            se inimigoVivo[k] entao
               se (inimigoX[k] = j) e (inimigoY[k] = i) entao
                  ehIni <- verdadeiro
                  tipoMin <- inimigoTipo[k]
               fimse
            fimse
         fimpara
         se (j = px) e (i = py) entao
            tela[6+i-1, 83+j] <- charDirTab[dirOct]
         senao
            se bossAtivo e bossVivo e (bossX = j) e (bossY = i) entao
               tela[6+i-1, 83+j] <- "O"
            senao
               se ehIni entao
                  chrIni <- "M"
                  se tipoMin = 1 entao
                     chrIni <- "G"
                  fimse
                  se tipoMin = 2 entao
                     chrIni <- "B"
                  fimse
                  se tipoMin = 3 entao
                     chrIni <- "S"
                  fimse
                  se tipoMin = 4 entao
                     chrIni <- "P"
                  fimse
                  se tipoMin = 5 entao
                     chrIni <- "N"
                  fimse
                  tela[6+i-1, 83+j] <- chrIni
               senao
                  se cc = "#" entao
                     tela[6+i-1, 83+j] <- "#"
                  senao
                     se cc = "X" entao
                        tela[6+i-1, 83+j] <- "X"
                     senao
                        se cc = "K" entao
                           tela[6+i-1, 83+j] <- "K"
                        senao
                           se cc = "A" entao
                              tela[6+i-1, 83+j] <- "A"
                           senao
                              se cc = "C" entao
                                 tela[6+i-1, 83+j] <- "C"
                              senao
                                 se cc = "W" entao
                                    tela[6+i-1, 83+j] <- "W"
                                 senao
                                    tela[6+i-1, 83+j] <- "."
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse
                  fimse
               fimse
            fimse
         fimse
      fimpara
   fimpara
   desenharPainelArsenal()
   desenharCartaoArma()
fimprocedimento

procedimento desenharHUDArma()
inicio
   ptStr("ARMA ATUAL:", 4, 3)
   ptStr(armaNome[armaAtual], 4, 15)
   ptStr("AMMO:", 4, 24)
   ptInt3(ammo, 4, 29)
   ptStr("/", 4, 32)
   ptInt3(ammoMax, 4, 33)
   ptStr("DANO:", 4, 37)
   ptInt(armaDano[armaAtual], 4, 42)
   ptStr("TROCAR:Z/X", 4, 45)
   ptStr("CHV:", 4, 58)
   se temChave entao
      ptStr("SIM", 4, 62)
   senao
      ptStr("NAO", 4, 62)
   fimse
   ptStr("SAI:", 4, 67)
   se saidaLiberada entao
      ptStr("LIB", 4, 71)
   senao
      ptStr("BLO", 4, 71)
   fimse
fimprocedimento

procedimento desenharHUDBoss()
var i: inteiro
    barStrBoss: caractere
    barNBoss: inteiro
inicio
   se bossAtivo entao
      se bossVivo entao
         ptStr("BOSS[", 4, 96)
         barStrBoss <- ""
         barNBoss <- (bossVida * 10) div bossVidaMax
         se barNBoss < 0 entao
            barNBoss <- 0
         fimse
         se barNBoss > 10 entao
            barNBoss <- 10
         fimse
         para i de 1 ate 10 faca
            se i <= barNBoss entao
               barStrBoss <- barStrBoss + "#"
            senao
               barStrBoss <- barStrBoss + "."
            fimse
         fimpara
         ptStr(barStrBoss, 4, 101)
         ptStr("]", 4, 111)
         ptInt3(bossVida, 4, 112)
         ptStr("/", 4, 115)
         ptInt3(bossVidaMax, 4, 116)
      senao
         ptStr("BOSS DERROTADO", 4, 96)
      fimse
   fimse
fimprocedimento

procedimento desenharMsgComandos()
var i: inteiro
inicio
   para i de 2 ate 119 faca
      tela[33,i] <- "-"
   fimpara
   tela[33,1] <- "+"
   tela[33,120] <- "+"
   ptStr("OBJ:", 34, 3)
   ptStr(objetivoStr, 34, 8)
   ptStr("|", 34, 42)
   ptStr("WS mover | AD girar | F tiro | R rec | Z/X arma | H ajuda | Q sair | SEQ8", 34, 44)
   ptStr(">> ", 35, 3)
   ptStr(statusMsg, 35, 6)
fimprocedimento

procedimento renderizar()
inicio
   limparBuffer()
   desenharBorda()
   desenharHUD()
   desenharHUDArma()
   desenharHUDBoss()
   desenharMolduraFPS()
   preencherTetoChao()
   calcularFaixas()
   desenharParedes()
   desenharLaterais()
   desenharSaida()
   desenharItens()
   desenharInimigos()
   desenharBoss()
   desenharMiraFPS()
   desenharArma()
   desenharVignetteDano()
   desenharMinimapa()
   desenharMsgComandos()
   imprimirTela()
   danoFrame <- 0
   acertouFrame <- 0
   se bossAtacadoFrame > 0 entao
      bossAtacadoFrame <- bossAtacadoFrame - 1
   fimse
fimprocedimento


procedimento contarInimigos()
var k: inteiro
inicio
   iniVivos <- 0
   para k de 1 ate numIni faca
      se inimigoVivo[k] entao
         iniVivos <- iniVivos + 1
      fimse
   fimpara
fimprocedimento

procedimento limparMapa()
var i: inteiro
    j: inteiro
    k: inteiro
inicio
   para i de 1 ate 12 faca
      para j de 1 ate 24 faca
         mapa[i,j] <- "."
      fimpara
   fimpara
   para k de 1 ate 10 faca
      inimigoX[k] <- 0
      inimigoY[k] <- 0
      inimigoVivo[k] <- falso
      inimigoTipo[k] <- 1
      inimigoVida[k] <- 1
   fimpara
   numIni <- 0
   wPickupArma <- 0
fimprocedimento

procedimento inicializarFase1()
var i: inteiro
    j: inteiro
inicio
   limparMapa()
   para j de 1 ate 24 faca
      mapa[1,j] <- "#"
      mapa[12,j] <- "#"
   fimpara
   para i de 1 ate 12 faca
      mapa[i,1] <- "#"
      mapa[i,24] <- "#"
   fimpara
   para j de 4 ate 21 faca
      mapa[4,j] <- "#"
      mapa[8,j] <- "#"
   fimpara
   mapa[4,10] <- "."
   mapa[4,11] <- "."
   mapa[4,12] <- "."
   mapa[8,12] <- "."
   mapa[8,13] <- "."
   mapa[8,14] <- "."
   mapa[3,11] <- "A"
   mapa[9,13] <- "K"
   mapa[6,22] <- "X"
   wPickupArma <- 0
   exigeChave <- falso
   px <- 4
   py <- 6
   dirOct <- 2
   atualizarDirecao()
   numIni <- 2
   inimigoX[1] <- 10
   inimigoY[1] <- 6
   inimigoVivo[1] <- verdadeiro
   inimigoTipo[1] <- 1
   inimigoVida[1] <- 1
   inimigoX[2] <- 17
   inimigoY[2] <- 6
   inimigoVivo[2] <- verdadeiro
   inimigoTipo[2] <- 1
   inimigoVida[2] <- 1
   contarInimigos()
fimprocedimento

procedimento inicializarFase2()
var i: inteiro
    j: inteiro
inicio
   limparMapa()
   para j de 1 ate 24 faca
      mapa[1,j] <- "#"
      mapa[12,j] <- "#"
   fimpara
   para i de 1 ate 12 faca
      mapa[i,1] <- "#"
      mapa[i,24] <- "#"
   fimpara
   mapa[4,8] <- "#"
   mapa[4,9] <- "#"
   mapa[5,8] <- "#"
   mapa[8,8] <- "#"
   mapa[8,9] <- "#"
   mapa[7,8] <- "#"
   mapa[4,16] <- "#"
   mapa[4,17] <- "#"
   mapa[5,17] <- "#"
   mapa[8,16] <- "#"
   mapa[8,17] <- "#"
   mapa[7,17] <- "#"
   mapa[6,22] <- "X"
   px <- 3
   py <- 6
   dirOct <- 2
   atualizarDirecao()
   numIni <- 3
   inimigoX[1] <- 7
   inimigoY[1] <- 5
   inimigoVivo[1] <- verdadeiro
   inimigoTipo[1] <- 1
   inimigoVida[1] <- 1
   inimigoX[2] <- 14
   inimigoY[2] <- 7
   inimigoVivo[2] <- verdadeiro
   inimigoTipo[2] <- 3
   inimigoVida[2] <- 1
   inimigoX[3] <- 19
   inimigoY[3] <- 6
   inimigoVivo[3] <- verdadeiro
   inimigoTipo[3] <- 1
   inimigoVida[3] <- 1
   mapa[3,12] <- "A"
   mapa[10,12] <- "K"
   mapa[6,11] <- "W"
   mapa[10,5] <- "C"
   mapa[2,20] <- "A"
   wPickupArma <- 2
   exigeChave <- verdadeiro
   contarInimigos()
fimprocedimento

procedimento inicializarFase3()
var i: inteiro
    j: inteiro
inicio
   limparMapa()
   para j de 1 ate 24 faca
      mapa[1,j] <- "#"
      mapa[12,j] <- "#"
   fimpara
   para i de 1 ate 12 faca
      mapa[i,1] <- "#"
      mapa[i,24] <- "#"
   fimpara
   mapa[3,7] <- "#"
   mapa[3,8] <- "#"
   mapa[4,7] <- "#"
   mapa[4,8] <- "#"
   mapa[3,17] <- "#"
   mapa[3,18] <- "#"
   mapa[4,17] <- "#"
   mapa[4,18] <- "#"
   mapa[8,7] <- "#"
   mapa[8,8] <- "#"
   mapa[9,7] <- "#"
   mapa[9,8] <- "#"
   mapa[8,17] <- "#"
   mapa[8,18] <- "#"
   mapa[9,17] <- "#"
   mapa[9,18] <- "#"
   mapa[5,4] <- "A"
   mapa[6,14] <- "W"
   mapa[5,15] <- "A"
   mapa[7,15] <- "K"
   mapa[11,12] <- "A"
   mapa[6,23] <- "X"
   wPickupArma <- 3
   exigeChave <- falso
   px <- 3
   py <- 6
   dirOct <- 2
   atualizarDirecao()
   numIni <- 4
   inimigoX[1] <- 11
   inimigoY[1] <- 6
   inimigoVivo[1] <- verdadeiro
   inimigoTipo[1] <- 2
   inimigoVida[1] <- 3
   inimigoX[2] <- 14
   inimigoY[2] <- 3
   inimigoVivo[2] <- verdadeiro
   inimigoTipo[2] <- 4
   inimigoVida[2] <- 2
   inimigoX[3] <- 14
   inimigoY[3] <- 10
   inimigoVivo[3] <- verdadeiro
   inimigoTipo[3] <- 3
   inimigoVida[3] <- 1
   inimigoX[4] <- 20
   inimigoY[4] <- 6
   inimigoVivo[4] <- verdadeiro
   inimigoTipo[4] <- 1
   inimigoVida[4] <- 1
   contarInimigos()
fimprocedimento

procedimento inicializarFase4()
var i: inteiro
    j: inteiro
inicio
   limparMapa()
   para j de 1 ate 24 faca
      mapa[1,j] <- "#"
      mapa[12,j] <- "#"
   fimpara
   para i de 1 ate 12 faca
      mapa[i,1] <- "#"
      mapa[i,24] <- "#"
   fimpara
   mapa[3,6] <- "#"
   mapa[3,7] <- "#"
   mapa[3,8] <- "#"
   mapa[3,9] <- "#"
   mapa[3,10] <- "#"
   mapa[3,11] <- "#"
   mapa[4,11] <- "#"
   mapa[5,11] <- "#"
   mapa[3,16] <- "#"
   mapa[3,17] <- "#"
   mapa[3,18] <- "#"
   mapa[3,19] <- "#"
   mapa[3,20] <- "#"
   mapa[3,21] <- "#"
   mapa[4,16] <- "#"
   mapa[5,16] <- "#"
   mapa[9,6] <- "#"
   mapa[9,7] <- "#"
   mapa[9,8] <- "#"
   mapa[9,9] <- "#"
   mapa[9,10] <- "#"
   mapa[9,11] <- "#"
   mapa[7,11] <- "#"
   mapa[8,11] <- "#"
   mapa[9,16] <- "#"
   mapa[9,17] <- "#"
   mapa[9,18] <- "#"
   mapa[9,19] <- "#"
   mapa[9,20] <- "#"
   mapa[9,21] <- "#"
   mapa[7,16] <- "#"
   mapa[8,16] <- "#"
   mapa[2,5] <- "A"
   mapa[6,5] <- "W"
   mapa[10,9] <- "A"
   mapa[6,14] <- "K"
   mapa[6,18] <- "A"
   mapa[2,19] <- "K"
   mapa[10,19] <- "C"
   mapa[6,22] <- "X"
   wPickupArma <- 4
   exigeChave <- verdadeiro
   px <- 3
   py <- 6
   dirOct <- 2
   atualizarDirecao()
   numIni <- 4
   inimigoX[1] <- 9
   inimigoY[1] <- 6
   inimigoVivo[1] <- verdadeiro
   inimigoTipo[1] <- 2
   inimigoVida[1] <- 3
   inimigoX[2] <- 13
   inimigoY[2] <- 6
   inimigoVivo[2] <- verdadeiro
   inimigoTipo[2] <- 3
   inimigoVida[2] <- 1
   inimigoX[3] <- 18
   inimigoY[3] <- 5
   inimigoVivo[3] <- verdadeiro
   inimigoTipo[3] <- 5
   inimigoVida[3] <- 2
   inimigoX[4] <- 19
   inimigoY[4] <- 7
   inimigoVivo[4] <- verdadeiro
   inimigoTipo[4] <- 4
   inimigoVida[4] <- 2
   contarInimigos()
fimprocedimento

procedimento inicializarFase5()
var i: inteiro
    j: inteiro
inicio
   limparMapa()
   para j de 1 ate 24 faca
      mapa[1,j] <- "#"
      mapa[12,j] <- "#"
   fimpara
   para i de 1 ate 12 faca
      mapa[i,1] <- "#"
      mapa[i,24] <- "#"
   fimpara
   mapa[3,4] <- "#"
   mapa[3,5] <- "#"
   mapa[4,4] <- "#"
   mapa[4,5] <- "#"
   mapa[3,20] <- "#"
   mapa[3,21] <- "#"
   mapa[4,20] <- "#"
   mapa[4,21] <- "#"
   mapa[8,4] <- "#"
   mapa[8,5] <- "#"
   mapa[9,4] <- "#"
   mapa[9,5] <- "#"
   mapa[8,20] <- "#"
   mapa[8,21] <- "#"
   mapa[9,20] <- "#"
   mapa[9,21] <- "#"
   mapa[2,15] <- "K"
   mapa[5,22] <- "K"
   mapa[6,8] <- "A"
   mapa[7,12] <- "K"
   mapa[9,12] <- "A"
   mapa[11,15] <- "A"
   mapa[6,23] <- "X"
   wPickupArma <- 0
   exigeChave <- falso
   px <- 3
   py <- 6
   dirOct <- 2
   atualizarDirecao()
   numIni <- 3
   inimigoX[1] <- 10
   inimigoY[1] <- 6
   inimigoVivo[1] <- verdadeiro
   inimigoTipo[1] <- 2
   inimigoVida[1] <- 3
   inimigoX[2] <- 15
   inimigoY[2] <- 4
   inimigoVivo[2] <- verdadeiro
   inimigoTipo[2] <- 5
   inimigoVida[2] <- 2
   inimigoX[3] <- 15
   inimigoY[3] <- 8
   inimigoVivo[3] <- verdadeiro
   inimigoTipo[3] <- 5
   inimigoVida[3] <- 2
   bossAtivo <- verdadeiro
   bossTipoFase <- 3
   bossX <- 18
   bossY <- 6
   bossVivo <- verdadeiro
   bossVidaMax <- 16
   bossVida <- 16
   bossDano <- 18
   bossNome <- "OVERLORD ASCII"
   bossBloqueiaSaida <- verdadeiro
   contarInimigos()
fimprocedimento

procedimento aplicarModoDemo()
inicio
   se modoDemo entao
      armaAmmo[1] <- armaAmmoMax[1]
      armaAmmo[2] <- armaAmmoMax[2]
      armaAmmo[3] <- armaAmmoMax[3]
      se fase >= 4 entao
         armaDesbloqueada[4] <- verdadeiro
         armaAmmo[4] <- armaAmmoMax[4]
      fimse
      se fase = 1 entao
         numIni <- 1
         inimigoVivo[2] <- falso
         inimigoVivo[3] <- falso
         mapa[6,8] <- "A"
         mapa[7,8] <- "K"
      fimse
      se fase = 2 entao
         numIni <- 2
         inimigoVivo[3] <- falso
         mapa[10,5] <- "."
         mapa[6,11] <- "."
         mapa[6,6] <- "C"
         mapa[6,7] <- "W"
         mapa[6,9] <- "A"
         mapa[7,6] <- "K"
      fimse
      se fase = 3 entao
         numIni <- 2
         inimigoVivo[3] <- falso
         inimigoVivo[4] <- falso
         mapa[6,10] <- "A"
         mapa[7,10] <- "K"
      fimse
      se fase = 4 entao
         numIni <- 2
         inimigoVivo[3] <- falso
         inimigoVivo[4] <- falso
         mapa[10,19] <- "."
         mapa[6,7] <- "C"
         mapa[6,9] <- "A"
         mapa[7,9] <- "K"
      fimse
      se fase = 5 entao
         numIni <- 1
         inimigoVivo[2] <- falso
         inimigoVivo[3] <- falso
         bossX <- 15
         bossY <- 6
         bossVidaMax <- 10
         bossVida <- 10
         bossDano <- 12
         mapa[6,6] <- "A"
         mapa[7,6] <- "K"
         mapa[6,10] <- "A"
      fimse
      contarInimigos()
   fimse
fimprocedimento

procedimento inicializarFase()
inicio
   bossAtivo <- falso
   bossVivo <- falso
   bossTipoFase <- 0
   bossX <- 0
   bossY <- 0
   bossVida <- 0
   bossVidaMax <- 1
   bossDano <- 0
   bossNome <- ""
   bossAtacadoFrame <- 0
   bossIntroMostrada <- falso
   bossBloqueiaSaida <- falso
   exigeChave <- falso
   saidaLiberada <- verdadeiro
   temChave <- falso
   se fase = 1 entao
      inicializarFase1()
   fimse
   se fase = 2 entao
      inicializarFase2()
   fimse
   se fase = 3 entao
      inicializarFase3()
   fimse
   se fase = 4 entao
      inicializarFase4()
   fimse
   se fase = 5 entao
      inicializarFase5()
   fimse
   aplicarModoDemo()
   atualizarSaida()
   vida <- vidaMax
   ammoMax <- armaAmmoMax[armaAtual]
   ammo <- ammoMax
   armaAmmo[armaAtual] <- ammo
   estadoArma <- 1
   danoFrame <- 0
   acertouFrame <- 0
   turnosInimigos <- 0
   ultimoItemColetado <- "NENHUM"
   statusMsg <- "Fase iniciada"
   se exigeChave entao
      objetivoStr <- "Pegue a chave e va para a saida "
   senao
      se bossBloqueiaSaida entao
         objetivoStr <- "Derrote o boss para liberar X   "
      senao
         objetivoStr <- "Encontre a saida X              "
      fimse
   fimse
   faseFim <- falso
fimprocedimento

procedimento tentarAndar(passoFr: inteiro)
var alvoX: inteiro
    alvoY: inteiro
    k: inteiro
    livre: logico
    celula: caractere
inicio
   alvoX <- px + passoFr*dx
   alvoY <- py + passoFr*dy
   livre <- verdadeiro
   se (alvoX < 1) ou (alvoX > 24) ou (alvoY < 1) ou (alvoY > 12) entao
      livre <- falso
   senao
      celula <- mapa[alvoY,alvoX]
      se celula = "#" entao
         livre <- falso
      fimse
      para k de 1 ate numIni faca
         se inimigoVivo[k] entao
            se (inimigoX[k] = alvoX) e (inimigoY[k] = alvoY) entao
               livre <- falso
            fimse
         fimse
      fimpara
      se bossAtivo e bossVivo entao
         se (bossX = alvoX) e (bossY = alvoY) entao
            livre <- falso
         fimse
      fimse
   fimse
   se livre entao
      px <- alvoX
      py <- alvoY
      celula <- mapa[py,px]
      se celula = "K" entao
         vida <- vida + 35
         se vida > vidaMax entao
            vida <- vidaMax
         fimse
         mapa[py,px] <- "."
         kitsColetados <- kitsColetados + 1
         pontos <- pontos + 25
         ultimoItemColetado <- "KIT DE VIDA"
         statusMsg <- "Kit coletado"
      senao
         se celula = "A" entao
            ammo <- ammo + 6
            se ammo > ammoMax entao
               ammo <- ammoMax
            fimse
            armaAmmo[armaAtual] <- ammo
            mapa[py,px] <- "."
            ammoColetadas <- ammoColetadas + 1
            pontos <- pontos + 15
            ultimoItemColetado <- "MUNICAO"
            statusMsg <- "Municao coletada"
         senao
            se celula = "C" entao
               temChave <- verdadeiro
               mapa[py,px] <- "."
               chavesColetadas <- chavesColetadas + 1
               pontos <- pontos + 35
               ultimoItemColetado <- "CHAVE"
               atualizarSaida()
               se exigeChave entao
                  se saidaLiberada entao
                     statusMsg <- "Chave coletada. Saida liberada"
                  senao
                     statusMsg <- "Chave coletada"
                  fimse
               senao
                  statusMsg <- "Chave coletada"
               fimse
            senao
               se celula = "W" entao
                  mapa[py,px] <- "."
                  armasColetadasTot <- armasColetadasTot + 1
                  pontos <- pontos + 60
                  se (wPickupArma >= 2) e (wPickupArma <= 4) entao
                     armaDesbloqueada[wPickupArma] <- verdadeiro
                     armaAmmo[wPickupArma] <- armaAmmoMax[wPickupArma]
                     se wPickupArma = 2 entao
                        ultimoItemColetado <- "SHOTGUN"
                        statusMsg <- "Shotgun liberada"
                     fimse
                     se wPickupArma = 3 entao
                        ultimoItemColetado <- "RIFLE"
                        statusMsg <- "Rifle liberado"
                     fimse
                     se wPickupArma = 4 entao
                        ultimoItemColetado <- "CANNON"
                        statusMsg <- "Cannon liberado"
                     fimse
                  senao
                     ultimoItemColetado <- "ARMA"
                     statusMsg <- "Arma coletada"
                  fimse
               senao
                  se passoFr = 1 entao
                     statusMsg <- "Andou para " + dirNome
                  senao
                     statusMsg <- "Recuou um passo"
                  fimse
               fimse
            fimse
         fimse
      fimse
      se mapa[py,px] = "X" entao
         atualizarSaida()
         se saidaLiberada entao
            statusMsg <- "Saida alcancada"
            faseFim <- verdadeiro
            pontos <- pontos + 100
         senao
            se bossBloqueiaSaida e bossVivo entao
               statusMsg <- "Saida bloqueada. Derrote o boss"
            senao
               se exigeChave e (nao temChave) entao
                  statusMsg <- "Saida bloqueada. Pegue a chave"
               senao
                  statusMsg <- "Saida bloqueada"
               fimse
            fimse
         fimse
      fimse
   senao
      statusMsg <- "Bloqueado pela parede"
   fimse
fimprocedimento

procedimento atirar()
var p: inteiro
    ax: inteiro
    ay: inteiro
    blq: logico
    k: inteiro
    achou: logico
    podeAtirar: logico
    tipoAlvo: inteiro
    danoTiro: inteiro
inicio
   podeAtirar <- verdadeiro
   se ammo <= 0 entao
      statusMsg <- "Sem municao. Use R ou troque de arma"
      estadoArma <- 3
      podeAtirar <- falso
   fimse
   se podeAtirar entao
      ammo <- ammo - 1
      armaAmmo[armaAtual] <- ammo
      estadoArma <- 2
      tiroFrame <- 1
      blq <- falso
      achou <- falso
      statusMsg <- armaNome[armaAtual] + " disparada"
      para p de 1 ate 5 faca
         se nao blq e nao achou entao
            ax <- px + p*dx
            ay <- py + p*dy
            se (ax < 1) ou (ax > 24) ou (ay < 1) ou (ay > 12) entao
               blq <- verdadeiro
            senao
               se mapa[ay,ax] = "#" entao
                  blq <- verdadeiro
                  statusMsg <- "Tiro bloqueado pela parede"
               senao
                  danoTiro <- armaDano[armaAtual]
                  se (armaAtual = 2) e (p <= 2) entao
                     danoTiro <- danoTiro + 1
                  fimse
                  se bossAtivo e bossVivo entao
                     se (bossX = ax) e (bossY = ay) entao
                        bossVida <- bossVida - danoTiro
                        achou <- verdadeiro
                        acertouFrame <- 1
                        bossAtacadoFrame <- 2
                        se bossVida <= 0 entao
                           bossVivo <- falso
                           pontos <- pontos + 250
                           atualizarSaida()
                           se bossTipoFase = 1 entao
                              statusMsg <- "Boss derrotado"
                           fimse
                           se bossTipoFase = 2 entao
                              statusMsg <- "Boss derrotado"
                           fimse
                           se bossTipoFase = 3 entao
                              statusMsg <- "Boss derrotado"
                           fimse
                        senao
                           statusMsg <- "Boss atingido"
                        fimse
                     fimse
                  fimse
                  para k de 1 ate numIni faca
                     se nao achou e inimigoVivo[k] entao
                        se (inimigoX[k] = ax) e (inimigoY[k] = ay) entao
                           inimigoVida[k] <- inimigoVida[k] - danoTiro
                           achou <- verdadeiro
                           acertouFrame <- 1
                           tipoAlvo <- inimigoTipo[k]
                           se inimigoVida[k] <= 0 entao
                              inimigoVivo[k] <- falso
                              inimigosMortos <- inimigosMortos + 1
                              pontos <- pontos + 50
                              se tipoAlvo = 1 entao
                                 statusMsg <- "Grunt eliminado"
                              fimse
                              se tipoAlvo = 2 entao
                                 statusMsg <- "Brute eliminado"
                              fimse
                              se tipoAlvo = 3 entao
                                 statusMsg <- "Stalker eliminado"
                              fimse
                              se tipoAlvo = 4 entao
                                 statusMsg <- "Spitter eliminado"
                              fimse
                              se tipoAlvo = 5 entao
                                 statusMsg <- "Sentinel eliminado"
                              fimse
                           senao
                              se tipoAlvo = 2 entao
                                 statusMsg <- "Brute atingido"
                              senao
                                 statusMsg <- "Inimigo atingido"
                              fimse
                           fimse
                        fimse
                     fimse
                  fimpara
               fimse
            fimse
         fimse
      fimpara
      contarInimigos()
   fimse
fimprocedimento

procedimento recarregar()
inicio
   se ammo >= ammoMax entao
      statusMsg <- "Carregador cheio"
   senao
      ammo <- ammoMax
      armaAmmo[armaAtual] <- ammoMax
      estadoArma <- 4
      statusMsg <- "Recarregado"
   fimse
fimprocedimento

procedimento proximaArma()
var idxNova: inteiro
    tentativa: inteiro
    encontrada: logico
inicio
   armaAmmo[armaAtual] <- ammo
   armaAmmoMax[armaAtual] <- ammoMax
   encontrada <- falso
   idxNova <- armaAtual
   tentativa <- 0
   enquanto (nao encontrada) e (tentativa < 4) faca
      tentativa <- tentativa + 1
      idxNova <- idxNova + 1
      se idxNova > 4 entao
         idxNova <- 1
      fimse
      se armaDesbloqueada[idxNova] e (idxNova <> armaAtual) entao
         encontrada <- verdadeiro
      fimse
   fimenquanto
   se encontrada entao
      armaAtual <- idxNova
      ammo <- armaAmmo[armaAtual]
      ammoMax <- armaAmmoMax[armaAtual]
      estadoArma <- 1
      statusMsg <- "Arma equipada: " + armaNome[armaAtual]
   senao
      statusMsg <- "Nenhuma outra arma disponivel"
   fimse
fimprocedimento

procedimento armaAnterior()
var idxNova: inteiro
    tentativa: inteiro
    encontrada: logico
inicio
   armaAmmo[armaAtual] <- ammo
   armaAmmoMax[armaAtual] <- ammoMax
   encontrada <- falso
   idxNova <- armaAtual
   tentativa <- 0
   enquanto (nao encontrada) e (tentativa < 4) faca
      tentativa <- tentativa + 1
      idxNova <- idxNova - 1
      se idxNova < 1 entao
         idxNova <- 4
      fimse
      se armaDesbloqueada[idxNova] e (idxNova <> armaAtual) entao
         encontrada <- verdadeiro
      fimse
   fimenquanto
   se encontrada entao
      armaAtual <- idxNova
      ammo <- armaAmmo[armaAtual]
      ammoMax <- armaAmmoMax[armaAtual]
      estadoArma <- 1
      statusMsg <- "Arma equipada: " + armaNome[armaAtual]
   senao
      statusMsg <- "Nenhuma outra arma disponivel"
   fimse
fimprocedimento

procedimento virarEsq()
inicio
   se dirOct = 0 entao
      dirOct <- 7
   senao
      dirOct <- dirOct - 1
   fimse
   atualizarDirecao()
   statusMsg <- "Girou para a esquerda"
fimprocedimento

procedimento virarDir()
inicio
   se dirOct = 7 entao
      dirOct <- 0
   senao
      dirOct <- dirOct + 1
   fimse
   atualizarDirecao()
   statusMsg <- "Girou para a direita"
fimprocedimento

procedimento inimigosAtacam()
var k: inteiro
    ax: inteiro
    ay: inteiro
    diffX: inteiro
    diffY: inteiro
    dano: inteiro
    distQ: inteiro
    atacaram: inteiro
    tipoIni: inteiro
    danoUni: inteiro
    ultimoTipo: inteiro
inicio
   dano <- 0
   atacaram <- 0
   ultimoTipo <- 0
   para k de 1 ate numIni faca
      se inimigoVivo[k] entao
         ax <- inimigoX[k]
         ay <- inimigoY[k]
         diffX <- ax - px
         diffY <- ay - py
         distQ <- diffX*diffX + diffY*diffY
         se distQ <= 2 entao
            tipoIni <- inimigoTipo[k]
            danoUni <- 6
            se tipoIni = 2 entao
               danoUni <- 12
            fimse
            se tipoIni = 3 entao
               danoUni <- 5
            fimse
            se tipoIni = 4 entao
               danoUni <- 6
            fimse
            se tipoIni = 5 entao
               danoUni <- 10
            fimse
            se distQ = 2 entao
               danoUni <- danoUni - 2
               se danoUni < 1 entao
                  danoUni <- 1
               fimse
            fimse
            dano <- dano + danoUni
            atacaram <- atacaram + 1
            ultimoTipo <- tipoIni
         fimse
      fimse
   fimpara
   se dano > 24 entao
      dano <- 24
   fimse
   se dano > 0 entao
      vida <- vida - dano
      danoFrame <- 1
      se atacaram = 1 entao
         se ultimoTipo = 1 entao
            statusMsg <- "Grunt atacou voce"
         fimse
         se ultimoTipo = 2 entao
            statusMsg <- "Brute atacou voce"
         fimse
         se ultimoTipo = 3 entao
            statusMsg <- "Stalker atacou voce"
         fimse
         se ultimoTipo = 4 entao
            statusMsg <- "Spitter acertou voce"
         fimse
         se ultimoTipo = 5 entao
            statusMsg <- "Sentinel atacou voce"
         fimse
      senao
         statusMsg <- "Varios inimigos atacaram"
      fimse
      se vida < 0 entao
         vida <- 0
      fimse
   fimse
fimprocedimento

procedimento spittersAtacam()
var k: inteiro
    sx: inteiro
    sy: inteiro
    diffX: inteiro
    diffY: inteiro
    absDX: inteiro
    absDY: inteiro
    stepX: inteiro
    stepY: inteiro
    ehLinha: logico
    p: inteiro
    tx: inteiro
    ty: inteiro
    blq: logico
    danoTotal: inteiro
    acertou: logico
    maxDist: inteiro
inicio
   danoTotal <- 0
   acertou <- falso
   se turnosInimigos mod 2 = 0 entao
      para k de 1 ate numIni faca
         se inimigoVivo[k] entao
            se inimigoTipo[k] = 4 entao
               sx <- inimigoX[k]
               sy <- inimigoY[k]
               diffX <- px - sx
               diffY <- py - sy
               absDX <- diffX
               se absDX < 0 entao
                  absDX <- -absDX
               fimse
               absDY <- diffY
               se absDY < 0 entao
                  absDY <- -absDY
               fimse
               maxDist <- absDX
               se absDY > maxDist entao
                  maxDist <- absDY
               fimse
               ehLinha <- falso
               se (diffX = 0) e (diffY <> 0) entao
                  ehLinha <- verdadeiro
               fimse
               se (diffY = 0) e (diffX <> 0) entao
                  ehLinha <- verdadeiro
               fimse
               se (absDX = absDY) e (absDX > 0) entao
                  ehLinha <- verdadeiro
               fimse
               se ehLinha e (maxDist >= 2) e (maxDist <= 4) entao
                  stepX <- 0
                  stepY <- 0
                  se diffX > 0 entao
                     stepX <- 1
                  fimse
                  se diffX < 0 entao
                     stepX <- -1
                  fimse
                  se diffY > 0 entao
                     stepY <- 1
                  fimse
                  se diffY < 0 entao
                     stepY <- -1
                  fimse
                  blq <- falso
                  p <- 1
                  enquanto (p <= 5) e (nao blq) faca
                     tx <- sx + p*stepX
                     ty <- sy + p*stepY
                     se (tx = px) e (ty = py) entao
                        danoTotal <- danoTotal + 6
                        acertou <- verdadeiro
                        blq <- verdadeiro
                     senao
                        se (tx < 1) ou (tx > 24) ou (ty < 1) ou (ty > 12) entao
                           blq <- verdadeiro
                        senao
                           se mapa[ty,tx] = "#" entao
                              blq <- verdadeiro
                           fimse
                        fimse
                     fimse
                     p <- p + 1
                  fimenquanto
               fimse
            fimse
         fimse
      fimpara
   fimse
   se acertou entao
      vida <- vida - danoTotal
      danoFrame <- 1
      statusMsg <- "Spitter atacou a distancia"
      se vida < 0 entao
         vida <- 0
      fimse
   fimse
fimprocedimento

procedimento bossMove()
var nx: inteiro
    ny: inteiro
    dxi: inteiro
    dyi: inteiro
    absX: inteiro
    absY: inteiro
    livre: logico
    moveuOk: logico
    tentativa: inteiro
    k: inteiro
    bloqueio: logico
inicio
   se bossAtivo entao
      se bossVivo entao
         se turnosInimigos mod 3 = 0 entao
            absX <- bossX - px
            se absX < 0 entao
               absX <- -absX
            fimse
            absY <- bossY - py
            se absY < 0 entao
               absY <- -absY
            fimse
            se (absX + absY) > 1 entao
               dxi <- 0
               dyi <- 0
               se bossX < px entao
                  dxi <- 1
               fimse
               se bossX > px entao
                  dxi <- -1
               fimse
               se bossY < py entao
                  dyi <- 1
               fimse
               se bossY > py entao
                  dyi <- -1
               fimse
               moveuOk <- falso
               tentativa <- 0
               enquanto (nao moveuOk) e (tentativa < 3) faca
                  tentativa <- tentativa + 1
                  se tentativa = 1 entao
                     se absX >= absY entao
                        nx <- bossX + dxi
                        ny <- bossY
                     senao
                        nx <- bossX
                        ny <- bossY + dyi
                     fimse
                  fimse
                  se tentativa = 2 entao
                     se absX >= absY entao
                        nx <- bossX
                        ny <- bossY + dyi
                     senao
                        nx <- bossX + dxi
                        ny <- bossY
                     fimse
                  fimse
                  se tentativa = 3 entao
                     nx <- bossX
                     ny <- bossY
                  fimse
                  livre <- verdadeiro
                  se (nx < 1) ou (nx > 24) ou (ny < 1) ou (ny > 12) entao
                     livre <- falso
                  fimse
                  se livre entao
                     se mapa[ny,nx] = "#" entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     se (nx = px) e (ny = py) entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     bloqueio <- falso
                     para k de 1 ate numIni faca
                        se inimigoVivo[k] entao
                           se (inimigoX[k] = nx) e (inimigoY[k] = ny) entao
                              bloqueio <- verdadeiro
                           fimse
                        fimse
                     fimpara
                     se bloqueio entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     se (nx <> bossX) ou (ny <> bossY) entao
                        bossX <- nx
                        bossY <- ny
                     fimse
                     moveuOk <- verdadeiro
                  senao
                     se tentativa = 3 entao
                        moveuOk <- verdadeiro
                     fimse
                  fimse
               fimenquanto
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento bossAtaca()
var diffX: inteiro
    diffY: inteiro
    distQ: inteiro
inicio
   se bossAtivo entao
      se bossVivo entao
         diffX <- bossX - px
         diffY <- bossY - py
         distQ <- diffX*diffX + diffY*diffY
         se distQ <= 4 entao
            se turnosInimigos mod 2 = 0 entao
               vida <- vida - bossDano
               danoFrame <- 1
               se bossTipoFase = 1 entao
                  statusMsg <- "Boss atacou voce"
               fimse
               se bossTipoFase = 2 entao
                  statusMsg <- "Boss atacou voce"
               fimse
               se bossTipoFase = 3 entao
                  statusMsg <- "Boss atacou voce"
               fimse
               se vida < 0 entao
                  vida <- 0
               fimse
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento inimigosMovem()
var k: inteiro
    outro: inteiro
    nx: inteiro
    ny: inteiro
    dxi: inteiro
    dyi: inteiro
    absX: inteiro
    absY: inteiro
    livre: logico
    colidiu: logico
    moveuOk: logico
    tentativa: inteiro
    moveuTotal: inteiro
    bloqueouTotal: inteiro
    perto: inteiro
    tipoIni: inteiro
    moveAgora: logico
inicio
   turnosInimigos <- turnosInimigos + 1
   se turnosInimigos > 30000 entao
      turnosInimigos <- 0
   fimse
   moveuTotal <- 0
   bloqueouTotal <- 0
   perto <- 0
   para k de 1 ate numIni faca
      se inimigoVivo[k] entao
         tipoIni <- inimigoTipo[k]
         moveAgora <- falso
         se tipoIni = 3 entao
            moveAgora <- verdadeiro
         fimse
         se tipoIni = 1 entao
            se turnosInimigos mod 2 = 0 entao
               moveAgora <- verdadeiro
            fimse
         fimse
         se tipoIni = 5 entao
            se turnosInimigos mod 3 = 0 entao
               moveAgora <- verdadeiro
            fimse
         fimse
         se tipoIni = 2 entao
            se turnosInimigos mod 3 = 0 entao
               moveAgora <- verdadeiro
            fimse
         fimse
         se tipoIni = 4 entao
            se turnosInimigos mod 4 = 0 entao
               moveAgora <- verdadeiro
            fimse
         fimse
         absX <- inimigoX[k] - px
         se absX < 0 entao
            absX <- -absX
         fimse
         absY <- inimigoY[k] - py
         se absY < 0 entao
            absY <- -absY
         fimse
         se (absX + absY) <= 1 entao
            perto <- perto + 1
         senao
            se moveAgora entao
               dxi <- 0
               dyi <- 0
               se inimigoX[k] < px entao
                  dxi <- 1
               fimse
               se inimigoX[k] > px entao
                  dxi <- -1
               fimse
               se inimigoY[k] < py entao
                  dyi <- 1
               fimse
               se inimigoY[k] > py entao
                  dyi <- -1
               fimse
               moveuOk <- falso
               tentativa <- 0
               enquanto (nao moveuOk) e (tentativa < 3) faca
                  tentativa <- tentativa + 1
                  se tentativa = 1 entao
                     se absX >= absY entao
                        nx <- inimigoX[k] + dxi
                        ny <- inimigoY[k]
                     senao
                        nx <- inimigoX[k]
                        ny <- inimigoY[k] + dyi
                     fimse
                  fimse
                  se tentativa = 2 entao
                     se absX >= absY entao
                        nx <- inimigoX[k]
                        ny <- inimigoY[k] + dyi
                     senao
                        nx <- inimigoX[k] + dxi
                        ny <- inimigoY[k]
                     fimse
                  fimse
                  se tentativa = 3 entao
                     nx <- inimigoX[k]
                     ny <- inimigoY[k]
                  fimse
                  livre <- verdadeiro
                  se (nx < 1) ou (nx > 24) ou (ny < 1) ou (ny > 12) entao
                     livre <- falso
                  fimse
                  se livre entao
                     se mapa[ny,nx] = "#" entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     se (nx = px) e (ny = py) entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     colidiu <- falso
                     para outro de 1 ate numIni faca
                        se (outro <> k) e inimigoVivo[outro] entao
                           se (inimigoX[outro] = nx) e (inimigoY[outro] = ny) entao
                              colidiu <- verdadeiro
                           fimse
                        fimse
                     fimpara
                     se colidiu entao
                        livre <- falso
                     fimse
                  fimse
                  se livre entao
                     se bossAtivo e bossVivo entao
                        se (bossX = nx) e (bossY = ny) entao
                           livre <- falso
                        fimse
                     fimse
                  fimse
                  se livre entao
                     se (nx <> inimigoX[k]) ou (ny <> inimigoY[k]) entao
                        inimigoX[k] <- nx
                        inimigoY[k] <- ny
                        moveuTotal <- moveuTotal + 1
                     fimse
                     moveuOk <- verdadeiro
                  senao
                     se tentativa = 3 entao
                        bloqueouTotal <- bloqueouTotal + 1
                        moveuOk <- verdadeiro
                     fimse
                  fimse
               fimenquanto
            fimse
         fimse
      fimse
   fimpara
   se moveuTotal > 0 entao
      statusMsg <- "Inimigos se aproximam"
   senao
      se bloqueouTotal > 0 entao
         se perto = 0 entao
            statusMsg <- "Inimigos bloqueados"
         fimse
      fimse
   fimse
fimprocedimento

procedimento atualizarSaida()
inicio
   saidaLiberada <- verdadeiro
   se exigeChave entao
      se nao temChave entao
         saidaLiberada <- falso
      fimse
   fimse
   se bossBloqueiaSaida entao
      se bossVivo entao
         saidaLiberada <- falso
      fimse
   fimse
fimprocedimento

procedimento atualizarObjetivo()
inicio
   atualizarSaida()
   objetivoStr <- "Encontre a saida X              "
   se iniVivos > 0 entao
      objetivoStr <- "Elimine os inimigos             "
   fimse
   se exigeChave entao
      se nao temChave entao
         objetivoStr <- "Pegue a chave C                 "
      fimse
   fimse
   se bossBloqueiaSaida entao
      se bossVivo entao
         objetivoStr <- "Derrote o boss para liberar X   "
      fimse
   fimse
   se saidaLiberada entao
      se iniVivos = 0 entao
         objetivoStr <- "Va para a saida X               "
      fimse
   fimse
   se (ammo <= 2) e (ammo > 0) entao
      objetivoStr <- "Municao baixa                   "
   fimse
   se ammo = 0 entao
      objetivoStr <- "Sem municao                     "
   fimse
   se vida <= 40 entao
      objetivoStr <- "Vida baixa                      "
   fimse
   se vida <= 20 entao
      objetivoStr <- "Vida critica                    "
   fimse
fimprocedimento

procedimento mostrarAjuda()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                       A J U D A                                                  |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|  MOVIMENTO                                                                                       |")
   escreval("|     W = andar para frente   S = recuar   A = girar a esquerda   D = girar a direita              |")
   escreval("|                                                                                                  |")
   escreval("|  COMBATE                                                                                         |")
   escreval("|     F = atirar   R = recarregar                                                                  |")
   escreval("|                                                                                                  |")
   escreval("|  TROCA DE ARMA                                                                                   |")
   escreval("|     Z = arma anterior   X = proxima arma                                                         |")
   escreval("|                                                                                                  |")
   escreval("|  ITENS                                                                                           |")
   escreval("|     K = kit de vida   A = municao   W = arma                                                     |")
   escreval("|                                                                                                  |")
   escreval("|  CHAVE                                                                                           |")
   escreval("|     C = chave. Algumas fases exigem chave para liberar a saida.                                  |")
   escreval("|                                                                                                  |")
   escreval("|  SAIDA                                                                                           |")
   escreval("|     X = saida. Pode estar bloqueada ate pegar a chave ou derrotar o boss.                        |")
   escreval("|                                                                                                  |")
   escreval("|  COMANDOS COMPOSTOS                                                                              |")
   escreval("|     Digite ate 8 letras juntas em um ENTER. Exemplos: WWW, AWAWDS, FFR, ZXF, RRF.                |")
   escreval("|                                                                                                  |")
   escreval("|  MODO APRESENTACAO                                                                               |")
   escreval("|     Opcao 2 do menu. Mais vida, mais municao, armas liberadas antes e menos inimigos.            |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para voltar: ")
   leia(teclaEspera)
fimprocedimento

procedimento mostrarCreditos()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                     C R E D I T O S                                              |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|         DoomALG                                                                                  |")
   escreval("|                                                                                                  |")
   escreval("|         Alunos:                                                                                  |")
   escreval("|                                                                                                  |")
   escreval("|         Marcell Alves Resende                                                                    |")
   escreval("|         RA: 5178278                                                                              |")
   escreval("|                                                                                                  |")
   escreval("|         Pedro Andrade Santos                                                                     |")
   escreval("|         RA: 5180749                                                                              |")
   escreval("|                                                                                                  |")
   escreval("|         Davi Augusto Alves de Assis                                                              |")
   escreval("|         RA: 5181548                                                                              |")
   escreval("|                                                                                                  |")
   escreval("|         Disciplina:                                                                              |")
   escreval("|         ALGORITMOS E ESTRUTURAS DE DADOS                                                         |")
   escreval("|                                                                                                  |")
   escreval("|         Professor:                                                                               |")
   escreval("|         MAXWELL GOMES DA SILVA                                                                   |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para voltar: ")
   leia(teclaEspera)
fimprocedimento

procedimento mostrarMenu()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|           DDDDD    OOOOO    OOOOO   M     M    AAAAA   L         GGGGG                           |")
   escreval("|           D    D  O     O  O     O  MM   MM   A     A  L        G                                |")
   escreval("|           D    D  O     O  O     O  M M M M   AAAAAAA  L        G   GG                           |")
   escreval("|           D    D  O     O  O     O  M  M  M   A     A  L        G    G                           |")
   escreval("|           DDDDD    OOOOO    OOOOO   M     M   A     A  LLLLLL    GGGG                            |")
   escreval("|                                                                                                  |")
   escreval("|                                                                                                  |")
   escreval("|                         1 - Jogar                                                                |")
   escreval("|                         2 - Modo apresentacao                                                    |")
   escreval("|                         3 - Ajuda                                                                |")
   escreval("|                         4 - Creditos                                                             |")
   escreval("|                         5 - Sair                                                                 |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Escolha uma opcao e tecle ENTER: ")
   leia(opcao)
fimprocedimento

procedimento telaVitoria()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                    V O C E   V E N C E U                                         |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|   Campanha concluida.                                                                            |")
   escreval("|                                                                                                  |")
   escreva  ("|   PONTOS     : ")
   escreva(pontos)
   escreval("                                                                                  |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para voltar ao menu: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaDerrota()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                    V O C E   P E R D E U                                         |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreva  ("|   FASE ALCANCADA : ")
   escreva(fase)
   escreval("                                                                              |")
   escreva  ("|   PONTOS         : ")
   escreva(pontos)
   escreval("                                                                              |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para voltar ao menu: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaFaseConcluida()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                F A S E   C O N C L U I D A                                       |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreva  ("|   FASE       : ")
   escreva(fase)
   escreva  (" - ")
   escreva(faseNome[fase])
   escreval("                                                       |")
   escreva  ("|   VIDA       : ")
   escreva(vida)
   escreva  ("/")
   escreva(vidaMax)
   escreval("                                                                              |")
   escreva  ("|   PONTOS     : ")
   escreva(pontos)
   escreval("                                                                                  |")
   se fase < 5 entao
      escreva  ("|   PROXIMA    : ")
      escreva(fase + 1)
      escreva  (" - ")
      escreva(faseNome[fase + 1])
      escreval("                                                       |")
   senao
      escreval("|   PROXIMA    : Fim da campanha.                                                                  |")
   fimse
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para continuar: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaIntroBoss()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                         B O S S                                                  |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   se bossTipoFase = 1 entao
      escreval("|   BOSS       : GATEKEEPER                                                                        |")
      escreval("|   OBJETIVO   : Derrote o boss para liberar a saida.                                              |")
      escreval("|   DICA       : Mantenha distancia e use a SHOTGUN.                                               |")
   fimse
   se bossTipoFase = 2 entao
      escreval("|   BOSS       : SENTINEL PRIME                                                                    |")
      escreval("|   OBJETIVO   : Derrote o boss para liberar a saida.                                              |")
      escreval("|   DICA       : Use o RIFLE e recarregue entre tiros.                                             |")
   fimse
   se bossTipoFase = 3 entao
      escreval("|   BOSS       : OVERLORD ASCII                                                                    |")
      escreval("|   OBJETIVO   : Derrote o boss final.                                                             |")
      escreval("|   DICA       : Use o CANNON. Recarregue antes de atacar.                                         |")
   fimse
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para continuar: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaBossDerrotado()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                B O S S   D E R R O T A D O                                       |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   se bossTipoFase = 1 entao
      escreval("|   GATEKEEPER derrotado. Saida liberada.                                                          |")
   fimse
   se bossTipoFase = 2 entao
      escreval("|   SENTINEL PRIME derrotado. Saida liberada.                                                      |")
   fimse
   se bossTipoFase = 3 entao
      escreval("|   OVERLORD ASCII derrotado.                                                                      |")
   fimse
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para continuar: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaVitoriaFinal()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                    V O C E   V E N C E U                                         |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|   Campanha concluida.                                                                            |")
   escreval("|                                                                                                  |")
   escreva  ("|   PONTOS     : ")
   escreva(pontos)
   escreval("                                                                                  |")
   escreval("|                                                                                                  |")
   escreval("|   DoomALG                                                                                        |")
   escreval("|   Marcell Alves Resende - Pedro Andrade Santos - Davi Augusto Alves de Assis                     |")
   escreval("|   ALGORITMOS E ESTRUTURAS DE DADOS - MAXWELL GOMES DA SILVA                                      |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para voltar ao menu: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaTutorial()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                    C O M O   J O G A R                                           |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|   MOVIMENTO        W avanca   S recua   A gira esquerda   D gira direita                         |")
   escreval("|   COMBATE          F atira    R recarrega                                                        |")
   escreval("|   ARMA             Z arma anterior   X proxima arma                                              |")
   escreval("|   AJUDA E MENU     H ajuda    Q volta ao menu                                                    |")
   escreval("|                                                                                                  |")
   escreval("|   ITENS NO MAPA    K kit de vida   A municao   C chave   W arma   X saida                        |")
   escreval("|   INIMIGOS         G GRUNT   B BRUTE   S STALKER   P SPITTER   N SENTINEL   O BOSS               |")
   escreval("|                                                                                                  |")
   escreval("|   COMANDOS COMPOSTOS                                                                             |")
   escreval("|      Digite ate 8 letras juntas em um ENTER. Exemplos: WWW, AWAWDS, FFR, ZXF, RRF.               |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para comecar a Fase 1: ")
   leia(teclaEspera)
fimprocedimento

procedimento telaInicioFase()
inicio
   limpatela
   escreval("+==================================================================================================+")
   escreva  ("|   FASE ")
   escreva(fase)
   escreva  (" - ")
   escreva(faseNome[fase])
   escreval("                                                                     |")
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   se fase = 1 entao
      escreval("|   OBJETIVO   : Encontre a saida X.                                                               |")
      escreval("|   DICA       : Avance com W e atire com F.                                                       |")
   fimse
   se fase = 2 entao
      escreval("|   OBJETIVO   : Pegue a chave C e va para a saida X.                                              |")
      escreval("|   DICA       : Pegue W no mapa para liberar a SHOTGUN.                                           |")
   fimse
   se fase = 3 entao
      escreval("|   OBJETIVO   : Elimine os inimigos e alcance a saida X.                                          |")
      escreval("|   DICA       : Pegue W para liberar o RIFLE.                                                     |")
   fimse
   se fase = 4 entao
      escreval("|   OBJETIVO   : Pegue a chave C e libere a saida X.                                               |")
      escreval("|   DICA       : Pegue W para liberar o CANNON.                                                    |")
   fimse
   se fase = 5 entao
      escreval("|   OBJETIVO   : Derrote o boss final.                                                             |")
      escreval("|   DICA       : Use o CANNON e recarregue antes de avancar.                                       |")
   fimse
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
   escreva("Pressione ENTER para comecar: ")
   leia(teclaEspera)
fimprocedimento

inicio
   inicializarSprites()
   vidaMax <- 120
   armaNome[1] <- "PISTOLA "
   armaNome[2] <- "SHOTGUN "
   armaNome[3] <- "RIFLE   "
   armaNome[4] <- "CANNON  "
   faseNome[1] <- "CORREDOR INICIAL    "
   faseNome[2] <- "ARSENAL ESQUECIDO   "
   faseNome[3] <- "CAMARA DOS PILARES  "
   faseNome[4] <- "LABIRINTO DE ACO    "
   faseNome[5] <- "NUCLEO FINAL        "
   armaDano[1] <- 1
   armaDano[2] <- 2
   armaDano[3] <- 3
   armaDano[4] <- 5
   armaAmmoMax[1] <- 12
   armaAmmoMax[2] <- 7
   armaAmmoMax[3] <- 14
   armaAmmoMax[4] <- 5
   armaAmmo[1] <- 12
   armaAmmo[2] <- 0
   armaAmmo[3] <- 0
   armaAmmo[4] <- 0
   armaDesbloqueada[1] <- verdadeiro
   armaDesbloqueada[2] <- falso
   armaDesbloqueada[3] <- falso
   armaDesbloqueada[4] <- falso
   armaAtual <- 1
   ammoMax <- armaAmmoMax[1]
   pontos <- 0
   turnos <- 0
   kitsColetados <- 0
   ammoColetadas <- 0
   inimigosMortos <- 0
   chavesColetadas <- 0
   armasColetadasTot <- 0
   temChave <- falso
   wPickupArma <- 0
   ultimoItemColetado <- "NENHUM"
   exigeChave <- falso
   saidaLiberada <- verdadeiro
   bossAtivo <- falso
   bossVivo <- falso
   bossTipoFase <- 0
   bossVida <- 0
   bossVidaMax <- 1
   bossDano <- 0
   bossX <- 0
   bossY <- 0
   bossNome <- ""
   bossAtacadoFrame <- 0
   bossIntroMostrada <- falso
   bossBloqueiaSaida <- falso
   bossDerrotadoEsteJogo <- falso
   vitoriaFinalAtiva <- falso
   tutorialMostrado <- falso
   modoDemo <- falso
   ativoMenu <- verdadeiro
   enquanto ativoMenu faca
      mostrarMenu()
      se (opcao = "1") ou (opcao = "2") entao
         modoDemo <- falso
         se opcao = "2" entao
            modoDemo <- verdadeiro
         fimse
         se modoDemo entao
            vidaMax <- 180
            armaAmmoMax[1] <- 16
            armaAmmoMax[2] <- 10
            armaAmmoMax[3] <- 18
            armaAmmoMax[4] <- 8
         senao
            vidaMax <- 120
            armaAmmoMax[1] <- 12
            armaAmmoMax[2] <- 7
            armaAmmoMax[3] <- 14
            armaAmmoMax[4] <- 5
         fimse
         fase <- 1
         pontos <- 0
         turnos <- 0
         kitsColetados <- 0
         ammoColetadas <- 0
         inimigosMortos <- 0
         chavesColetadas <- 0
         armasColetadasTot <- 0
         temChave <- falso
         exigeChave <- falso
         saidaLiberada <- verdadeiro
         armaDesbloqueada[1] <- verdadeiro
         armaDesbloqueada[2] <- falso
         armaDesbloqueada[3] <- falso
         armaDesbloqueada[4] <- falso
         se modoDemo entao
            armaDesbloqueada[2] <- verdadeiro
            armaDesbloqueada[3] <- verdadeiro
         fimse
         armaAmmo[1] <- armaAmmoMax[1]
         se modoDemo entao
            armaAmmo[2] <- armaAmmoMax[2]
            armaAmmo[3] <- armaAmmoMax[3]
         senao
            armaAmmo[2] <- 0
            armaAmmo[3] <- 0
         fimse
         armaAmmo[4] <- 0
         armaAtual <- 1
         ammoMax <- armaAmmoMax[1]
         ammo <- ammoMax
         ultimoItemColetado <- "NENHUM"
         vitoriaFinalAtiva <- falso
         ativoJogo <- verdadeiro
         jogou <- falso
         tutorialMostrado <- falso
         se nao tutorialMostrado entao
            telaTutorial()
            tutorialMostrado <- verdadeiro
         fimse
         enquanto (ativoJogo) e (fase <= 5) faca
            inicializarFase()
            telaInicioFase()
            se bossAtivo entao
               se nao bossIntroMostrada entao
                  telaIntroBoss()
                  bossIntroMostrada <- verdadeiro
                  statusMsg <- "Boss surgiu"
               fimse
            fimse
            faseFim <- falso
            enquanto (nao faseFim) e (vida > 0) e (ativoJogo) faca
               contarInimigos()
               atualizarObjetivo()
               renderizar()
               escreva("Comando: ")
               leia(entradaCmd)
               turnos <- turnos + 1
               totalCmd <- compr(entradaCmd)
               limiteCmd <- 8
               limiteAtingido <- falso
               se totalCmd > limiteCmd entao
                  totalCmd <- limiteCmd
                  limiteAtingido <- verdadeiro
               fimse
               executadosCmd <- 0
               andouQtd <- 0
               disparosQtd <- 0
               trocouArmaQtd <- 0
               se totalCmd <= 0 entao
                  statusMsg <- "Digite um comando"
               fimse
               seqAtiva <- verdadeiro
               indiceCmd <- 1
               enquanto seqAtiva e (indiceCmd <= totalCmd) faca
                  letraCmd <- copia(entradaCmd, indiceCmd, 1)
                  foiAcao <- falso
                  se (letraCmd = "w") ou (letraCmd = "W") entao
                     pxAntes <- px
                     pyAntes <- py
                     tentarAndar(1)
                     estadoArma <- 1
                     foiAcao <- verdadeiro
                     se (px <> pxAntes) ou (py <> pyAntes) entao
                        andouQtd <- andouQtd + 1
                     fimse
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "s") ou (letraCmd = "S") entao
                     pxAntes <- px
                     pyAntes <- py
                     tentarAndar(-1)
                     estadoArma <- 1
                     foiAcao <- verdadeiro
                     se (px <> pxAntes) ou (py <> pyAntes) entao
                        andouQtd <- andouQtd + 1
                     fimse
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "a") ou (letraCmd = "A") entao
                     virarEsq()
                     estadoArma <- 1
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "d") ou (letraCmd = "D") entao
                     virarDir()
                     estadoArma <- 1
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "f") ou (letraCmd = "F") entao
                     atirar()
                     foiAcao <- verdadeiro
                     disparosQtd <- disparosQtd + 1
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "r") ou (letraCmd = "R") entao
                     recarregar()
                     foiAcao <- verdadeiro
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "z") ou (letraCmd = "Z") entao
                     armaAnterior()
                     estadoArma <- 1
                     trocouArmaQtd <- trocouArmaQtd + 1
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "x") ou (letraCmd = "X") entao
                     proximaArma()
                     estadoArma <- 1
                     trocouArmaQtd <- trocouArmaQtd + 1
                     executadosCmd <- executadosCmd + 1
                  fimse
                  se (letraCmd = "h") ou (letraCmd = "H") entao
                     mostrarAjuda()
                     estadoArma <- 1
                     executadosCmd <- executadosCmd + 1
                     seqAtiva <- falso
                  fimse
                  se (letraCmd = "q") ou (letraCmd = "Q") entao
                     ativoJogo <- falso
                     statusMsg <- "Voltando ao menu"
                     seqAtiva <- falso
                  fimse
                  se foiAcao entao
                     inimigosMovem()
                     inimigosAtacam()
                     spittersAtacam()
                     bossMove()
                     bossAtaca()
                  fimse
                  se vida <= 0 entao
                     seqAtiva <- falso
                  fimse
                  se faseFim entao
                     seqAtiva <- falso
                  fimse
                  indiceCmd <- indiceCmd + 1
               fimenquanto
               se totalCmd > 1 entao
                  resumoCmd <- "[" + entradaCmd + "]"
                  se andouQtd > 0 entao
                     resumoCmd <- resumoCmd + " AND:" + digito[andouQtd]
                  fimse
                  se disparosQtd > 0 entao
                     resumoCmd <- resumoCmd + " TIR:" + digito[disparosQtd]
                  fimse
                  se trocouArmaQtd > 0 entao
                     resumoCmd <- resumoCmd + " ARM:" + digito[trocouArmaQtd]
                  fimse
                  se limiteAtingido entao
                     resumoCmd <- resumoCmd + " LIMITE"
                  fimse
                  statusMsg <- resumoCmd + " " + statusMsg
               fimse
            fimenquanto
            se vida <= 0 entao
               telaDerrota()
               ativoJogo <- falso
            senao
               se faseFim entao
                  se bossAtivo entao
                     se nao bossVivo entao
                        telaBossDerrotado()
                     fimse
                  fimse
                  se fase < 5 entao
                     telaFaseConcluida()
                     fase <- fase + 1
                  senao
                     se bossAtivo entao
                        se nao bossVivo entao
                           vitoriaFinalAtiva <- verdadeiro
                        fimse
                     fimse
                     se vitoriaFinalAtiva entao
                        telaVitoriaFinal()
                     senao
                        telaVitoria()
                     fimse
                     ativoJogo <- falso
                  fimse
               fimse
            fimse
         fimenquanto
      fimse
      se opcao = "3" entao
         mostrarAjuda()
      fimse
      se opcao = "4" entao
         mostrarCreditos()
      fimse
      se opcao = "5" entao
         ativoMenu <- falso
      fimse
   fimenquanto
   limpatela
   escreval("+==================================================================================================+")
   escreval("|                                                                                                  |")
   escreval("|                            Obrigado por jogar DoomALG                                            |")
   escreval("|                                                                                                  |")
   escreval("+==================================================================================================+")
fimalgoritmo

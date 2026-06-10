// Mapa 20x15 (X horizontal, Y vertical)
let mapX = 20;
let mapY = 15;
const CELL_W = 30;
const CELL_H = 30;
const MOVE_SPEED = 8;
const COOLDOWN_DANO = 1000;
const armasArt = {
  1: "./img/doom-weapons/pistol.png",
  2: "./img/doom-weapons/shotgun.png",
  3: "./img/doom-weapons/chaingun.png",
  4: "./img/doom-weapons/RPG-7.png",
};
const arquivos = {
  marine: "./img/doom-avatar/avatar.png",
  demon: "./img/doom-enemys/enemy.png",
};
let mapa = Array(mapX + 1)
  .fill()
  .map(() => Array(mapY + 1).fill(0));
let animationId = null;
let faseAtual = 1;
let itensMapa = [];
let playerPixelX = 0,
  playerPixelY = 0;
let isMoving = false;
let moveTargetX = 0,
  moveTargetY = 0;
let moveStepX = 0,
  moveStepY = 0;
let moveRemainingSteps = 0;
let jogadorX = 10,
  jogadorY = 8;
let vida = 100;
let pontuacao = 0;
let inimigos = [];
let contadorInimigos = 6;
let inimigosMortosTotal = 0;
let inimigosMortosFase = 0;
let jogoAtivo = false;
let tempoInicio = 0;
let tempoFinal = 0;
let tempoTotal = 0;
let intervaloRelogio = null;
let armaEquipada = 1;
let ultimoTiro = 0;
let direcaoAtual = "w";
let miraVetor = { x: 0, y: -1 };
let esperandoInput = false;
let intervaloMovimento = null;
let flashAnimacao = null;
let flashX = 0,
  flashY = 0;
let flashFrames = 0;
let flashMaxFrames = 4;
let flashAngulo = 0;
const imagens = {};
let imagensCarregadas = 0;
const totalImagens = Object.keys(arquivos).length;
let etapaAtual = "menu";
let btnActionIndex = 0;
let tutorialCardIndex = 1;
let canvaW;
let canvaH;
let projetilAtivo = null;
let explosaoAtiva = null;
let offscreenCanvas, offscreenCtx;
let municaoCartucho = 0;
let kitMedico = 0;
// Elementos DOM
const canvas = document.getElementById("doomCanvas");
const doomFacePlayer = document.getElementById("doomFacePlayer");
const ctx = canvas.getContext("2d");
const infoBar = document.getElementById("infoBar");
const vidaSpan = document.getElementById("vidaVal");
const barraVida = document.getElementById("barraVida");
const municaoContainer = document.getElementById("municaoContainer");
const gunContainer = document.getElementById("gunContainer");
const gunContent = document.getElementById("gunContent");
const inimigosSpan = document.getElementById("inimigosRest");
const gameoverScreen = document.getElementById("gameoverScreen");
const actionButton = document.getElementById("actionButton");
const quitButton = document.getElementById("quitButton");
const introCharacterContainer = document.getElementById(
  "introCharacterContainer",
);
const menuPause = document.getElementById("menuPause");
const resumeButton = document.getElementById("resumeButton");
const restartButton = document.getElementById("restartButton");
const mainMenuButton = document.getElementById("mainMenuButton");
const scoreValue = document.getElementById("score-value");
const alvosValue = document.getElementById("alvos-value");
const timeValue = document.getElementById("time-value");
const tutorialContainer = document.getElementById("tutorialContainer");
const tutorialCard = document.querySelectorAll(".tutorial-card");
const btnBack = document.getElementById("btnActionBack");
const btnProceed = document.getElementById("btnActionProceed");
const logArea = document.getElementById("logArea");
const weaponArtImg = document.getElementById("weaponArtPanel");
const bar = document.getElementById("ammoBarContainer");
const label = document.getElementById("ammoLabel");

const menuActions = document.getElementById("menuActions");
const arrowActions = document.getElementById("arrowActions");
const btnActions = menuActions.querySelectorAll("button");
const btnStart = menuActions.querySelector("button#start");
const btnTutorial = menuActions.querySelector("button#tutorial");
const btnCreditos = menuActions.querySelector("button#creditos");
const gameContainer = document.getElementById("gameContainer");
const menuInicial = document.getElementById("menuInicial");
const doomTitle = document.getElementById("doomTitle");
canvaW = canvas.width;
canvaH = canvas.height;

const fases = {
  1: {
    nome: "Entrada do Inferno",
    jogadorInicio: { x: 10, y: 8 },
    inimigos: [
      { x: 3, y: 3, hp: 300 },
      { x: 17, y: 3, hp: 300 },
      { x: 3, y: 12, hp: 300 },
      { x: 17, y: 12, hp: 300 },
      { x: 10, y: 3, hp: 300 },
      { x: 10, y: 13, hp: 300 },
    ],
    paredes: [
      { x: 5, y: 5 },
      { x: 5, y: 6 },
      { x: 15, y: 10 },
      { x: 15, y: 11 },
      { x: 8, y: 7 },
      { x: 12, y: 7 },
    ],
    itens: [
      { x: 4, y: 7, tipo: "municao" },
      { x: 16, y: 7, tipo: "municao" },
      { x: 7, y: 4, tipo: "municao" },
      { x: 13, y: 12, tipo: "municao" },

      { x: 2, y: 8, tipo: "vida" },
      { x: 18, y: 8, tipo: "vida" },
    ],
    saida: { x: 20, y: 8 },
  },

  2: {
    nome: "Corredores Infectados",
    jogadorInicio: { x: 2, y: 8 },
    inimigos: [
      { x: 5, y: 4, hp: 350 },
      { x: 8, y: 3, hp: 350 },
      { x: 12, y: 5, hp: 350 },
      { x: 15, y: 8, hp: 350 },
      { x: 10, y: 12, hp: 350 },
      { x: 6, y: 13, hp: 350 },
    ],
    paredes: [
      { x: 4, y: 2 },
      { x: 5, y: 2 },
      { x: 6, y: 2 },
      { x: 7, y: 2 },
      { x: 9, y: 2 },
      { x: 10, y: 2 },
      { x: 11, y: 2 },
      { x: 12, y: 2 },
      { x: 14, y: 2 },
      { x: 15, y: 2 },
      { x: 16, y: 2 },
      { x: 4, y: 4 },
      { x: 4, y: 5 },
      { x: 4, y: 6 },
      { x: 8, y: 4 },
      { x: 8, y: 5 },
      { x: 8, y: 6 },
      { x: 13, y: 4 },
      { x: 13, y: 5 },
      { x: 13, y: 6 },
      { x: 5, y: 10 },
      { x: 6, y: 10 },
      { x: 7, y: 10 },
      { x: 10, y: 10 },
      { x: 11, y: 10 },
      { x: 12, y: 10 },
      { x: 15, y: 10 },
      { x: 16, y: 10 },
      { x: 6, y: 7 },
      { x: 14, y: 7 },
      { x: 9, y: 13 },
      { x: 12, y: 13 },
    ],
    itens: [
      { x: 3, y: 9, tipo: "municao" },
      { x: 17, y: 5, tipo: "municao" },
      { x: 5, y: 11, tipo: "municao" },
      { x: 15, y: 12, tipo: "municao" },

      { x: 10, y: 7, tipo: "vida" },
      { x: 18, y: 12, tipo: "vida" },
    ],
    saida: { x: 20, y: 8 },
  },
  3: {
    nome: "Sala do Boss",
    jogadorInicio: { x: 10, y: 14 },
    inimigos: [
      { x: 10, y: 8, hp: 800 },
      { x: 5, y: 5, hp: 300 },
      { x: 15, y: 5, hp: 300 },
      { x: 5, y: 11, hp: 300 },
      { x: 15, y: 11, hp: 300 },
    ],
    paredes: [
      { x: 3, y: 3 },
      { x: 4, y: 3 },
      { x: 5, y: 3 },
      { x: 6, y: 3 },
      { x: 7, y: 3 },
      { x: 8, y: 3 },
      { x: 9, y: 3 },
      { x: 11, y: 3 },
      { x: 12, y: 3 },
      { x: 13, y: 3 },
      { x: 14, y: 3 },
      { x: 15, y: 3 },
      { x: 16, y: 3 },
      { x: 17, y: 3 },
      { x: 3, y: 4 },
      { x: 17, y: 4 },
      { x: 3, y: 5 },
      { x: 17, y: 5 },
      { x: 3, y: 6 },
      { x: 17, y: 6 },
      { x: 3, y: 10 },
      { x: 17, y: 10 },
      { x: 3, y: 11 },
      { x: 17, y: 11 },
      { x: 3, y: 12 },
      { x: 17, y: 12 },
      { x: 3, y: 13 },
      { x: 4, y: 13 },
      { x: 5, y: 13 },
      { x: 6, y: 13 },
      { x: 7, y: 13 },
      { x: 8, y: 13 },
      { x: 9, y: 13 },
      { x: 11, y: 13 },
      { x: 12, y: 13 },
      { x: 13, y: 13 },
      { x: 14, y: 13 },
      { x: 15, y: 13 },
      { x: 16, y: 13 },
      { x: 17, y: 13 },
      { x: 6, y: 7 },
      { x: 6, y: 8 },
      { x: 14, y: 7 },
      { x: 14, y: 8 },
      { x: 8, y: 6 },
      { x: 12, y: 6 },
    ],
    itens: [
      { x: 4, y: 9, tipo: "municao" },
      { x: 16, y: 9, tipo: "municao" },
      { x: 9, y: 4, tipo: "municao" },
      { x: 11, y: 4, tipo: "municao" },
      { x: 7, y: 11, tipo: "municao" },
      { x: 13, y: 11, tipo: "municao" },

      { x: 10, y: 5, tipo: "vida" },
      { x: 10, y: 12, tipo: "vida" },
    ],
    saida: { x: 20, y: 8 },
  },
};

const ITENS_CONFIG = {
  municao: {
    nome: "Munição",
    efeito: () => municaoCartucho++,
  },
  vida: {
    nome: "Vida",
    efeito: () => kitMedico++,
  },
};

const ARMAS = {
  1: {
    nome: "Pistola",
    municaoMax: 200,
    municaoAtual: 50,
    tipo: "normal",
    penetracao: false,
    area: 0,
    velocidadeTiro: 800,
    quantidadeProjeteis: 1,
    espalhamento: 0,
    corFlash: "#ffaa00",
    animacao: "flash",
    danoPorProjetil: 10,
  },
  2: {
    nome: "Escopeta",
    municaoMax: 50,
    municaoAtual: 8,
    tipo: "normal",
    penetracao: false,
    area: 0,
    velocidadeTiro: 1000,
    quantidadeProjeteis: 7,
    espalhamento: 15,
    corFlash: "#ff6600",
    animacao: "flash",
    danoPorProjetil: 15,
  },
  3: {
    nome: "Metralhadora",
    municaoMax: 200,
    municaoAtual: 50,
    tipo: "penetrante",
    penetracao: true,
    area: 0,
    velocidadeTiro: 150,
    quantidadeProjeteis: 1,
    espalhamento: 5,
    corFlash: "#00aaff",
    animacao: "flash",
    danoPorProjetil: 10,
  },
  4: {
    nome: "RPG-7",
    municaoMax: 10,
    municaoAtual: 3,
    tipo: "area",
    penetracao: false,
    area: 2,
    velocidadeTiro: 1200,
    quantidadeProjeteis: 1,
    espalhamento: 0,
    corFlash: "#ff4400",
    animacao: "foguete",
    danoPorProjetil: 300,
  },
};

function btnActionRender() {
  if (btnActionIndex < 0) btnActionIndex = 2;
  if (btnActionIndex > 2) btnActionIndex = 0;

  // Busca os novos slots alinhados por linha
  let arrowSlots = menuActions.querySelectorAll(".arrow-slot");

  arrowSlots.forEach((slot) => {
    slot.innerHTML = "";
  });

  // Procure essa linha na sua função btnActionRender() e altere para:
  let arrowIcon = document.createElement("i");
  arrowIcon.classList.add("fa-solid", "fa-angles-right"); // Usa seta dupla pontuda estilo Doom

  btnActions.forEach((b, index) => {
    if (btnActionIndex == index) {
      b.classList.add("btn-active");
      if (arrowSlots[index]) arrowSlots[index].appendChild(arrowIcon);
    } else {
      b.classList.remove("btn-active");
    }
  });
}
btnActionRender();

function renderizarArmas() {
  // Criar o container principal
  const tutorialCard = document.createElement("div");
  tutorialCard.className = "tutorial-card armas rows-expanded";

  // Adicionar ID
  const tutorialId = document.createElement("div");
  tutorialId.className = "tutorial-id";
  tutorialId.textContent = "3";
  tutorialCard.appendChild(tutorialId);

  // Adicionar título
  const tutorialTitle = document.createElement("div");
  tutorialTitle.className = "tutorial-title";
  const titleH2 = document.createElement("h2");
  titleH2.textContent = "O Arsenal e Seleção";
  tutorialTitle.appendChild(titleH2);
  tutorialCard.appendChild(tutorialTitle);

  // Adicionar conteúdo
  const tutorialContent = document.createElement("div");
  tutorialContent.className = "tutorial-content guns-layout";

  // Criar lista de armas
  const gunList = document.createElement("ul");
  gunList.className = "gun-list";

  // Iterar sobre as armas no objeto ARMAS
  for (const [key, arma] of Object.entries(ARMAS)) {
    const listItem = document.createElement("li");

    // Chave da arma
    const weaponKey = document.createElement("span");
    weaponKey.className = "weapon-key";
    weaponKey.textContent = key;
    listItem.appendChild(weaponKey);

    // Detalhes da arma
    const weaponDetails = document.createElement("div");
    weaponDetails.className = "weapon-details";

    // Nome da arma
    const weaponName = document.createElement("span");
    weaponName.className = "weapon-name";
    weaponName.textContent = arma.nome;
    weaponDetails.appendChild(weaponName);

    // Estatísticas da arma
    const weaponStats = document.createElement("span");
    weaponStats.className = "weapon-stats";

    // Construir string de estatísticas
    let statsText = `(${arma.municaoAtual}/${arma.municaoMax} balas, Dano: ${calcularDanoArma()}`;

    if (arma.penetracao) {
      statsText += ", Penetrante";
    }

    if (arma.area > 0) {
      statsText += `, Área: ${arma.area}`;
    }

    if (arma.quantidadeProjeteis > 1) {
      statsText += `, ${arma.quantidadeProjeteis} projéteis`;
    }

    statsText += ")";

    weaponStats.textContent = statsText;
    weaponDetails.appendChild(weaponStats);

    listItem.appendChild(weaponDetails);
    gunList.appendChild(listItem);
  }

  tutorialContent.appendChild(gunList);

  // Adicionar footer
  const contentFooter = document.createElement("div");
  contentFooter.className = "content-footer";
  const footerP = document.createElement("p");
  footerP.textContent = `ESCOLHA A ARMA (1-${Object.values(ARMAS).length}) NO TECLADO.`;
  contentFooter.appendChild(footerP);
  tutorialContent.appendChild(contentFooter);

  tutorialCard.appendChild(tutorialContent);

  return tutorialCard;
}

function addLog(msg) {
  const p = document.createElement("div");
  p.innerHTML = "> " + msg;
  logArea.appendChild(p);
  while (logArea.children.length > 6) logArea.removeChild(logArea.firstChild);
  logArea.scrollTop = logArea.scrollHeight;
}

function atualizarSelecaoArma() {
  if (jogoAtivo) {
    const guns = gunContent.querySelectorAll(".gun-selected");
    guns.forEach((g, index) => {
      if (armaEquipada == index + 1) {
        g.classList.add("gun-selected-active");
      } else {
        g.classList.remove("gun-selected-active");
      }
    });
  } else {
    Object.entries(ARMAS).forEach(([id]) => {
      const gunItem = document.createElement("div");
      gunItem.classList.add("gun-selected", "stat-text");
      gunItem.innerText = id;
      gunContent.appendChild(gunItem);
      console.log(gunItem);
    });
    const armasLength = Object.keys(ARMAS).length;
    gunContainer.querySelector("p.gun-description").innerText =
      `Selecione apertando as teclas de 1 a ${armasLength}`;
  }
}
atualizarSelecaoArma();

function exibirArteArma(armaNum) {
  if (armasArt[armaNum]) {
    weaponArtImg.src = armasArt[armaNum];
    weaponArtImg.style.display = "block";
    if (armaNum === 1) {
      weaponArtImg.style.objectFit = "contain";
    } else {
      weaponArtImg.style.objectFit = "cover";
    }
  } else {
    weaponArtImg.style.display = "none";
  }
}

function atualizarInterfaceArmas() {
  const arma = ARMAS[armaEquipada];
  const textoMunicao =
    arma.municaoMax === -1 ? "∞" : arma.municaoAtual + "/" + arma.municaoMax;
  if (arma.municaoMax !== -1) {
    let percent = arma.municaoAtual / arma.municaoMax;
  }
  atualizarBarraMunicaoHTML();
}

function atualizarUI() {
  if (vida <= 0) {
    vidaSpan.innerText = `0%`;
  } else {
    vidaSpan.innerText = `${vida}%`;
  }
  inimigosSpan.innerText = contadorInimigos;
  barraVida.style.width = vida + "%";
  if (vida <= 30 && vida > 0) {
    vidaSpan.style.animation = "pulseRed 0.5s ease-in-out infinite";
  } else {
    vidaSpan.style.animation = "";
  }
}

function aplicarEfeitoDano() {
  const damageOverlay = document.getElementById("damageOverlay");
  if (damageOverlay) {
    damageOverlay.classList.add("active");
    setTimeout(() => damageOverlay.classList.remove("active"), 300);
  }
  document.body.classList.add("shake-active");
  setTimeout(() => document.body.classList.remove("shake-active"), 300);
  const container = document.querySelector(".game-container");
  if (container) {
    for (let i = 0; i < 10; i++) {
      const p = document.createElement("div");
      p.style.position = "absolute";
      p.style.width = Math.random() * 8 + 4 + "px";
      p.style.height = Math.random() * 8 + 4 + "px";
      p.style.backgroundColor = "rgba(139,0,0,0.7)";
      p.style.borderRadius = "50%";
      p.style.left = Math.random() * 100 + "%";
      p.style.top = Math.random() * 100 + "%";
      p.style.pointerEvents = "none";
      p.style.zIndex = "1001";
      p.style.animation = "floatBlood 0.5s ease-out forwards";
      container.appendChild(p);
      setTimeout(() => p.remove(), 500);
    }
  }
}
let ultimoDanoInimigo = 0;
function aplicarDanoInimigo(dano = 20) {
  const agora = Date.now();
  if (agora - ultimoDanoInimigo >= COOLDOWN_DANO) {
    vida -= dano;
    ultimoDanoInimigo = agora;
    aplicarEfeitoDano();
    atualizarSangueNoRosto();
    atualizarUI();

    if (vida <= 0) {
      finalizarJogo(false);
    }
    return true;
  }
  return false;
}

function atualizarBarraMunicaoHTML() {
  const arma = ARMAS[armaEquipada];
  const fill = document.getElementById("ammoBarFill");
  if (!label || !fill) return;

  bar.style.display = "flex";
  console.log(arma.municaoAtual);
  if (arma.municaoMax === -1) {
    label.innerText = arma.nome + ": INFINITA";
    fill.style.width = "100%";
  } else {
    label.innerText =
      arma.nome + ": " + arma.municaoAtual + "/" + arma.municaoMax;
    const percent = arma.municaoAtual / arma.municaoMax;
    fill.style.width = percent * 100 + "%";
  }
}

function formatarTempo(segundosTotais) {
  const horas = Math.floor(segundosTotais / 3600);
  const minutos = Math.floor((segundosTotais % 3600) / 60);
  const segundos = segundosTotais % 60;

  if (horas > 0) {
    return `${horas.toString().padStart(2, "0")}:${minutos.toString().padStart(2, "0")}:${segundos.toString().padStart(2, "0")}`;
  }
  return `${minutos.toString().padStart(2, "0")}:${segundos.toString().padStart(2, "0")}`;
}

function iniciarCronometro() {
  tempoInicio = Date.now();

  if (intervaloRelogio) {
    clearInterval(intervaloRelogio);
  }
}

function pararCronometro() {
  if (intervaloRelogio) {
    clearInterval(intervaloRelogio);
    intervaloRelogio = null;
  }

  tempoFinal = Date.now();
  tempoTotal = Math.floor((tempoFinal - tempoInicio) / 1000);
}

function resetarCronometro() {
  tempoInicio = 0;
  tempoFinal = 0;
  tempoTotal = 0;
  if (intervaloRelogio) {
    clearInterval(intervaloRelogio);
    intervaloRelogio = null;
  }
}

function Pontuacao() {
  const pontosPorInimigo = inimigosMortosFase * 100;
  const tempoEmSegundos = tempoTotal;
  pontuacao = Math.floor(pontosPorInimigo / tempoEmSegundos);
}

function atualizarSangueNoRosto() {
  const faceElement = doomFacePlayer.querySelector("img");

  if (vida < 30) {
    faceElement.src = "./img/doom-avatar/face-player(3).jpg";
  } else if (vida < 60) {
    faceElement.src = "./img/doom-avatar/face-player(2).jpg";
  } else if (vida < 90) {
    faceElement.src = "./img/doom-avatar/face-player(1).jpg";
  }
}

function municao(armaIndex, atualizar = false) {
  const municaoList = municaoContainer.querySelector("ul");
  if (!atualizar) {
    municaoList.innerHTML = "";
    Object.entries(ARMAS).forEach(([id, arma]) => {
      const municaoLi = document.createElement("li");
      municaoLi.classList.add("municao-item");
      const municaoSpan = document.createElement("span");
      municaoLi.innerText = arma.nome;
      municaoLi.setAttribute("arma-id", id);
      municaoSpan.innerText = `${arma.municaoAtual}/${arma.municaoMax}`;
      municaoLi.appendChild(municaoSpan);
      municaoList.appendChild(municaoLi);
    });
  } else {
    const municaoItems = municaoList.querySelectorAll("li");
    if (armaIndex >= 1 && armaIndex <= municaoItems.length) {
      const municaoValue = municaoItems[armaIndex - 1].querySelector("span");
      const arma = ARMAS[armaIndex];

      if (municaoValue && arma) {
        municaoValue.innerText = `${arma.municaoAtual}/${arma.municaoMax}`;
      }
    }
  }
}

function moverJogador(dx, dy) {
  if (!jogoAtivo || isMoving) return false;

  let novaCelulaX = jogadorX + dx;
  let novaCelulaY = jogadorY + dy;

  if (
    novaCelulaX < 1 ||
    novaCelulaX > mapX ||
    novaCelulaY < 1 ||
    novaCelulaY > mapY
  ) {
    return false;
  }

  let tileDestino = mapa[novaCelulaX][novaCelulaY];

  // impede jogador avançar
  if (tileDestino === 5 || tileDestino === 1 || tileDestino === 3) {
    return false;
  }

  // Inicia movimento suave
  isMoving = true;
  moveTargetX = novaCelulaX;
  moveTargetY = novaCelulaY;

  // Limpa a posição atual (se não for saída)
  if (mapa[jogadorX][jogadorY] !== 5) {
    mapa[jogadorX][jogadorY] = 0;
  }

  let startPixelX = playerPixelX;
  let startPixelY = playerPixelY;
  let endPixelX = (novaCelulaX - 1) * CELL_W;
  let endPixelY = (novaCelulaY - 1) * CELL_H;

  let distX = endPixelX - startPixelX;
  let distY = endPixelY - startPixelY;
  let distance = Math.hypot(distX, distY);
  let steps = Math.ceil(distance / MOVE_SPEED);

  moveStepX = distX / steps;
  moveStepY = distY / steps;
  moveRemainingSteps = steps;

  return true;
}

function updateMovement() {
  if (!isMoving) return;

  playerPixelX += moveStepX;
  playerPixelY += moveStepY;
  moveRemainingSteps--;

  if (moveRemainingSteps <= 0) {
    // Guarda a posição antiga para verificar se era saída
    let antigaPosX = jogadorX;
    let antigaPosY = jogadorY;

    playerPixelX = (moveTargetX - 1) * CELL_W;
    playerPixelY = (moveTargetY - 1) * CELL_H;

    // Atualiza as coordenadas lógicas
    jogadorX = moveTargetX;
    jogadorY = moveTargetY;

    // Só coloca o jogador no mapa se não for saída
    if (mapa[jogadorX][jogadorY] !== 5) {
      mapa[jogadorX][jogadorY] = 2;
    }

    // Limpa a posição antiga (se não era saída)
    if (mapa[antigaPosX][antigaPosY] !== 5) {
      mapa[antigaPosX][antigaPosY] = 0;
    }

    // Verifica se pegou item
    verificarColetaItem(jogadorX, jogadorY);

    // Verifica se está na saída
    verificarSaida(jogadorX, jogadorY);

    isMoving = false;
  }
}
function verificarColetaItem(x, y) {
  for (let i = 0; i < itensMapa.length; i++) {
    let item = itensMapa[i];
    if (!item.coletado && item.x === x && item.y === y) {
      item.coletado = true;

      // Aplica o efeito do item
      const config = ITENS_CONFIG[item.tipo];
      if (config && config.efeito) {
        config.efeito();
      }

      // Remove do mapa visual
      if (mapa[x][y] === 4) {
        mapa[x][y] = 0;
      }

      addLog(`Você pegou ${config.nome}!`);
      break;
    }
  }
}

function atirar() {
  if (!jogoAtivo) {
    console.log("Jogo não está ativo");
    return false;
  }

  const agora = Date.now();
  const arma = ARMAS[armaEquipada];

  // Verifica cooldown
  if (agora - ultimoTiro < arma.velocidadeTiro) {
    addLog(
      "Aguarde " +
        ((arma.velocidadeTiro - (agora - ultimoTiro)) / 1000).toFixed(1) +
        "s",
    );
    return false;
  }

  // Verifica munição
  if (arma.municaoAtual <= 0) {
    addLog(arma.nome + " sem municao! Troque de arma (1-3).");
    return false;
  }
  arma.municaoAtual -= arma.quantidadeProjeteis;
  if (arma.municaoAtual <= 0) arma.municaoAtual = 0;
  ultimoTiro = agora;

  // Calcula direção
  let dirX = miraVetor.x;
  let dirY = miraVetor.y;

  if (dirX === 0 && dirY === 0) {
    dirX = 0;
    dirY = -1;
  }

  addLog(`Atirando com ${arma.nome}`);

  // Animação de flash (para todas as armas)

  // Executa o tiro após animação
  setTimeout(() => {
    executarTiro(dirX, dirY, arma);
  }, 50);

  atualizarInterfaceArmas();
  municao(armaEquipada, true);
  return true;
}

function executarTiro(dirX, dirY, arma) {
  const tipoArma = arma.tipo || "normal";

  switch (tipoArma) {
    case "normal":
      tiroNormal(dirX, dirY, arma);
      animarFlashTiro(dirX, dirY, arma);

      break;
    case "penetrante":
      tiroPenetrante(dirX, dirY, arma);
      animarFlashTiro(dirX, dirY, arma);

      break;
    case "area":
      tiroArea(dirX, dirY, arma);
      break;
    default:
      tiroNormal(dirX, dirY, arma);
      animarFlashTiro(dirX, dirY, arma);
  }
}

// Tiro normal (Pistol, Shotgun)
function tiroNormal(dirX, dirY, arma) {
  let x = jogadorX,
    y = jogadorY;
  let posX = x,
    posY = y;
  let step = 0.3;
  let acertou = false;
  let danoFinal = 0;
  let danoBase = calcularDanoArma();

  while (true) {
    posX += dirX * step;
    posY += dirY * step;
    let cellX = Math.round(posX);
    let cellY = Math.round(posY);

    if (cellX < 1 || cellX > mapX || cellY < 1 || cellY > mapY) break;
    if (mapa[cellX][cellY] === 1) break;

    if (mapa[cellX][cellY] === 3) {
      const inimigo = inimigos.find(
        (inv) => inv.vivo && inv.x === cellX && inv.y === cellY,
      );

      if (inimigo) {
        if (arma.quantidadeProjeteis > 1) {
          let projeteisAcertaram = 0;
          let danoPorProjetil = danoBase / arma.quantidadeProjeteis;
          for (let i = 0; i < arma.quantidadeProjeteis; i++) {
            if (Math.random() < 0.7) projeteisAcertaram++;
          }
          danoFinal = Math.floor(danoPorProjetil * projeteisAcertaram);
          addLog(
            `${arma.nome} acertou ${projeteisAcertaram}/${arma.quantidadeProjeteis} projéteis!`,
          );
        } else {
          danoFinal = danoBase;
        }

        addLog(`${arma.nome} causou ${danoFinal} de dano!`);
        inimigo.hp -= danoFinal;

        if (inimigo.hp <= 0) {
          inimigo.vivo = false;
          contadorInimigos--;
          inimigosMortosFase++;
          mapa[cellX][cellY] = 0;

          addLog(`Monstro morto! ${contadorInimigos} restantes`);
          atualizarUI();
          acertou = true;
        } else {
          addLog(`Inimigo tem ${inimigo.hp}/${inimigo.hpMaximo} HP restante`);
        }
      }
      break;
    }

    if (Math.hypot(posX - x, posY - y) > Math.max(mapX, mapY) * 2) break;
  }

  verificarFimJogo();
}
// Tiro penetrante (Chaingun)
function tiroPenetrante(dirX, dirY, arma) {
  let x = jogadorX,
    y = jogadorY;
  let posX = x,
    posY = y;
  let step = 0.3;
  let mortos = 0;
  let danoBase = calcularDanoArma();

  while (true) {
    posX += dirX * step;
    posY += dirY * step;
    let cellX = Math.round(posX);
    let cellY = Math.round(posY);

    if (cellX < 1 || cellX > mapX || cellY < 1 || cellY > mapY) break;
    if (mapa[cellX][cellY] === 1) break;

    if (mapa[cellX][cellY] === 3) {
      const inimigo = inimigos.find(
        (inv) => inv.vivo && inv.x === cellX && inv.y === cellY,
      );

      if (inimigo) {
        inimigo.hp -= danoBase;
        addLog(`${arma.nome} causou ${danoBase} de dano penetrante!`);

        if (inimigo.hp <= 0) {
          inimigo.vivo = false;
          contadorInimigos--;
          inimigosMortosFase++;
          mortos++;
          mapa[cellX][cellY] = 0;
          addLog(`Monstro morto!`);
        } else {
          addLog(`Inimigo tem ${inimigo.hp}/${inimigo.hpMaximo} HP restante`);
        }
      }
    }
    if (Math.hypot(posX - x, posY - y) > Math.max(mapX, mapY) * 2) break;
  }

  if (mortos > 0) addLog(`Tiro penetrante matou ${mortos} inimigo(s)!`);
  atualizarUI();
  verificarFimJogo();
}

function tiroArea(dirX, dirY, arma) {
  let x = jogadorX,
    y = jogadorY;
  let posX = x,
    posY = y;
  let step = 0.3;
  let tiroX = x,
    tiroY = y;
  let maxDistancia = Math.max(mapX, mapY) * 2;

  // Encontra o ponto de impacto
  while (true) {
    posX += dirX * step;
    posY += dirY * step;
    let cellX = Math.round(posX);
    let cellY = Math.round(posY);

    if (cellX < 1 || cellX > mapX || cellY < 1 || cellY > mapY) break;
    if (mapa[cellX][cellY] === 1 || mapa[cellX][cellY] === 3) {
      tiroX = cellX;
      tiroY = cellY;
      break;
    }
    if (Math.hypot(posX - x, posY - y) > maxDistancia) break;
  }

  // Só inicia a animação do foguete - NÃO aplica dano aqui
  animarProjetilArea(dirX, dirY, tiroX, tiroY, arma);
}

function animarProjetilArea(dirX, dirY, alvoX, alvoY, arma) {
  console.log("projetil indo para", alvoX, alvoY);
  let startX = (jogadorX - 1) * CELL_W + CELL_W / 2;
  let startY = (jogadorY - 1) * CELL_H + CELL_H / 2;
  let endX = (alvoX - 1) * CELL_W + CELL_W / 2;
  let endY = (alvoY - 1) * CELL_H + CELL_H / 2;

  let projetilX = startX,
    projetilY = startY;
  let dx = endX - startX,
    dy = endY - startY;

  // 1. CALCULA A DISTÂNCIA REAL EM PIXELS (Teorema de Pitágoras)
  let distanciaPixels = Math.sqrt(dx * dx + dy * dy);

  // 2. DEFINE UMA VELOCIDADE FIXA (Quantos pixels o projétil anda a cada 35ms)
  // Aumente esse número para o míssil ir mais rápido, diminua para ir mais devagar
  let velocidadeConstante = 25;

  // 3. CALCULA OS PASSOS DINAMICAMENTE
  // Se estiver longe, terá mais passos (vai demorar mais). Se perto, menos passos.
  let passos = Math.max(1, Math.ceil(distanciaPixels / velocidadeConstante));

  let stepX = dx / passos,
    stepY = dy / passos;
  let passoAtual = 0;
  let rastro = [];

  const anim = setInterval(() => {
    if (passoAtual >= passos) {
      clearInterval(anim);
      projetilAtivo = null;

      criarExplosaoRealistica(alvoX, alvoY);

      let mortos = 0;
      for (let i = 0; i < inimigos.length; i++) {
        const inimigo = inimigos[i];
        if (!inimigo.vivo) continue;

        let dist = Math.abs(inimigo.x - alvoX) + Math.abs(inimigo.y - alvoY);
        if (dist <= arma.area) {
          inimigo.hp = 0;
          inimigo.vivo = false;
          contadorInimigos--;
          inimigosMortosFase++;
          mortos++;
          mapa[inimigo.x][inimigo.y] = 0;
        }
      }

      for (let dx = -arma.area; dx <= arma.area; dx++) {
        for (let dy = -arma.area; dy <= arma.area; dy++) {
          let px = alvoX + dx,
            py = alvoY + dy;
          if (
            px >= 1 &&
            px <= mapX &&
            py >= 1 &&
            py <= mapY &&
            mapa[px][py] === 1
          ) {
            mapa[px][py] = 0;
            atualizarCelulaOffscreen(px, py);
          }
        }
      }

      addLog(`Explosão! ${mortos} inimigo(s) morto(s)`);
      atualizarUI();
      verificarFimJogo();
      return;
    }
    projetilX += stepX;
    projetilY += stepY;
    passoAtual++;

    rastro.push({ x: projetilX, y: projetilY });
    if (rastro.length > 8) rastro.shift();

    projetilAtivo = {
      x: projetilX,
      y: projetilY,
      stepX: stepX,
      stepY: stepY,
      rastro: [...rastro],
    };

    // desenharMapa();
  }, 35);
}
function calcularDanoArma() {
  const arma = ARMAS[armaEquipada];
  const dano = arma.danoPorProjetil * arma.quantidadeProjeteis;
  return dano;
}

// Função para verificar fim de jogo
function verificarFimJogo() {
  if (vida <= 0) finalizarJogo(false);
}

// Função de explosão realística
function criarExplosaoRealistica(x, y) {
  let frames = 0;
  const maxFrames = 20;

  const centerX = (x - 1) * CELL_W + CELL_W / 2;
  const centerY = (y - 1) * CELL_H + CELL_H / 2;
  let particulas = [];

  for (let i = 0; i < 30; i++) {
    particulas.push({
      x: centerX,
      y: centerY,
      vx: (Math.random() - 0.5) * 8,
      vy: (Math.random() - 0.5) * 8 - 3,
      vida: 1,
      tamanho: 3 + Math.random() * 5,
      cor: `hsl(${20 + Math.random() * 30}, 100%, ${50 + Math.random() * 30}%)`,
    });
  }

  const anim = setInterval(() => {
    if (!jogoAtivo || frames >= maxFrames) {
      clearInterval(anim);
      explosaoAtiva = null; // Desativa a explosão
      // desenharMapa();
      return;
    }

    // Atualiza lógica das partículas
    for (let i = 0; i < particulas.length; i++) {
      let p = particulas[i];
      p.x += p.vx;
      p.y += p.vy;
      p.vy += 0.2; // Gravidade
      p.vida -= 0.03;
      p.tamanho -= 0.1;
    }

    if (frames < 15 && frames % 2 === 0) {
      for (let i = 0; i < 5; i++) {
        particulas.push({
          x: centerX + (Math.random() - 0.5) * 30,
          y: centerY + (Math.random() - 0.5) * 30,
          vx: (Math.random() - 0.5) * 6,
          vy: (Math.random() - 0.5) * 6 - 2,
          vida: 0.8,
          tamanho: 2 + Math.random() * 4,
          cor: `hsl(${30 + Math.random() * 30}, 100%, 60%)`,
        });
      }
    }

    // Passa os dados calculados para a renderização global
    explosaoAtiva = {
      frames: frames,
      maxFrames: maxFrames,
      centerX: centerX,
      centerY: centerY,
      particulas: particulas,
    };

    frames++;
    // desenharMapa();
  }, 50);
}
function desenharFlashTiro() {
  if (!flashAnimacao) return;

  if (isNaN(flashX) || isNaN(flashY)) {
    flashAnimacao = false;
    return;
  }

  if (flashFrames >= flashMaxFrames) {
    flashAnimacao = false;
    return;
  }

  ctx.save();

  let tamanhoFlash = 18 - flashFrames * 4;
  if (tamanhoFlash < 4) tamanhoFlash = 4;

  let intensidade = 1 - flashFrames * 0.25;

  ctx.shadowBlur = 15;
  ctx.shadowColor = "#ff0000";

  // Formato da estrela
  ctx.beginPath();
  let pontas = 8;

  for (let i = 0; i < pontas; i++) {
    let anguloPonta = flashAngulo + (Math.PI * 2 * i) / pontas;
    let raioExterno = tamanhoFlash;
    let raioInterno = tamanhoFlash * 0.4;
    let raio = i % 2 === 0 ? raioExterno : raioInterno;

    let x = flashX + Math.cos(anguloPonta) * raio;
    let y = flashY + Math.sin(anguloPonta) * raio;

    if (i === 0) ctx.moveTo(x, y);
    else ctx.lineTo(x, y);
  }
  ctx.closePath();

  // Cores diferentes para cada arma
  const arma = ARMAS[armaEquipada];
  let corFlash = arma.corFlash || "#ff4400";

  let gradiente = ctx.createRadialGradient(
    flashX,
    flashY,
    0,
    flashX,
    flashY,
    tamanhoFlash,
  );
  gradiente.addColorStop(0, corFlash);
  gradiente.addColorStop(0.5, `rgba(255, 0, 0, ${intensidade * 0.8})`);
  gradiente.addColorStop(1, `rgba(139, 0, 0, 0)`);

  ctx.fillStyle = gradiente;
  ctx.fill();

  ctx.restore();
  flashFrames++;
}

// Animação de flash para todas as armas
function animarFlashTiro(dirX, dirY, arma) {
  const playerPixelXVisual = playerPixelX + CELL_W / 2;
  const playerPixelYVisual = playerPixelY + CELL_H / 2;

  let angulo = Math.atan2(dirY, dirX);
  let offsetDistancia = 20;

  flashX = playerPixelXVisual + Math.cos(angulo) * offsetDistancia;
  flashY = playerPixelYVisual + Math.sin(angulo) * offsetDistancia;
  flashAngulo = angulo;
  flashFrames = 0;
  flashMaxFrames = 4;
  flashAnimacao = true;
}

function trocarArma(armaId) {
  if (!ARMAS[armaId]) {
    addLog("Arma " + armaId + " nao existe");
    return false;
  }
  if (ARMAS[armaId].municaoMax !== -1 && ARMAS[armaId].municaoAtual <= 0) {
    addLog("Sem municao para " + ARMAS[armaId].nome);
    return false;
  }
  let nomeAntiga = ARMAS[armaEquipada].nome;
  armaEquipada = armaId;
  addLog("Troca de arma: " + nomeAntiga + " -> " + ARMAS[armaId].nome);
  atualizarBarraMunicaoHTML();
  let munStr =
    ARMAS[armaId].municaoMax === -1
      ? "infinita"
      : ARMAS[armaId].municaoAtual + "/" + ARMAS[armaId].municaoMax;
  addLog("Municao: " + munStr);
  exibirArteArma(armaId);
  atualizarInterfaceArmas();
  atualizarSelecaoArma();
  return true;
}

function criarInimigo(id, x, y, config = {}) {
  const hp = config.hp || 300;
  const isBoss = config.isBoss || false;
  const dano = config.dano || 20; // Boss dá 30 de dano!

  return {
    id: id,
    x: x,
    y: y,
    hp: hp,
    hpMaximo: hp,
    vivo: true,
    tipo: isBoss ? "boss" : "demonio",
    dano: dano,
    isBoss: isBoss,
  };
}

function moverDemonios() {
  if (intervaloMovimento) {
    clearInterval(intervaloMovimento);
    intervaloMovimento = null;
  }
  intervaloMovimento = setInterval(() => {
    moverTodosInimigos();
  }, 500);
}

function moverTodosInimigos() {
  if (!jogoAtivo) return;
  for (let i = 0; i < inimigos.length; i++) {
    if (inimigos[i].vivo) {
      moverInimigo(i);
    }
  }
}

function moverInimigo(idx) {
  const inimigo = inimigos[idx];
  if (!inimigo || !inimigo.vivo) return;

  let dx = 0,
    dy = 0;
  if (jogadorX > inimigo.x) dx = 1;
  else if (jogadorX < inimigo.x) dx = -1;
  if (jogadorY > inimigo.y) dy = 1;
  else if (jogadorY < inimigo.y) dy = -1;

  let proxX = inimigo.x;
  let proxY = inimigo.y;

  // Movimento inteligente do boss (mais agressivo)
  if (inimigo.isBoss) {
    // Boss tenta se mover em linha reta até o jogador
    if (Math.abs(dx) > 0 && Math.abs(dy) > 0) {
      // Movimento prioritário
      if (Math.random() < 0.7) {
        proxX = inimigo.x + dx;
      } else {
        proxY = inimigo.y + dy;
      }
    } else {
      proxX = inimigo.x + dx;
      proxY = inimigo.y + dy;
    }
  } else {
    // Movimento normal dos demônios
    if (Math.random() < 0.5) {
      proxX = inimigo.x + dx;
      if (proxX < 1 || proxX > mapX || mapa[proxX][proxY] === 1) {
        proxX = inimigo.x;
        proxY = inimigo.y + dy;
        if (proxY < 1 || proxY > mapY || mapa[proxX][proxY] === 1) {
          proxX = inimigo.x;
          proxY = inimigo.y;
        }
      }
    } else {
      proxY = inimigo.y + dy;
      if (proxY < 1 || proxY > mapY || mapa[proxX][proxY] === 1) {
        proxY = inimigo.y;
        proxX = inimigo.x + dx;
        if (proxX < 1 || proxX > mapX || mapa[proxX][proxY] === 1) {
          proxX = inimigo.x;
          proxY = inimigo.y;
        }
      }
    }
  }

  // Colisão com outros inimigos
  let colideInimigo = inimigos.some(
    (inv, i) => i !== idx && inv.vivo && inv.x === proxX && inv.y === proxY,
  );

  if (colideInimigo) {
    proxX = inimigo.x;
    proxY = inimigo.y;
  }

  // Ataque ao jogador (com dano diferenciado do boss!)
  if (proxX === jogadorX && proxY === jogadorY) {
    const danoInimigo = inimigo.dano || 20;
    if (aplicarDanoInimigo(danoInimigo)) {
      addLog(`Demônio te acertou! Vida: ${vida}`);
      if (vida <= 0) finalizarJogo(false);
    }
    return;
  }

  // Move o inimigo
  mapa[inimigo.x][inimigo.y] = 0;
  inimigo.x = proxX;
  inimigo.y = proxY;
  mapa[inimigo.x][inimigo.y] = 3;
}

function pararMovimento() {
  setTimeout(() => {
    if (intervaloMovimento) {
      clearInterval(intervaloMovimento);
      intervaloMovimento = null;
    }
  }, 50);
}

function renderizarMapaEstatico() {
  // Cria o canvas offscreen se ainda não existir
  if (!offscreenCanvas) {
    offscreenCanvas = document.createElement("canvas");
    offscreenCanvas.width = canvaW;
    offscreenCanvas.height = canvaH;
    offscreenCtx = offscreenCanvas.getContext("2d");
  }

  // Limpa o canvas offscreen
  offscreenCtx.clearRect(0, 0, canvaW, canvaH);

  // Desenha todas as células estáticas: chão, paredes e saída
  for (let y = 1; y <= mapY; y++) {
    for (let x = 1; x <= mapX; x++) {
      let tile = mapa[x][y];
      let px = (x - 1) * CELL_W;
      let py = (y - 1) * CELL_H;

      if (tile === 1) {
        // Desenho da parede (copiado do seu código original)
        offscreenCtx.fillStyle = "#3c2a23";
        offscreenCtx.fillRect(px, py, CELL_W - 1, CELL_H - 1);
        offscreenCtx.fillStyle = "#5e3e2c";
        offscreenCtx.fillRect(px + 2, py + 2, CELL_W - 5, CELL_H - 5);
        offscreenCtx.fillStyle = "#1f140e";
        offscreenCtx.fillRect(px + 4, py + 4, CELL_W - 9, CELL_H - 9);
      } else if (tile === 5) {
        // Desenho da saída (agora no offscreenCtx)
        offscreenCtx.shadowBlur = 0;
        const centroX = px + CELL_W / 2;
        const centroY = py + CELL_H / 2;
        offscreenCtx.fillStyle = "#1c1c1c";
        offscreenCtx.fillRect(px, py, CELL_W - 1, CELL_H - 1);
        offscreenCtx.fillStyle = "#2d2d2d";
        offscreenCtx.fillRect(px + 3, py + 3, CELL_W - 7, CELL_H - 7);
        offscreenCtx.fillStyle = "#cca000";
        offscreenCtx.fillRect(px + 3, py + 3, CELL_W - 7, 5);
        offscreenCtx.fillRect(px + 3, py + CELL_H - 9, CELL_W - 7, 5);
        offscreenCtx.fillStyle = "#111111";
        for (let i = 4; i < CELL_W - 6; i += 8) {
          offscreenCtx.beginPath();
          offscreenCtx.moveTo(px + i, py + 3);
          offscreenCtx.lineTo(px + i + 4, py + 8);
          offscreenCtx.lineTo(px + i + 2, py + 8);
          offscreenCtx.lineTo(px + i - 2, py + 3);
          offscreenCtx.fill();
          offscreenCtx.beginPath();
          offscreenCtx.moveTo(px + i - 2, py + CELL_H - 9);
          offscreenCtx.lineTo(px + i + 2, py + CELL_H - 4);
          offscreenCtx.lineTo(px + i, py + CELL_H - 4);
          offscreenCtx.lineTo(px + i - 4, py + CELL_H - 9);
          offscreenCtx.fill();
        }
        offscreenCtx.fillStyle = "#0f120e";
        offscreenCtx.fillRect(centroX - 12, centroY - 8, 24, 18);
        offscreenCtx.fillStyle = "#3a4039";
        offscreenCtx.fillRect(centroX - 11, centroY - 7, 22, 16);
        offscreenCtx.fillStyle = "#1b1f1a";
        offscreenCtx.fillRect(centroX - 9, centroY - 5, 18, 12);
        offscreenCtx.fillStyle = "#7a0f0f";
        offscreenCtx.fillRect(centroX - 6, centroY - 3, 12, 8);
        offscreenCtx.fillStyle = "#dc2424";
        offscreenCtx.fillRect(centroX - 6, centroY - 3, 12, 6);
        offscreenCtx.fillStyle = "#ff666b";
        offscreenCtx.fillRect(centroX - 5, centroY - 3, 10, 2);
        offscreenCtx.fillStyle = "#00ff00";
        offscreenCtx.fillRect(centroX - 15, centroY - 3, 2, 2);
        offscreenCtx.fillStyle = "#4a0000";
        offscreenCtx.fillRect(centroX - 15, centroY + 1, 2, 2);
        offscreenCtx.fillStyle = "#ff3333";
        offscreenCtx.font = "bold 10px monospace";
        offscreenCtx.textAlign = "center";
        offscreenCtx.imageSmoothingEnabled = false;
        offscreenCtx.fillText("EXIT", centroX, centroY - 11);
      } else {
        // Chão padrão (células vazias, 0, 2, 3, 4 serão sobrescritas)
        offscreenCtx.fillStyle = "#120e0a";
        offscreenCtx.fillRect(px, py, CELL_W - 1, CELL_H - 1);
        offscreenCtx.fillStyle = "#2f2a1f";
        offscreenCtx.fillRect(px + 1, py + 1, CELL_W - 3, CELL_H - 3);
      }
    }
  }
}

function desenharMapa() {
  if (!jogoAtivo) return;

  ctx.clearRect(0, 0, canvaW, canvaH);
  ctx.save();

  // Tremor de câmera durante explosões fortes
  if (explosaoAtiva && explosaoAtiva.frames < 8) {
    let força = 8 - explosaoAtiva.frames;
    let shakeX = (Math.random() - 0.5) * força;
    let shakeY = (Math.random() - 0.5) * força;
    ctx.translate(shakeX, shakeY);
  }

  // 1. DESENHA O FUNDO PRÉ-RENDERIZADO (paredes, chão, saída)
  if (offscreenCanvas) {
    ctx.drawImage(offscreenCanvas, 0, 0);
  }

  // 2. DESENHA ITENS (apenas os não coletados)
  for (let i = 0; i < itensMapa.length; i++) {
    let item = itensMapa[i];
    if (item.coletado) continue;
    let px = (item.x - 1) * CELL_W;
    let py = (item.y - 1) * CELL_H;

    if (item.tipo === "municao") {
      // CÓDIGO COMPLETO DE DESENHO DA CAIXA DE MUNIÇÃO (original)
      ctx.shadowBlur = 0;
      ctx.fillStyle = "#0f140d";
      ctx.fillRect(px + CELL_W / 2 - 14, py + CELL_H / 2 - 11, 28, 22);
      ctx.fillStyle = "#222b1f";
      ctx.fillRect(px + CELL_W / 2 - 4, py + CELL_H / 2 - 4, 19, 14);
      ctx.fillStyle = "#3a4735";
      ctx.fillRect(px + CELL_W / 2 - 4, py + CELL_H / 2 - 8, 18, 14);
      ctx.fillStyle = "#596d52";
      ctx.fillRect(px + CELL_W / 2 - 5, py + CELL_H / 2 - 10, 19, 3);
      ctx.fillStyle = "#2a3326";
      ctx.fillRect(px + CELL_W / 2 - 4, py + CELL_H / 2 - 7, 18, 1);
      ctx.fillStyle = "#525950";
      ctx.fillRect(px + CELL_W / 2 + 2, py + CELL_H / 2 - 2, 7, 6);
      ctx.fillStyle = "#707a6e";
      ctx.fillRect(px + CELL_W / 2 + 3, py + CELL_H / 2 - 2, 5, 2);
      ctx.fillStyle = "#1b1f1a";
      ctx.fillRect(px + CELL_W / 2 + 4, py + CELL_H / 2 + 1, 3, 2);
      ctx.fillStyle = "#141a12";
      ctx.fillRect(px + CELL_W / 2 - 13, py + CELL_H / 2 - 7, 9, 15);
      ctx.fillStyle = "#293326";
      ctx.fillRect(px + CELL_W / 2 - 13, py + CELL_H / 2 + 4, 9, 4);
      ctx.fillStyle = "#cca025";
      ctx.fillRect(px + CELL_W / 2 - 12, py + CELL_H / 2 - 5, 7, 2);
      ctx.fillStyle = "#9c1c1c";
      ctx.fillRect(px + CELL_W / 2 - 12, py + CELL_H / 2 - 3, 7, 6);
      ctx.fillStyle = "#e63c3c";
      ctx.fillRect(px + CELL_W / 2 - 12, py + CELL_H / 2 - 1, 2, 3);
      ctx.fillRect(px + CELL_W / 2 - 8, py + CELL_H / 2 - 1, 2, 3);
      ctx.fillRect(px + CELL_W / 2 - 5, py + CELL_H / 2 - 2, 1, 4);
      ctx.fillStyle = "#b37422";
      ctx.fillRect(px + CELL_W / 2 - 11, py + CELL_H / 2 + 3, 1, 1);
      ctx.fillRect(px + CELL_W / 2 - 7, py + CELL_H / 2 + 3, 1, 1);
      ctx.fillStyle = "#0f140d";
      ctx.fillRect(px + CELL_W / 2 - 10, py + CELL_H / 2 - 5, 1, 9);
      ctx.fillRect(px + CELL_W / 2 - 6, py + CELL_H / 2 - 5, 1, 9);
      ctx.fillStyle = "rgba(255, 255, 255, 0.15)";
      ctx.fillRect(px + CELL_W / 2 - 4, py + CELL_H / 2 - 10, 4, 3);
    } else if (item.tipo === "vida") {
      // 1. Variáveis de centro para não ter que repetir os cálculos
      const cx = px + CELL_W / 2;
      const cy = py + CELL_H / 2;

      // 2. Efeito de flutuação suave baseado no tempo
      const floatOffset = Math.sin(Date.now() / 200) * 3;
      const itemY = cy + floatOffset;

      ctx.shadowBlur = 0; // Mantém o visual retrô "pixelado" e seco

      // 3. Sombra no chão (elipse que fica parada enquanto o item flutua)
      ctx.fillStyle = "rgba(0, 0, 0, 0.4)";
      ctx.beginPath();
      // ellipse(x, y, radiusX, radiusY, rotation, startAngle, endAngle)
      ctx.ellipse(cx, cy + 14, 16, 5, 0, 0, Math.PI * 2);
      ctx.fill();

      // 4. Contorno preto (Outline) ao redor da caixa inteira
      ctx.fillStyle = "#000000";
      ctx.fillRect(cx - 15, itemY - 12, 30, 24);

      // Fundo branco principal
      ctx.fillStyle = "#f0f0f0";
      ctx.fillRect(cx - 14, itemY - 11, 28, 22);

      // Bordas cinzas para dar profundidade
      ctx.fillStyle = "#8b8b8b";
      ctx.fillRect(cx - 14, itemY - 11, 28, 2); // Topo
      ctx.fillRect(cx - 14, itemY - 11, 2, 22); // Esquerda
      ctx.fillRect(cx + 12, itemY - 11, 2, 22); // Direita
      ctx.fillRect(cx - 14, itemY + 9, 28, 2); // Fundo

      // Sombra interna para a "frente" da caixa
      ctx.fillStyle = "#d0d0d0";
      ctx.fillRect(cx - 12, itemY - 9, 24, 18);

      // Cruz vermelha (agora centralizada com as novas variáveis)
      ctx.fillStyle = "#e31b23";
      ctx.fillRect(cx - 8, itemY - 3, 16, 6); // Horizontal
      ctx.fillRect(cx - 3, itemY - 8, 6, 16); // Vertical

      // Brilho na cruz para volume
      ctx.fillStyle = "#ff6b6b";
      ctx.fillRect(cx - 6, itemY - 2, 4, 2);
      ctx.fillRect(cx - 2, itemY - 6, 2, 4);

      // Tampa/Alça da caixa (agora como um detalhe acima do branco)
      ctx.fillStyle = "#555555";
      ctx.fillRect(cx - 6, itemY - 14, 12, 3);
    }
  }

  function atualizarCelulaOffscreen(x, y) {
    if (!offscreenCtx) return;
    let px = (x - 1) * CELL_W;
    let py = (y - 1) * CELL_H;
    // Redesenha o chão padrão
    offscreenCtx.fillStyle = "#120e0a";
    offscreenCtx.fillRect(px, py, CELL_W - 1, CELL_H - 1);
    offscreenCtx.fillStyle = "#2f2a1f";
    offscreenCtx.fillRect(px + 1, py + 1, CELL_W - 3, CELL_H - 3);
  }

  // 3. DESENHA INIMIGOS VIVOS + BARRA DE VIDA
  for (let i = 0; i < inimigos.length; i++) {
    let inv = inimigos[i];
    if (!inv.vivo) continue;
    let px = (inv.x - 1) * CELL_W;
    let py = (inv.y - 1) * CELL_H;

    // Sprite do demônio
    if (imagens.demon) {
      ctx.drawImage(imagens.demon, px + 1, py + 1, CELL_W + 5, CELL_H + 5);
    }

    // Barra de vida
    const hpPercent = inv.hp / inv.hpMaximo;
    const barraWidth = CELL_W - 4;
    const barraHeight = 5;
    const barraX = px + 2;
    const barraY = py - 8;
    ctx.fillStyle = "#4a0000";
    ctx.fillRect(barraX, barraY, barraWidth, barraHeight);
    ctx.fillStyle =
      hpPercent > 0.6 ? "#00ff00" : hpPercent > 0.3 ? "#ffaa00" : "#ff0000";
    ctx.fillRect(barraX, barraY, barraWidth * hpPercent, barraHeight);
    ctx.strokeStyle = "#888888";
    ctx.lineWidth = 1;
    ctx.strokeRect(barraX, barraY, barraWidth, barraHeight);
    ctx.fillStyle = "#ffffff";
    ctx.font = "bold 9px monospace";
    ctx.shadowBlur = 0;
    ctx.fillText(`${inv.hp}`, barraX + 2, barraY - 2);
  }

  // 4. DESENHA O JOGADOR
  if (imagens.marine) {
    ctx.drawImage(
      imagens.marine,
      playerPixelX,
      playerPixelY,
      CELL_W + 5,
      CELL_H + 5,
    );
  }

  // 5. DESENHA PROJÉTIL ATIVO (míssil RPG-7)
  if (projetilAtivo) {
    ctx.save();
    let angulo = Math.atan2(projetilAtivo.stepY, projetilAtivo.stepX);
    ctx.translate(projetilAtivo.x, projetilAtivo.y);
    ctx.rotate(angulo);

    // Corpo do míssil
    ctx.fillStyle = "#707a70";
    ctx.fillRect(-6, -3, 14, 6);
    ctx.fillStyle = "#4a524a";
    ctx.fillRect(-6, 1, 14, 2);

    // Ponta vermelha
    ctx.beginPath();
    ctx.moveTo(8, -3);
    ctx.lineTo(14, 0);
    ctx.lineTo(8, 3);
    ctx.fillStyle = "#ba2525";
    ctx.fill();

    // Aletas traseiras
    ctx.fillStyle = "#222522";
    ctx.fillRect(-10, -5, 4, 2);
    ctx.fillRect(-10, 3, 4, 2);

    // Chama do foguete
    ctx.beginPath();
    ctx.moveTo(-10, -2);
    ctx.lineTo(-16, 0);
    ctx.lineTo(-10, 2);
    ctx.fillStyle = "rgba(255, 120, 0, 0.9)";
    ctx.fill();

    ctx.restore();
  }

  // 6. DESENHA EXPLOSÃO ATIVA
  if (explosaoAtiva) {
    ctx.save();
    let exp = explosaoAtiva;
    // Bola de fogo inicial
    if (exp.frames < 10) {
      let expansao = exp.frames * 8;
      ctx.beginPath();
      ctx.arc(exp.centerX, exp.centerY, expansao, 0, Math.PI * 2);
      ctx.fillStyle = `rgba(255, ${100 - exp.frames * 20}, 0, ${0.8 - exp.frames * 0.08})`;
      ctx.fill();
    }
    // Fumaça
    let tamanhoFumaca = 20 + exp.frames * 4;
    for (let i = 0; i < 5; i++) {
      let offsetX = Math.sin(exp.frames * 0.2 + i) * exp.frames * 1.5;
      let offsetY = Math.cos(exp.frames * 0.3 + i) * exp.frames * 1;
      ctx.beginPath();
      ctx.arc(
        exp.centerX + offsetX,
        exp.centerY + offsetY - 10,
        tamanhoFumaca * (0.3 + i * 0.1),
        0,
        Math.PI * 2,
      );
      ctx.fillStyle = `rgba(60, 60, 60, ${0.6 - exp.frames / exp.maxFrames})`;
      ctx.fill();
    }
    // Partículas
    for (let i = 0; i < exp.particulas.length; i++) {
      let p = exp.particulas[i];
      if (p.vida > 0 && p.tamanho > 0) {
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.tamanho, 0, Math.PI * 2);
        // Converte a cor HSL para RGBA dinamicamente (simplificado)
        ctx.fillStyle =
          p.cor
            .replace("hsl", "rgba")
            .replace("100%", "1")
            .replace("50%", "0.8") + `, ${p.vida})`;
        ctx.fill();
        ctx.shadowBlur = 10;
        ctx.shadowColor = "#ff4400";
        ctx.fill();
      }
    }
    ctx.restore();
  }

  // 7. FLASH DE TIRO (animação de disparo)
  desenharFlashTiro();

  ctx.restore();

  // Borda decorativa do canvas
  ctx.strokeStyle = "#b87c4f";
  ctx.lineWidth = 2;
  ctx.strokeRect(0, 0, canvaW, canvaH);
  canvas.style.cursor = "crosshair";
}
function carregarFase(fase) {
  // Reseta flags específicas da fase
  temKeycard = false;
  bossMorto = false;

  // Limpar mapa
  for (let x = 1; x <= mapX; x++) {
    for (let y = 1; y <= mapY; y++) {
      mapa[x][y] = 0;
    }
  }

  const dados = fases[fase];

  if (!dados) {
    console.error("Fase não encontrada!");
    return;
  }

  addLog(`\n CARREGANDO FASE ${fase}: ${dados.nome} `);

  // ===== SAÍDA =====
  if (dados.saida) {
    mapa[dados.saida.x][dados.saida.y] = 5;
  }

  // ===== Paredes das bordas =====
  for (let x = 1; x <= mapX; x++) {
    if (mapa[x][1] !== 5) mapa[x][1] = 1;
    if (mapa[x][mapY] !== 5) mapa[x][mapY] = 1;
  }
  for (let y = 1; y <= mapY; y++) {
    if (mapa[1][y] !== 5) mapa[1][y] = 1;
    if (mapa[mapX][y] !== 5) mapa[mapX][y] = 1;
  }

  // Paredes adicionais
  if (dados.paredes) {
    dados.paredes.forEach((p) => {
      if (mapa[p.x][p.y] !== 5) mapa[p.x][p.y] = 1;
    });
  }

  // ===== ITENS =====
  itensMapa = [];
  if (dados.itens) {
    dados.itens.forEach((item) => {
      itensMapa.push({
        x: item.x,
        y: item.y,
        tipo: item.tipo,
        coletado: false,
      });
      if (mapa[item.x][item.y] !== 5) mapa[item.x][item.y] = 4;
    });
  }

  // ===== JOGADOR =====
  jogadorX = dados.jogadorInicio.x;
  jogadorY = dados.jogadorInicio.y;
  mapa[jogadorX][jogadorY] = 2;
  playerPixelX = (jogadorX - 1) * CELL_W;
  playerPixelY = (jogadorY - 1) * CELL_H;

  // ===== INIMIGOS =====
  contadorInimigos = dados.inimigos.length;
  inimigosMortosFase = 0;
  inimigos = [];

  dados.inimigos.forEach((inimigoConfig, index) => {
    const novoInimigo = criarInimigo(index, inimigoConfig.x, inimigoConfig.y, {
      hp: inimigoConfig.hp || 300,
      isBoss: inimigoConfig.isBoss || false,
      dano: inimigoConfig.dano || 20,
    });
    inimigos.push(novoInimigo);

    if (mapa[novoInimigo.x][novoInimigo.y] !== 5) {
      mapa[novoInimigo.x][novoInimigo.y] = 3;
    }

    if (novoInimigo.isBoss) {
      addLog(`⚠️ BARÃO DO INFERNO AVISTADO! VIDA: ${novoInimigo.hp} ⚠️`);
    }
  });

  atualizarUI();
  desenharMapa();
  renderizarMapaEstatico();
}

function exibirTelaFim(config) {
  pararCronometro();
  if (typeof Pontuacao === "function") Pontuacao(); // Atualiza a pontuação global

  // 1. Configura textos e cores personalizados
  gameoverTitle.innerText = config.titulo;
  gameoverTitle.style.color = config.cor;
  actionButton.innerHTML = `<span>${config.textoBotao}</span>`;
  quitButton.style.display = config.esconderSair ? "none" : "inline-block";

  // 2. Define dinamicamente o que o botão fará ao ser clicado
  actionButton.onclick = () => {
    gameoverScreen.classList.remove("show"); // Esconde a tela
    config.acaoBotao(); // Executa a função correspondente
  };

  // 3. Atualiza as estatísticas da fase atual
  const dadosFase = fases[faseAtual];
  const totalInimigosFase = dadosFase ? dadosFase.inimigos.length : 6;

  alvosValue.innerText = `${faseAtual === Object.keys(fases).length ? inimigosMortosTotal : inimigosMortosFase}/${inimigosMortosTotal}`;
  timeValue.innerText = formatarTempo(tempoTotal);

  // 4. Animação do Score subindo (Otimizada para não demorar muito se o score for alto)
  scoreValue.innerText = "0";
  gameoverScreen.classList.add("show");

  setTimeout(() => {
    let i = 0;
    const passo = Math.ceil(pontuacao / 40) || 1; // Sobe o score em até 40 passos

    function updateScore() {
      if (i < pontuacao) {
        i += passo;
        if (i > pontuacao) i = pontuacao; // Não deixa passar do limite
        scoreValue.innerText = i;
        setTimeout(updateScore, 15);
      } else {
        scoreValue.innerText = pontuacao;
      }
    }
    updateScore();
  }, 500);
}

function verificarSaida(x, y) {
  const dados = fases[faseAtual];
  if (!dados) return;

  Object.values(fases).map((f) => f.inimigos.length);
  const totalInimigosFase = dados.inimigos.length;
  console.log(faseAtual, Object.keys(fases).length);
  // Verifica se está na posição da saída
  if (x == 19 && y == 8) {
    if (inimigosMortosFase < totalInimigosFase) {
      addLog("ACESSO NEGADO!");
      return;
    }
    addLog("SAÍDA ENCONTRADA! VOCÊ COMPLETOU A FASE!");
    inimigosMortosTotal += inimigosMortosFase;
    exibirTelaFim({
      titulo: "Fase Completa!",
      cor: "#00f5d4",
      textoBotao: "Próxima Fase",
      acaoBotao: () => {
        if (faseAtual === Object.keys(fases).length) {
          finalizarJogo(true); // Vitória final
        } else {
          faseAtual++;
          carregarFase(faseAtual);
          iniciarCronometro();
          moverDemonios();
        }
      },
    });
  }
}
function finalizarJogo(vitoria) {
  if (!jogoAtivo) return;
  if (animationId) cancelAnimationFrame(animationId);
  jogoAtivo = false;
  esperandoInput = true;
  pararMovimento();

  if (vida <= 0) {
    // CENÁRIO 3: Jogador morreu
    addLog("GAME OVER! Sua alma pertence ao inferno.");
    exibirTelaFim({
      titulo: "VOCÊ MORREU",
      cor: "#9d0208", // Vermelho sangue
      textoBotao: "Renascer",
      acaoBotao: () => {
        reiniciarFaseAtual();
      },
    });
  } else if (vitoria) {
    // CENÁRIO 4: Vitória final (Zerou o jogo)
    addLog("GRANDE VITÓRIA, MARINE! O INFERNO FOI EXPULSADO.");
    exibirTelaFim({
      titulo: "VITÓRIA ABSOLUTA!",
      cor: "#00f5d4",
      textoBotao: "Menu Inicial",
      esconderSair: true,
      acaoBotao: () => {
        faseAtual = 1;
        voltarAoMenuPrincipal();
      },
    });
  }
  desenharMapa();
}

function inicializarJogo() {
  resetarCronometro();
  iniciarCronometro();
  pontuacao = 0;
  vida = 100;
  inimigosMortosFase = 0;
  contadorInimigos = 6;
  jogoAtivo = true;
  esperandoInput = false;
  canvas.style.display = "block";
  tutorialContainer.style.display = "none";
  gameContainer.style.display = "flex";
  menuInicial.style.display = "none";
  doomTitle.style.display = "none";
  logArea.style.display = "block";
  const wrapper = document.querySelector(".canvas-wrapper");
  doomFacePlayer.querySelector("img").src = "./img/doom-avatar/face-player.jpg";
  if (wrapper) wrapper.style.display = "flex";
  doomFacePlayer.style.display = "flex";
  municao(null, false);
  atualizarBarraMunicaoHTML();
  armaEquipada = 1;
  ultimoTiro = 0;
  direcaoAtual = "w";
  exibirArteArma(1);
  atualizarInterfaceArmas();
  atualizarSelecaoArma();
  carregarFase(1);
  atualizarUI();
  desenharMapa();
  if (intervaloMovimento) clearInterval(intervaloMovimento);
  moverDemonios();
  if (animationId) cancelAnimationFrame(animationId);
  gameLoop();
}

quitButton.addEventListener("click", voltarAoMenuPrincipal);

function voltarAoMenuPrincipal() {
  // Cancela animação
  if (animationId) {
    cancelAnimationFrame(animationId);
    animationId = null;
  }
  // Para movimentos dos inimigos
  if (intervaloMovimento) {
    clearInterval(intervaloMovimento);
    intervaloMovimento = null;
  }
  // Para cronômetro
  if (intervaloRelogio) {
    clearInterval(intervaloRelogio);
    intervaloRelogio = null;
  }

  // Esconde elementos do jogo
  gameoverScreen.classList.remove("show");
  canvas.style.display = "none";
  logArea.style.display = "none";
  weaponArtImg.style.display = "none";
  bar.style.display = "none";
  doomFacePlayer.style.display = "none";
  for (let chave in imagens) {
    imagens[chave] = null;
  }
  imagensCarregadas = 0;
  gameContainer.style.display = "none";
  menuInicial.style.display = "flex";
  doomTitle.style.display = "flex";

  // Reseta flags do jogo
  jogoAtivo = false;
  esperandoInput = false;
  etapaAtual = "menu";
  btnActionIndex = 0;
  btnActionRender();

  // Opcional: limpar o canvas para não mostrar o último frame
  ctx.clearRect(0, 0, canvaW, canvaH);

  // ✅ GARANTE QUE O LOG ESTÁ LIMPO
  logArea.innerHTML = "";
}
// function resetarInfoBar() {
// Reseta valores da UI
//   vidaSpan.innerText = "100%";
//   barraVida.style.width = "100%";
//   inimigosSpan.innerText = "6";
//   // Reseta animações
//   vidaSpan.style.animation = "";
// }
function renderTutorialCard() {
  tutorialContainer.style.display = "flex";

  // Encontrar o card de armas existente ou criar um novo
  let armasCard = document.querySelector(".tutorial-card.armas");

  if (armasCard) {
    // Se já existe, substituir o conteúdo
    const novoCard = renderizarArmas();
    armasCard.parentNode.replaceChild(novoCard, armasCard);
  } else {
    // Se não existe, adicionar ao tutorial-box
    const tutorialBox = document.querySelector(".tutorial-box");
    const novoCard = renderizarArmas();

    // Inserir antes dos botões de ação
    const buttonsActions = document.getElementById("buttonsActions");
    tutorialBox.insertBefore(novoCard, buttonsActions);
  }

  // Atualizar a lista de cards
  const tutorialCardElements = document.querySelectorAll(".tutorial-card");

  tutorialCardElements.forEach((t) => {
    const idElement = t.querySelector(".tutorial-id");
    if (idElement) {
      const i = idElement.innerText.trim();
      if (i == tutorialCardIndex) {
        t.style.display = "flex";
      } else {
        t.style.display = "none";
      }
    }
  });

  if (tutorialCardIndex == 5) {
    btnProceed.innerText = "Começar jogo";
  } else {
    btnProceed.textContent = "Próximo";
  }

  btnBack.classList.toggle("disable", tutorialCardIndex == 1);
}
function handleKeyDown(e) {
  const key = e.key;
  const teclasBloqueio = [
    "w",
    "W",
    "s",
    "S",
    "a",
    "A",
    "d",
    "D",
    "f",
    "F",
    "q",
    "Q",
    "h",
    "H",
    "1",
    "2",
    "3",
    "4",
    "5",
    "r",
    "R",
    "Escape",
    "ArrowUp",
    "ArrowDown",
    "ArrowLeft",
    "ArrowRight",
    "Space",
  ];
  if (teclasBloqueio.includes(key)) e.preventDefault();

  if (jogoAtivo) {
    if (key === "r" || key === "R") {
      recarregarMunicao();
      return;
    } else if (key === "h" || key === "H") {
      usarKitMedico();
      console.log(vida);
      return;
    }
  }

  // trocar arma (1-3)
  if (key >= "1" && key <= "4") {
    trocarArma(parseInt(key));
    return;
  }

  // atirar (Espaço)
  if (key === "Space" || key === " ") {
    atirar();
    return;
  }

  // movimento WASD (altera direcao e move)
  let moved = false;
  switch (key) {
    case "w":
    case "W":
    case "ArrowUp":
      moved = moverJogador(0, -1);
      break;
    case "s":
    case "S":
    case "ArrowDown":
      moved = moverJogador(0, 1);
      break;
    case "a":
    case "A":
    case "ArrowLeft":
      moved = moverJogador(-1, 0);
      break;
    case "d":
    case "D":
    case "ArrowRight":
      moved = moverJogador(1, 0);
      break;
    case "q":
    case "Q":
      menuPause.style.display = "flex";
      jogoAtivo = false;
      break;
  }
  if (moved) {
    atualizarUI();
    desenharMapa();
    if (vida <= 0) finalizarJogo(false);
  } else if (key.startsWith("Arrow")) {
    desenharMapa();
  }
}

function recarregarMunicao() {
  let arma = ARMAS[armaEquipada];
  if (arma.municaoAtual < arma.municaoMax && municaoCartucho > 0) {
    if (arma.municaoMax !== -1) {
      let quantidade = Math.floor(arma.municaoMax * 0.25);
      arma.municaoAtual = Math.min(
        arma.municaoMax,
        arma.municaoAtual + quantidade,
      );
      addLog(`+${quantidade} munição para ${arma.nome}!`);
      atualizarInterfaceArmas();
      municao();
      municaoCartucho--;
    }
  }
}

function usarKitMedico() {
  if (vida < 100 && kitMedico > 0) {
    vida += 20;
    atualizarUI()
    const efeito = document.createElement("div")
    efeito.classList.add("vidaEfeito")
    document.body.appendChild(efeito)
    setTimeout(() => {
      efeito.classList.remove("vidaEfeito")
    }, 500);
    if (vida > 100) {
      vidaJogador = 100; 
    }
  }
}

function gameLoop() {
  if (!jogoAtivo) {
    if (animationId) cancelAnimationFrame(animationId);
    return;
  }

  updateMovement(); // Só atualiza movimento aqui
  desenharMapa();

  animationId = requestAnimationFrame(gameLoop);
}

function loadImages() {
  for (let chave in arquivos) {
    imagens[chave] = new Image();
    imagens[chave].src = arquivos[chave];
    imagens[chave].onload = () => {
      imagensCarregadas++;
      if (imagensCarregadas === totalImagens) inicializarJogo();
    };
  }
}

document.addEventListener("keydown", (e) => {
  e.preventDefault();
  switch (e.key) {
    case "ArrowDown":
      btnActionIndex++;
      btnActionRender();
      break;
    case "ArrowUp":
      btnActionIndex--;
      btnActionRender();
      break;
    case "Enter":
      switch (etapaAtual) {
        case "menu":
          switch (btnActionIndex) {
            case 0:
              renderIntro();
              break;
            case 1:
              renderTutorial();
              break;
            case 2:
              renderCreditos();
              break;
          }
          break;
        case "intro":
          introCharacterContainer.style.display = "none";
          loadImages();
          break;
        case "tutorial":
          if (tutorialCardIndex == 5) {
            renderIntro();
          } else {
            tutorialCardIndex++;
            renderTutorialCard();
          }
          break;
      }
      break;
    case "Escape":
      switch (etapaAtual) {
        case "intro":
          closeIntro();
          break;
        case "tutorial":
          closeTutorial();
          break;
        case "creditos":
          closeCreditos();
          break;
      }
  }
});

// Quando clicar no botão de créditos do menu
function renderCreditos() {
  menuActions.style.display = "none";
  iniciarCreditos();
  etapaAtual = "creditos";
}

function iniciarCreditos() {
  const container = document.querySelector(".credits-container");
  const content = document.querySelector(".credits-content");
  const text = document.querySelector(".credits-text");

  if (!container || !content || !text) {
    console.error("Elementos de créditos não encontrados");
    return;
  }

  // Reseta qualquer animação anterior
  if (text.getAnimations) {
    text.getAnimations().forEach((anim) => anim.cancel());
  }

  container.style.display = "flex";

  // Pequeno delay para garantir que o container já está visível
  setTimeout(() => {
    // 1. Pegamos as alturas exatas em pixels
    const alturaContainer = content.offsetHeight;
    const alturaTexto = text.offsetHeight;

    // 2. Definimos os pontos exatos de início e fim
    const pontoInicial = alturaContainer;
    const pontoFinal = -alturaTexto;

    // 3. Calculamos o tempo proporcional (40 pixels por segundo)
    const pixelsPorSegundo = 45;
    const distancia = pontoInicial - pontoFinal;
    const duracaoTotal = (distancia / pixelsPorSegundo) * 1000;

    // 4. Aplica a animação
    text.animate(
      [
        { transform: `translateY(${pontoInicial}px)` },
        { transform: `translateY(${pontoFinal}px)` },
      ],
      {
        duration: duracaoTotal,
        iterations: Infinity,
        easing: "linear",
      },
    );
  }, 50);
}

function closeCreditos() {
  const container = document.querySelector(".credits-container");
  const text = document.querySelector(".credits-text");

  if (text && text.getAnimations) {
    text.getAnimations().forEach((anim) => anim.cancel());
  }

  if (container) {
    container.style.display = "none";
    menuActions.style.display = "flex";
    etapaAtual = "menu";
    btnActionRender();
  }
}

function renderIntro() {
  introCharacterContainer.style.display = "flex";
  menuInicial.style.display = "none";
  etapaAtual = "intro";
  tutorialContainer.style.display = "none";
}
function closeIntro() {
  introCharacterContainer.style.display = "none";
  menuInicial.style.display = "flex";
  etapaAtual = "menu";
  tutorialContainer.style.display = "none";
}

function renderTutorial() {
  menuInicial.style.display = "none";
  renderTutorialCard();
  etapaAtual = "tutorial";
}
function closeTutorial() {
  menuInicial.style.display = "flex";
  tutorialContainer.style.display = "none";
  btnActionRender();
  etapaAtual = "menu";
}

resumeButton.addEventListener("click", () => {
  menuPause.style.display = "none";
  jogoAtivo = true;
  esperandoInput = false;
  gameLoop();
});

restartButton.addEventListener("click", () => {
  menuPause.style.display = "none";
  reiniciarFaseAtual();
});

mainMenuButton.addEventListener("click", () => {
  menuPause.style.display = "none";
  voltarAoMenuPrincipal();
});

btnStart.addEventListener("click", renderIntro);
btnTutorial.addEventListener("click", renderTutorial);
btnCreditos.addEventListener("click", renderCreditos);
btnBack.addEventListener("click", () => {
  if (tutorialCardIndex == 1) return;
  tutorialCardIndex--;
  renderTutorialCard();
});

btnProceed.addEventListener("click", () => {
  if (tutorialCardIndex == 5) {
    etapaAtual = "intro";
    introCharacterContainer.style.display = "flex";
    tutorialContainer.style.display = "none";
  } else {
    tutorialCardIndex++;
    renderTutorialCard();
  }
});

function reiniciarFaseAtual() {
  gameoverScreen.classList.remove("show");
  jogoAtivo = true;
  esperandoInput = false;
  pontuacao = 0;

  inicializarJogo();
}
canvas.addEventListener("mousemove", (e) => {
  const rect = canvas.getBoundingClientRect();
  const scaleX = canvas.width / rect.width;
  const scaleY = canvas.height / rect.height;

  let mouseX = (e.clientX - rect.left) * scaleX;
  let mouseY = (e.clientY - rect.top) * scaleY;

  const playerPixelXVisual = playerPixelX + CELL_W / 2;
  const playerPixelYVisual = playerPixelY + CELL_H / 2;

  let dx = mouseX - playerPixelXVisual;
  let dy = mouseY - playerPixelYVisual;
  let len = Math.hypot(dx, dy);

  if (len > 0.001) {
    miraVetor.x = dx / len;
    miraVetor.y = dy / len;
  }
});
window.addEventListener("keydown", handleKeyDown);

// estilos dinamicos (keyframes)
const styleSheet = document.createElement("style");
styleSheet.textContent = `
        @keyframes damageNumber {
          0% { transform: scale(1); color: #f0e6a0; }
          50% { transform: scale(1.3); color: #ff0000; text-shadow: 0 0 5px rgba(255,0,0,0.8); }
          100% { transform: scale(1); color: #f0e6a0; }
        }
        @keyframes pulseRed {
          0%,100% { color: #f0e6a0; text-shadow: 0 0 0px rgba(255,0,0,0); }
          50% { color: #ff0000; text-shadow: 0 0 10px rgba(255,0,0,0.8); }
        }
        @keyframes floatBlood {
          0% { transform: translate(0,0) scale(1); opacity: 1; }
          100% { transform: translate(50px,-50px) scale(0); opacity: 0; }
        }
      `;
document.head.appendChild(styleSheet);

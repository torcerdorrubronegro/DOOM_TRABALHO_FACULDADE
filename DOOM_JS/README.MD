DOOM JS - Recriação do clássico de 1993

Sobre o projeto

Este projeto é uma recriação fan-made do jogo DOOM (1993) da id Software, desenvolvida inteiramente em HTML5 Canvas, CSS3 e JavaScript puro. O objetivo é trazer a jogabilidade essencial do clássico para o navegador, mantendo a estética retrô e a brutalidade característica. O jogador controla um fuzileiro espacial que deve eliminar demônios, coletar munição, explorar fases e encontrar a saída de cada nível.

Funcionalidades

- Movimentação suave em grade com animação entre células.
- Quatro armas diferentes: Pistola, Espingarda, Metralhadora e Lança-foguetes, cada uma com estatísticas próprias, munição limitada e efeitos visuais.
- Inimigos com inteligência artificial simples que perseguem o jogador e atacam ao encostar.
- Sistema de dano por projétil, incluindo tiro normal, penetrante (Metralhadora) e de área (Lança-foguetes).
- Três fases completas com mapas diferentes e diversos inimigos.
- Paredes destrutíveis por explosões do Lança-foguetes.
- Mira controlada pelo mouse para apontar os disparos.
- HUD detalhado com indicadores de vida, munição por arma, inimigos restantes, console de eventos e objetivo dinâmico.
- Tutorial interativo que explica movimentação, arsenal, interface e exploração.
- Menus e telas de fim de fase com estatísticas de desempenho (pontuação, tempo, alvos abatidos).

Como jogar

O jogador inicia no menu principal, podendo escolher "Novo Jogo" para iniciar a campanha ou "Tutorial" para aprender as mecânicas. Após a introdução do personagem, o jogo começa na Fase 1.

O objetivo de cada fase é eliminar todos os inimigos presentes e depois alcançar a saída (marcada como EXIT). A saída só é liberada quando não há mais demônios vivos. Ao completar a fase, o jogador avança para a próxima. A derrota ocorre quando a vida chega a zero, sendo possível reiniciar a fase atual.

Controles

Movimentar:
- W ou Seta para cima: anda para frente
- S ou Seta para baixo: anda para trás
- A ou Seta para esquerda: anda para esquerda
- D ou Seta para direita: anda para direita

Atirar: barra de espaço

Trocar arma:
- Tecla 1: Pistola
- Tecla 2: Espingarda
- Tecla 3: Metralhadora
- Tecla 4: Lança-foguetes

Mirar: mover o mouse dentro da área do canvas

Reiniciar (após morrer): tecla R

Pause da partida atual: tecla Q

Mecânicas importantes

- Vida: inicia com 100%. Receber dano de inimigos reduz a vida. Quando a vida fica abaixo de 30%, a barra pisca e o rosto do personagem fica ensanguentado.
- Munição: cada arma possui um estoque máximo e um estoque atual. Caixas de munição espalhadas pelo mapa recarregam 30% da capacidade máxima da arma equipada no momento.
- Inimigos: cada demônio tem sua própria barra de vida e se move em direção ao jogador a cada 0,5 segundo. Ao encostar, causam dano (20 pontos para inimigos normais, 30 para o chefe).
- Explosões: o Lança-foguetes causa dano em área, podendo destruir paredes próximas e acertar vários inimigos de uma vez.
- Console de eventos: localizado na lateral direita, exibe mensagens em tempo real sobre dano, mortes, troca de armas, coleta de itens e liberação de saída.

Fases

Fase 1
Mapa introdutório com seis inimigos distribuídos nos cantos, algumas paredes internas e quatro caixas de munição. Saída no lado direito.

Fase 2
Mapa com labirinto, seis inimigos espalhados, mais paredes bloqueando caminhos e itens de munição em locais estratégicos.

Fase 3
Última fase e quatro demônios de apoio. Paredes formam uma área octogonal com pilares para cobertura. Seis caixas de munição estão disponíveis.

Tecnologias utilizadas

- HTML5 Canvas para renderização 2D do mapa, personagens e efeitos visuais.
- JavaScript (ES6+) para toda a lógica do jogo: movimentação, combate, inteligência artificial, controle de fases, animações e sistema de eventos.
- CSS3 para a interface do usuário, incluindo HUD, menus, tutorial, overlays de dano, animações de tremor e estilo retrô.
- Fontes customizadas: Doom.ttf, AmazDooMLeft.ttf, AmazDooMRight.ttf, Press Start 2P, Jersey 25, Science Gothic.
- Font Awesome para ícones utilizados nos tutoriais e interface.

Como executar

1. Baixe ou clone o repositório com todos os arquivos.
2. Mantenha a estrutura de pastas original:
   - O arquivo index.html na raiz.
   - A pasta font/ com os arquivos de fonte.
   - A pasta img/ com todas as subpastas (doom-avatar, doom-enemys, doom-weapons) e as imagens de fundo e título.
3. Abra o arquivo index.html em qualquer navegador moderno (Chrome, Firefox, Edge, Opera).
4. O jogo funcionará sem necessidade de servidor web.

Observação: todas as imagens e fontes devem estar nos caminhos corretos para a experiência completa. Caso alguma imagem não seja encontrada, o jogo ainda funcionará com fallbacks visuais.

Estrutura de arquivos essencial

/index.html
/font/
   DooM.ttf
   AmazDooMLeft.ttf
   AmazDooMRight.ttf
/img/
   doom-background.png
   doom-titulo.png
   doom-favicon.jpg
   /doom-avatar/
       doom-guy.png
       avatar.png
       face-player.jpg
       face-player(1).jpg
       face-player(2).jpg
       face-player(3).jpg
   /doom-enemys/
       enemy.png
   /doom-weapons/
       pistol.png
       shotgun.png
       chaingun.png
       RPG-7.png

Créditos

Inspirado no jogo DOOM (1993) da id Software.
Desenvolvido por [seu nome ou nickname] como projeto de estudo e entretenimento.
Fontes: DooM.ttf e AmazDooM criadas por fãs; Press Start 2P por Google Fonts.
Ícones: Font Awesome 7.

Este projeto é para fins educacionais e não comerciais. Todos os direitos sobre a marca e o universo DOOM pertencem à id Software / Bethesda Softworks.

Licença

O código deste projeto está sob a licença MIT. Os assets gráficos e fontes possuem licenças próprias e devem ser utilizados apenas em projetos pessoais sem fins lucrativos.
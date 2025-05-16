/*Música por <a href="https://pixabay.com/es/users/cyberwave-orchestra-23801316/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=249202">
Cyberwave Orchestra</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=249202">Pixabay</a>*/

//Saber coordenadas text(mouseX+" "+ mouseY, 200, 200);

import processing.sound.*;
SoundFile bgmusic, bsound, click;

int celdas = 8, tamaño=90, counter=0, mov=5, pointsp=0, time=0, lastTime=0, pantalla=0, intp=0, tiempoA = 2000, inicioA = 0;
PImage[][] mimg = new PImage[celdas][celdas];
ArrayList<PImage> images = new ArrayList<PImage>();
PImage img1, img2, img3, img4, img5, fondo, inicio, btn1, btn2, anun;
PFont font;
int[][] points = new int[10][10];
int[] intento = new int[10];
boolean pause=true, MostrarAnuncio = false;
String AnuncioJugador = "Jugador 1";

void setup() {
  fullScreen();
  
  //Cargar sonidos y música de fondo
  bgmusic = new SoundFile(this, "bgsoundW.wav");
  bsound = new SoundFile(this, "random2.wav");
  click = new SoundFile(this, "click.wav");
  
  bgmusic.loop();

  // Carga la imagen de fondo y las imágenes de dulces
  fondo = loadImage("bgJuego.jpeg");
  inicio = loadImage("fondo2.png");
  anun = loadImage("jugador.png");
  btn1= loadImage("bt0.png");
  btn2= loadImage("bt2.png");
  img1 = loadImage("chocolate-bar.png");
  img3 = loadImage("sweet2.png");
  img4 = loadImage("gummy-bear (1).png");
  img5 = loadImage("lollipop.png");
  
  //Pantalla
  //int pro_x = width;
  //int pro_y = height;

  // Añadimos las imágenes de dulces al ArrayList
  images.add(img1);
  images.add(img3);
  images.add(img4);
  images.add(img5);

  // se carga la fuente que se usará para los textos
  font = loadFont("VirtualDJ-35.vlw");

  //Subrutina para llenar la matriz
  matriz();
  llenarI();
}

void draw() {
  bgmusic.amp(0.15);
  int botonAncho = 400;  // Ancho del botón
  int botonAlto = 155;   // Alto del botón

  if (pantalla==0) {
    // Coordenadas centradas de los botones
    float botonX = (width - botonAncho) / 2;
    float botonInicioY = height * 0.41; // Posición vertical del primer botón (Inicio)
    float botonGuiaY = height * 0.54; // Posición vertical del segundo botón (Guía)
    float botonSalirY = height * 0.67;  // Posición vertical del tercer botón (Salir)
    image(inicio, 0, 0, width, height);  // Dibuja el fondo
    textSize(35);
    textFont(font);
    
    //Botón Inicio
    image(btn1, botonX, botonInicioY, botonAncho, botonAlto); 
    if ( (mouseX>=width*0.395 && mouseX<=(width*0.395+400) && mouseY>=height*0.44 && mouseY<=(height*0.44+90)) ) {
      fill(155);
    } else {
      fill(255);
    }
    text("INICIO", width*0.470, height*0.480);
    
    // Botón de Guía
    image(btn1, botonX, botonGuiaY, botonAncho, botonAlto); 
    if ( (mouseX>=width*0.395 && mouseX<=(width*0.395+300) && mouseY>=height*0.565 && mouseY<=(height*0.565+90)) ) {
      fill(155);
    } else {
      fill(255);
    }
    text("Guía", width*0.470, height*0.610);
    
    // Botón de Salir
    image(btn1, botonX, botonSalirY, botonAncho, botonAlto);  
    if ( (mouseX>=width*0.469 && mouseX<=(width*0.469+200) && mouseY>=height*0.695 && mouseY<=(height*0.695+90)) ) {
      fill(155);
    } else {
      fill(255);
    }
    text("Salir", width*0.469, height*0.740);
    //rect(width*0.395, height*0.695, 400, 90); //Salir
    
  } else if (pantalla==1) {
    botonAncho = 300;  // Ancho del botón
    botonAlto = 150;  //  Alto del botón
    float botonX = width * 0.73; //  Posición horizontal del primer botón (Inicio)
    float botonMenuY = height * 0.86; // Posición vertical del primer botón (Menú)
    float botonInicioY = height * 0.175; // Posición vertical del primer botón (Inicio)
    image(fondo, 0, 0, width, height);  // Dibuja el fondo
    //if (MostrarAnuncio && millis() - inicioA < tiempoA) {
      //image(anun, 1000, 1000, 300, 100);  
      //fill(255);
      //textAlign(CENTER, CENTER);
      //textSize(20);
      //println("Mostrando anuncio: " + AnuncioJugador);
      //text(AnuncioJugador, 150, 100);  
    //} else if (millis() - inicioA >= tiempoA) {
      //MostrarAnuncio = false;  // Desactiva el anuncio después del tiempo límite
      //println("Anuncio desactivado."); 
  //}
    stroke(255);
    strokeWeight(5);
    fill(254, 121, 152);
    
    image(btn2, botonX, botonInicioY, botonAncho, botonAlto);    // botón Inicio
    image(btn2, botonX, botonMenuY, botonAncho, botonAlto);    //botón Menú
    
    rect(width*0.75, height*0.4, 350, 90, 20); //Puntos
    rect(width*0.75, height*0.5, 400, 90, 20); //Movimientos
    rect(width*0.05, height*0.2, 430, 480, 20); //Puntaje total
    rect(width*0.4, height*0.05, 400, 90, 20); //Tiempo
    fill(255);
    textFont(font);
    for(int i=0; i<3; i++){
      line(width*0.05, height*(0.3+(0.1*i)), 525, height*(0.3+(0.1*i)));
    }
    for (int i=0; i<4; i++) {
      textSize(20);
      text("Intentos: "+intento[i]+" /3", width*0.06, height*(0.28+(0.1*i)));
      textSize(35);
      text("Puntaje "+(i+1)+": "+points[i][3], width*0.06, height*(0.25+(0.1*i)));
    }
    text("Tiempo: "+time+" seg", width*0.415, height*0.1);
    text("Puntos: "+counter, width*0.75+(width*0.005), (height*0.4)+(height*0.05));
    text("Movimientos: "+mov, width*0.75+(width*0.005), (height*0.5)+(height*0.05));
    //text("Reiniciar", width*0.737+(width*0.025), (height*0.6)+(height*0.05));
    text("Menú", width*0.75+(width*0.025), (height*0.88)+(height*0.05));
    if (pause) {
      text("Iniciar", width*0.745+(width*0.025), (height*0.2)+(height*0.044));
    } else {
      text("Pausar", width*0.737+(width*0.025), (height*0.2)+(height*0.044));
    }
    
    //Contador de tiempo
    if (!pause && millis() - lastTime >= 1000) {
      time++;
      lastTime = millis();
      if (time>15) {
        time = 0;
        reiniciar();
      }
      if(!pause){
        parpadeo();
      }
    }
    drawmatriz();  //Matriz de dulces
    
  }
  
}
void parpadeo(){
  int intervalo = 100;
  int lastTime2 = 0;
  boolean blinking = false;
  int tiempoA = millis(), i=pointsp;
  if (tiempoA - lastTime2 > intervalo) {
    blinking = !blinking;
    lastTime2 = tiempoA;
  }
  if (blinking) {
    fill(254, 121, 152);
  } else {
    fill(255);
  }
  textSize(35);
  text("Puntaje "+(i+1)+": ", width*0.06, height*(0.25+(0.1*i)));
}

void matriz() {
  // Llena la matriz con imágenes de dulces aleatorios
  for (int i = 0; i < celdas; i++) {
    for (int j = 0; j < celdas; j++) {
      mimg[i][j] = images.get(int(random(images.size())));
    }
  }
}

void drawmatriz() {
  // Calcula el punto de inicio para centrar la matriz de dulces
  float offsetX = (width - (celdas * tamaño)) / 2;
  float offsetY = (height - (celdas * tamaño)) / 2;

  for (int i = 0; i < celdas; i++) {
    for (int j = 0; j < celdas; j++) {
      // Fondo translúcido para cada celda
      strokeWeight(1);
      fill(150, 150, 200, 100);  // Color gris azulado con transparencia
      rect(offsetX + j * tamaño, offsetY + i * tamaño, tamaño, tamaño, 20);

      // Dibuja cada dulce en el centro de su celda, un poco más pequeño que el tamaño de la celda
      if (mimg[i][j] != null) {
        float imgSize = tamaño * 0.8;  // Tamaño del dulce ajustado
        float xPos = offsetX + j * tamaño + (tamaño - imgSize) / 2;
        float yPos = offsetY + i * tamaño + (tamaño - imgSize) / 2;
        image(mimg[i][j], xPos, yPos, imgSize, imgSize);
      }
    }
  }
}

// Nueva función para obtener el índice de la imagen en `images` para comparar
int getImageIndex(PImage img) {
  for (int i = 0; i < images.size(); i++) {
    if (images.get(i) == img) {
      return i;
    }
  }
  return -1;  // Retorna -1 si no se encuentra
}

void explotar(int i, int j, PImage selectedImage) {
  int targetIndex = getImageIndex(selectedImage);  // Índice de la imagen seleccionada
  ArrayList<int[]> eliminar = new ArrayList<int[]>();
  eliminar.add(new int[] {i, j});

  while (eliminar.size() > 0) {
    int[] pos = eliminar.remove(0);
    int x = pos[0];
    int y = pos[1];

    if (mimg[x][y] != null && getImageIndex(mimg[x][y]) == targetIndex) {
      mimg[x][y] = null;  // Elimina el dulce actual

      // Condiciones para explotar los dulces adyacentes que se parezcan al seleccionado
      if (x > 0 && mimg[x - 1][y] != null && getImageIndex(mimg[x - 1][y]) == targetIndex) {
        eliminar.add(new int[] {x - 1, y});
        counterR();
      }
      if (x < celdas - 1 && mimg[x + 1][y] != null && getImageIndex(mimg[x + 1][y]) == targetIndex) {
        eliminar.add(new int[] {x + 1, y});
        counterR();
      }
      if (y > 0 && mimg[x][y - 1] != null && getImageIndex(mimg[x][y - 1]) == targetIndex) {
        eliminar.add(new int[] {x, y - 1});
        counterR();
      }
      if (y < celdas - 1 && mimg[x][y + 1] != null && getImageIndex(mimg[x][y + 1]) == targetIndex) {
        eliminar.add(new int[] {x, y + 1});
        counterR();
      }
    }
  }
}

void counterR() {
  counter=counter+10;
}

void puntaje() {
  points[pointsp][intp]=counter;
  
  for(int i=0; i<3; i++){
   points[pointsp][3] += points[pointsp][i];
  }
  
  intento[intp] -=1;
  //println("Intentos restantes para el jugador " + (pointsp + 1) + ": " + intento[intp]);
  if (intento[intp]==0) {
    pause=true;
    intp += 1;
    pointsp+=1;
    //AnuncioJugador = "Juagdor" + (pointsp + 1); // Mensaje del siguiente jugador
    //MostrarAnuncio = true;      
    //println("Mostrando anuncio para: " + AnuncioJugador); ///njjhnihit
    //inicioA = millis();    // Guarda el tiempo actual
    if(pointsp>3){
      pointsp=0;
      llenarI();
    }
  }
  
}
void llenarI(){
  for(int i=0; i<5; i++){
    intento[i]=3;
  }
}

void reiniciar() {
  time=0;
  puntaje();
  mov=5;
  counter=0;
  matriz();
  drawmatriz();
}

void mousePressed() {
  if (pantalla==1 && mouseX>=width*0.73 && mouseX<=(width*0.73+300) && mouseY>=height*0.2 && mouseY<=(height*0.2+90)) { //Inicio
    if (pause) {
      pause=false;
      click.play();
    } else {
      pause=true;
      click.play();
    }
  }
  if (pantalla==0  && mouseX>=width*0.395 && mouseX<=(width*0.395+400) && mouseY>=height*0.44 && mouseY<=(height*0.44+90)) {
    pantalla++;
    click.play();
  }//rect(width*0.395, height*0.44, 400, 90); //Inicio
  if (pantalla==0  && mouseX>=width*0.395 && mouseX<=(width*0.395+400) && mouseY>=height*0.695 && mouseY<=(height*0.695+90)) {
    System.exit(0);
    click.play();
  }//rect(width*0.395, height*0.695, 400, 90); //Salir
  if (pantalla==1  && mouseX>=width*0.73 && mouseX<=(width*0.73+300) && mouseY>=height*0.88 && mouseY<=(height*0.88+97)) { //Menú
    pantalla=0;
    pause=true;
    click.play();
    //rect(width*0.73, height*0.88, 300, 97);
  }

  // Calcula la posición dentro de la matriz basado en el clic del mouse
  float offsetX = (width - (celdas * tamaño)) / 2;
  float offsetY = (height - (celdas * tamaño)) / 2;
  int j = int((mouseX - offsetX) / tamaño);
  int i = int((mouseY - offsetY) / tamaño);

  // Condición cuando el usuario da click a un dulce dentro de los límites de la matriz
  if (!pause && mov>0 && i >= 0 && i < celdas && j >= 0 && j < celdas) {
    PImage selectedImage = mimg[i][j];
    if (selectedImage != null) {
      explotar(i, j, selectedImage);
      bsound.play();
      counterR();
      mov=mov-1;
      if (mov<1) {
        reiniciar();
      }
    }
  }
}

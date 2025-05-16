/*Música por <a href="https://pixabay.com/es/users/cyberwave-orchestra-23801316/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=249202">
Cyberwave Orchestra</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=249202">Pixabay</a>*/
import processing.sound.*;
SoundFile bgmusic;
SoundFile bsound;


int celdas = 8, tamaño=90, counter=0, mov=5, pointsp=0, time=0, lastTime=0, pantalla=0, intp=0;
PImage[][] mimg = new PImage[celdas][celdas];
ArrayList<PImage> images = new ArrayList<PImage>();
PImage img1, img2, img3, img4, img5, fondo, inicio, boton0, boton1;
PFont font;
int[][] points = new int[10][10];
int[] intento = new int[10];
boolean pause=true;

void setup() {
  fullScreen();
  
  //Cargar sonidos y música de fondo
  bgmusic = new SoundFile(this, "bgsoundW.wav");
  bsound = new SoundFile(this, "random2.wav");
  bgmusic.amp(0.0);
  bgmusic.loop();

  // Carga la imagen de fondo y las imágenes de dulces
  fondo = loadImage("bgJuego.jpeg");
  inicio = loadImage("fondoo.png");
  img1 = loadImage("chocolate-bar.png");
  img3 = loadImage("sweet.png");
  img4 = loadImage("gummy-bear (1).png");
  img5 = loadImage("lollipop.png");
  boton0 = loadImage("botonp0.png");
  boton1 = loadImage("botonp2.png");

  // Añadimos las imágenes de dulces al ArrayList
  images.add(img1);
  images.add(img3);
  images.add(img4);
  images.add(img5);

  // se carga la fuente que se usará para los textos
  font = loadFont("VirtualDJ-35.vlw");

  // Inicializar la matriz de puntajes a 0
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      points[i][j] = 0;  // Asignar valor 0 a todos los puntajes
    }
  }

  // Inicializar intentos a 0 (puedes cambiarlo según el caso)
  for (int i = 0; i < 10; i++) {
    intento[i] = 0;  // Asignar valor 0 a los intentos
  }

  // Subrutinas para llenar la matriz y otros elementos
  matriz();
  llenarI();
}

void draw() {
  if (pantalla == 0) {
    image(inicio, 0, 0, width, height);  // Fondo de inicio

    int botonAncho = 450;  // Ancho del botón
    int botonAlto = 250;   // Alto del botón

    // Coordenadas centradas de los botones
    float botonX = (width - botonAncho) / 2;
    float botonInicioY = height * 0.4; // Posición vertical del primer botón (Inicio)
    float botonGuiaY = height * 0.53;  // Posición vertical del segundo botón (Guía)
    float botonSalirY = height * 0.66;  // Posición vertical del tercer botón (Salir)

    // Dibuja los botones con la imagen boton0
    image(boton0, botonX, botonInicioY, botonAncho, botonAlto); // Botón de Inicio
    image(boton0, botonX, botonGuiaY, botonAncho, botonAlto);   // Botón de Guía
    image(boton0, botonX, botonSalirY, botonAncho, botonAlto);  // Botón de Salir

    // Configuración de la fuente y tamaño de texto
    textSize(50);
    textFont(font);
    textAlign(CENTER, CENTER);  // Centra el texto en ambas direcciones

    // Dibuja el texto centrado en cada botón y cambia el color al hacer hover
    fill((mouseX >= botonX && mouseX <= botonX + botonAncho && mouseY >= botonInicioY && mouseY <= botonInicioY + botonAlto) ? 50 : 0);
    text("Iniciar", botonX + botonAncho / 2, botonInicioY + botonAlto / 2);

    fill((mouseX >= botonX && mouseX <= botonX + botonAncho && mouseY >= botonGuiaY && mouseY <= botonGuiaY + botonAlto) ? 50 : 0);
    text("Guía", botonX + botonAncho / 2, botonGuiaY + botonAlto / 2);

    fill((mouseX >= botonX && mouseX <= botonX + botonAncho && mouseY >= botonSalirY && mouseY <= botonSalirY + botonAlto) ? 50 : 0);
    text("Salir", botonX + botonAncho / 2, botonSalirY + botonAlto / 2);
  } 
  else if (pantalla == 1) {
      image(fondo, 0, 0, width, height);  // Dibuja el fondo
      //Recuadros de información y botones
      stroke(255);
      strokeWeight(5);
      
      drawmatriz();
    }
  }


void parpadeo(){
  int intervalo = 100; // Interval in milliseconds
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
   points[pointsp][3]= points[pointsp][3] + points[pointsp][i];
  }
  intento[intp]=intento[intp]-1;
  if (intento[intp]<1) {
    intp=intp+1;
    pointsp=pointsp+1;
    if(pointsp>4){
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
  if (mov<1 && mouseX>=width*0.8 && mouseX<=(width*0.8+260) && mouseY>=height*0.6 && mouseY<=(height*0.6+100)) {
    reiniciar();
  }
  if (mouseX>=width*0.75 && mouseX<=(width*0.75+200) && mouseY>=height*0.2 && mouseY<=(height*0.2+90)) {
    if (pause) {
      pause=false;
    } else {
      pause=true;
    }
  }
  if (pantalla == 0 && mouseX >= width * 0.4 && mouseX <= (width * 0.4 + 400) && mouseY >= height * 0.5 && mouseY <= (height * 0.5 + 90)) { 
    pantalla++; //Inicio pasa a la del juego
  }
  if (pantalla == 0 && mouseX >= width * 0.45 && mouseX <= (width * 0.45 + 200) && mouseY >= height * 0.7 && mouseY <= (height * 0.7 + 90)) {
    System.exit(0);  // Cierra el programa
  }
  if (pantalla == 1 && mouseX >= width * 0.775 && mouseX <= (width * 0.775 + 170) && mouseY >= height * 0.9 && mouseY <= (height * 0.9 + 90)) {
    pantalla = 0;  // Regresa a la pantalla de inicio
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

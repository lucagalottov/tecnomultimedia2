/* Trabajo Práctico 2
 Juana Peroné, Gustavo Perugini y Luca Galotto Viganoni
 Tecnología Multimedial 1
 FdA UNLP 2020
 */

import tsps.*;
import fisica.*;
import processing.sound.*;

SoundFile win, lose, normal, liviana, pesada, musica;
TSPS TodasLasPersonas;

FWorld mundo;
FBox paleta;
FBox terminar;

PImage back, inicio, perder, paletaImg, agujero, ganaste, verde, rosa, blanca, barraCorta, barraLarga;

int estado;

FMouseJoint cadena;

String bola;
long tiempo;

int golpes = 0;
int golpes2 = 0;

float ang = 0;

int max = 6;
int imageIndex = 0;
boolean pegar = false;
PImage [] images = new PImage[max];

FCircle b;
FCircle b2;
FCircle b3;

FCircle test;

FBox caja;
FBox caja2;

void setup()
{
  size( 1080, 1080 );

  back = loadImage( "back.png" );
  inicio = loadImage( "falling-portada1.png" );
  perder = loadImage( "falling-portada.png" );
  paletaImg = loadImage("paleta.png");
  agujero = loadImage("agujeroNegro.png");
  ganaste = loadImage("ganaste.png");
  verde = loadImage("verde.png");
  rosa = loadImage("rosa.png");
  blanca = loadImage("blanca.png");
  barraCorta = loadImage("barraCorta.jpg");
  barraLarga = loadImage("barraLarga.jpg");
  for ( int i = 0; i < images.length; i++) {
    images[i] = loadImage(i+".png");
  }


  Fisica.init( this );
  TodasLasPersonas = new TSPS(this, 12000);
  estado = 0;

  win = new SoundFile(this, "ganar.wav");
  lose = new SoundFile(this, "perder.wav");
  normal = new SoundFile(this, "normal.wav");
  liviana = new SoundFile(this, "liviana.wav");
  pesada = new SoundFile(this, "pesada.wav");
  musica = new SoundFile(this, "musica.mp3");
  musica.loop();

  noCursor();

  mundo = new FWorld();
  mundo.setEdges();
  mundo.remove(mundo.bottom);
  mundo.setGravity(0, 650);

  terminar = new FBox(width+200, 25);
  terminar.setPosition(width/2, height+30);
  terminar.setStatic(true);
  terminar.setName("perder");
  mundo.add(terminar);

  paleta = new FBox(200, 20);
  paleta.setFillColor(255);
  paleta.setNoStroke();
  noStroke();
  paleta.setRotatable(false);
  paleta.setPosition(width / 2, height / 2);
  paleta.setFriction(300);
  paleta.setDensity(0.3);
  paleta.setRestitution(0.3);
  paleta.setName("paleta");
  paleta.attachImage(paletaImg);
  mundo.add(paleta);

  cadena = new FMouseJoint(paleta, width / 2, height / 2);
  cadena.setFrequency(4000000);
  mundo.add(cadena);

  b = new FCircle(30);
  b.attachImage(blanca);
  b.setVelocity(0, 200);
  b.setRestitution(0.7);
  b.setNoStroke();
  b.setFill(255);
  b.setName("bola");
  b.setPosition(width/2, 50);

  b2 = new FCircle(40);
  b2.setPosition(random(300, width-300), 50);
  b2.setVelocity(0, 400);
  b2.attachImage(rosa);
  b2.setRestitution(0.4);
  b2.setDensity(0.4);
  b2.setNoStroke();
  b2.setFill(255, 70, 100);
  b2.setName("bola2");

  b3 = new FCircle(25);
  b3.setPosition(random(30, width-30), 50);
  b3.setVelocity(0, 50);
  b3.setRestitution(0.8);
  b3.attachImage(verde);
  b3.setDensity(0.8);
  b3.setNoStroke();
  b3.setFill(70, 255, 70);
  b3.setName("bola3");
  b3.attachImage(verde);

  caja = new FBox(350, 25);
  caja.setRotation(35);
  caja.setFill(255);
  caja.setStatic(true);
  caja.setPosition(0, 500);
  caja.attachImage(barraCorta);

  caja2 = new FBox(550, 25);
  caja2.setRotation(-35);
  caja2.setFill(255);
  caja2.setStatic(true);
  caja2.setPosition(width, 200);
  caja2.attachImage(barraLarga);

}

void draw() {


  if  ( estado == 0 ) {
    background(inicio);
  } else if ( estado == 1 ) {

    background(back); 

    //--- AGUJERO NEGRO
    if (golpes >= 20) {
      ang = ang+0.1;
      pushMatrix();
      pushStyle();
      imageMode(CENTER);
      translate(400, height/4);
      rotate(ang);
      image(agujero, 0, 0);
      atraer();
      popStyle();
      popMatrix();
    } 

    if (millis() >= tiempo+2000) {
      pushStyle();
      //---------------- BOLA NORMAL
      mundo.add(b);
      tiempo = 8000000;
      popStyle();
    }  

    if (golpes2 == 5) {
      pushStyle();
      //---------------- BOLA PESADA
      mundo.add(b2);
      golpes2++;
      popStyle();
    } 

    //println(golpes2);
    //---------------- BOLA LIVIANA
    if (golpes2 == 26) {
      pushStyle();
      mundo.add(b3);
      golpes2++;
      popStyle();
    } 

    //--- OBSTÁCULOS
    if (golpes2 == 13) {
      mundo.add(caja);
      mundo.add(caja2);
      golpes2++;
    }

   

    //--- PUNTAJE
    pushStyle();
    textSize(185);
    fill(255, 50);
    textAlign(CENTER);
    text(golpes, width/2, height/2);
    popStyle();

    TSPSPerson[] ArrayPersonas = TodasLasPersonas.getPeopleArray();
    
    for(int i =0; i <ArrayPersonas.length; i++){
     float Centroidx = ArrayPersonas[i].centroid.x*width;
     float Centroidy = ArrayPersonas[i].centroid.y*height;
     
    // imageMode(CENTER);
     //image(paletaImg, Centroidx, Centroidy);
     cadena.setTarget(Centroidx, Centroidy-20);
     
      //--- ANIMACIÓN
    if (pegar) {
      paleta.dettachImage();

      pushStyle();    
      imageMode(CENTER);
      image(images[imageIndex], Centroidx, Centroidy);
      imageIndex = (imageIndex+1) % images.length;

      if (imageIndex == images.length-1) {
        pegar = false;
        paleta.attachImage(paletaImg);
      }

      popStyle();
    }
     } 

   // cadena.setTarget(mouseX, mouseY); 
    mundo.step();
    mundo.draw();
  }

  //--- GANAR

  if (golpes == 30) {
    estado = 3; 
    win.play();
    golpes++;
  }

  if (estado == 3) {
    background(ganaste);
  }

  //--- PERDER
  if (estado == 2) {
    background(perder);
  }
}
void keyPressed() {

  if ( key == ENTER ) if  ( estado == 0 ) { 
    estado = estado + 1;
    tiempo = millis();
  }

  if ( key == ' ' ) if  ( estado == 2 || estado ==3 ) { 
    estado = 0;
    golpes = 0;
    golpes2 = 0;
    mundo.remove(b);
    mundo.remove(b2);
    mundo.remove(b3);
    mundo.remove(caja);
    mundo.remove(caja2);
    golpes = 0;
    golpes2 = 0;
  }
} 

void contactStarted(FContact contacto) {

  FBody cuerpo1 = contacto.getBody1();
  FBody cuerpo2 = contacto.getBody2();

  String nombre1 = conseguirNombre(cuerpo1); 
  String nombre2 = conseguirNombre(cuerpo2);

  colision("bola", nombre1, nombre2);
  colision("bola2", nombre1, nombre2);
  colision("bola3", nombre1, nombre2);
  perder("bola", nombre1, nombre2);
  perder("bola2", nombre1, nombre2);
  perder("bola3", nombre1, nombre2);

  if (nombre1 == "paleta" && nombre2 == "bola") {
    normal.play();
  }
  if (nombre2 == "paleta" && nombre1 == "bola") {
    normal.play();
  }

  if (nombre1 == "paleta" && nombre2 == "bola2") {
    pesada.play();
  }
  if (nombre2 == "paleta" && nombre1 == "bola2") {
    pesada.play();
  }

  if (nombre1 == "paleta" && nombre2 == "bola3") {
    liviana.play();
  }
  if (nombre2 == "paleta" && nombre1 == "bola3") {
    liviana.play();
  }
} 

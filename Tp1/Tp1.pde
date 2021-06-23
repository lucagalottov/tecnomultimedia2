/* Trabajo Práctico 1
 Juana Peroné, Gustavo Perugini y Luca Galotto Viganoni
 Tecnología Multimedial 1
 FdA UNLP 2020
 */


import oscP5.*;

//----CALIBRAR-----

float minimoAmp = 55;
float maximoAmp= 90;
float f = 0.9;

float umbralTiempo1 = 700;
float umbralTiempo2 = 400;
float borrar = 2000;
//-----------------

boolean haySonido = false;
boolean antesHabiaSonido = false; 

long marcaTiempo;

GestorSenial gestorAmp;

OscP5 osc;

float amp, pitch;

Capa c, d, b;

void setup() {
  size(600, 600);

  colorMode(HSB, 360, 100, 100);
  background(random(360), 70, 100);

  gestorAmp = new GestorSenial(minimoAmp, maximoAmp, f);
  osc = new OscP5(this, 12345);

  c = new Capa();
  d = new Capa();
  b = new Capa();
}

void draw() {



  haySonido = amp> minimoAmp;
  gestorAmp.actualizar(amp);

  boolean empezoElSonido = haySonido && !antesHabiaSonido;
  boolean terminoElSonido = !haySonido && antesHabiaSonido;


  if (empezoElSonido) {
    marcaTiempo = millis();
    d.manchas();
    d.dibujarManchas();
  }


  if (terminoElSonido) {

    if (millis() < marcaTiempo + umbralTiempo2) {
      if (pitch > 84) {
        c.trazo5();
      } else {
        c.trazo6();
      }
    }
  } 

  if (terminoElSonido) {
    if (millis() < marcaTiempo + umbralTiempo1 && millis() > marcaTiempo + umbralTiempo2) {
      if (pitch > 84) {
        c.trazo2();
      } else {
        c.trazo3();
      }
    }
  }

  if (terminoElSonido) {
    if (millis() > marcaTiempo + umbralTiempo1 && millis() < marcaTiempo + borrar) {
      if (pitch > 84) {
        c.trazo1();
      } else {
        c.trazo4();
      }
    }
  }

/*
  if (terminoElSonido) {
    if (millis() > marcaTiempo + borrar) {
      d.borrar();
      c.borrar();
    }
  } */

  d.dibujar();
  c.dibujar();


  antesHabiaSonido = haySonido;
}

void oscEvent(OscMessage m ) {

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    println("pitch:"+pitch);
  }

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();
    println("amp:" + amp);
  }
}

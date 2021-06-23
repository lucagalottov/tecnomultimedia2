class Capa {
  PGraphics grafico;
  PImage trazo[], mancha[];
  boolean dManchas = true;

  Capa() {
    grafico = createGraphics( width, height );
    imageMode(CENTER);
    trazo = new PImage [ 6 ];
    mancha = new PImage [6];
    for ( int i =0; i< trazo.length; i++) {
      trazo[i]= loadImage (i+".png");
      trazo[i].resize(200, 200);
    }
    for ( int i =0; i< mancha.length; i++) {
      mancha[i]= loadImage ("mancha"+i+".png");
      mancha[i].resize(600, 600);
    }
  }


  void dibujarManchas() {
    dManchas = !dManchas;
  }

  void manchas() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    if (dManchas) {
      grafico.image(mancha[int(random(0, 5))], random( width), random( height));
    }
    grafico.endDraw();
  }

  void trazo1() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[0], random( width), random( height));
    grafico.image(trazo[0], random( width), random( height));
    grafico.image(trazo[0], random( width), random( height));
    grafico.endDraw();
  }
  void trazo2() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[1], random( width), random( height));
    grafico.image(trazo[1], random( width), random( height));
    grafico.image(trazo[1], random( width), random( height));
    grafico.endDraw();
  }
  void trazo3() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[2], random( width), random( height));
    grafico.image(trazo[2], random( width), random( height));
    grafico.image(trazo[2], random( width), random( height));
    grafico.endDraw();
  }
  void trazo4() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[3], random( width), random( height));
    grafico.image(trazo[3], random( width), random( height));
    grafico.image(trazo[3], random( width), random( height));
    grafico.endDraw();
  }

  void trazo5() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[4], random( width), random( height));
    grafico.image(trazo[4], random( width), random( height));
    grafico.image(trazo[4], random( width), random( height));
    grafico.endDraw();
  }

  void trazo6() {
    grafico.beginDraw();
    grafico.imageMode(CENTER);
    grafico.image(trazo[5], random( width), random( height));
    grafico.image(trazo[5], random( width), random( height));
    grafico.image(trazo[5], random( width), random( height));
    grafico.endDraw();
  }

/*
  void borrar() {
    grafico.beginDraw();  
    grafico.clear();
    grafico.endDraw();
  } */

  void dibujar() {
    image( grafico, width/2, height/2 );
  }
}

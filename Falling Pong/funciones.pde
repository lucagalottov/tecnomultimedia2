String conseguirNombre(FBody cuerpo) {
  String nombre = "nada";

  if (cuerpo != null) {
    nombre = cuerpo.getName();

    if (nombre == null) {
      nombre = "nada";
    }
  }
  return nombre;
}

void colision(String nombre, String nombre1, String nombre2) {
  if (nombre1 == "paleta" && nombre2 == nombre) {
    golpes++;
    golpes2++;
    pegar = true;
  }

  if (nombre2 == "paleta" && nombre1 == nombre) {
    golpes++;
    golpes2++;
    pegar = true;
  }
}

void perder(String nombre, String nombre1, String nombre2) {
  if (nombre1 == nombre && nombre2 == "perder") {
    estado = 2;
    lose.play();

  }
  if (nombre2 == nombre && nombre1 == "perder") { 
    estado = 2;
    lose.play();
  }
} 


void atraer() {

  ArrayList<FBody> cuerpos = mundo.getBodies();
  for (FBody cuerpo : cuerpos) {
    float dx = 400 - cuerpo.getX();
    float dy = height/4 - cuerpo.getY();

    if (dist(400, height/4, cuerpo.getX(), cuerpo.getY()) < 250) {
      cuerpo.addForce(dx*4, dy*4);
    }
  }
} 

class Palo {

  int[] ritmos;
  AudioSample base, acento;
  String nombre;
  
  Palo(String nombre, int[] secuencia, AudioSample base, AudioSample acento) {
    this.nombre = nombre;
    ritmos = secuencia;
    this.base = base;
    this.acento = acento;
  }
  
  Palo(String nombre, int[] secuencia) {
    this(nombre, secuencia, boom[0], boom[1]);
  }
  
  
  void sequenza() {

    if (passedTime  > baseTime/xQuantoDividoTempo[livello][indiceCount - 1]) {
      if (!in_array(ritmos, indiceCount)) {
        if ( base != null) {
          base.trigger();
        }
      }
      else {
        if (acento != null) {
          acento.trigger();
        }
      }
//colorVerde=!colorVerde;
      savedTime = millis();
    }
  
  }
  
  boolean tieneAcento(int tic) {
    return in_array(ritmos, tic);
  }
}


/*+++++++++++++++++++++++++++++++++SLIDERS*/
import controlP5.*;
ControlP5 controlP5;

//++++++++++++++++++++++++++++

import ddf.minim.*;

Minim minim;
int numeroSuoni=2;
AudioSample[] boom= new AudioSample[numeroSuoni]; 

int compases = 0;
int success = 0;

String[] sampleFilenames= {
 "low.wav",  "acento.wav",
};

int START = 0, GAME = 1, SCORE = 2;
int stage = 0;

int GAME_DURATION = 35000;
int baseTime = 500;  
float millisCounting, t0;
int indiceCount;
int maxindiceCount=12;

int[] tangos_angel = {4,8,12},
      tangos_antonio = {1, 5, 9},
      sighirilla = {1, 3, 5, 8, 11},
      buleria = {3, 6, 7, 8, 10, 12}; 
      

int livello;
float [] []xQuantoDividoTempo={
  {
   1,1,1,1,1,1,1,1,1,1,1,1 
  }  
  ,
    {
 2,2,2,2,2,2,2,2,2
  },
  {
   3,1,1,3,3,1,3,1
  
  },
 {
   4,1,4,1,1,1,1,2,1

  }
};
float savedTime;
float passedTime;

color izq, der;
color beatNull, beatFail, beatOK, beatWait, beat;
boolean colorVerde=true;

float tamIzq, tamDer, TAM_GRANDE = 50, TAM_PEQ = 30;

PImage splash, score;

int livelliDifficoltaRitmi=1;

PImage avatar_hombre, avatar_mujer, avatar_hombre_start, avatar_mujer_start, startButton, anajarro;

Palo[] palos;

void setup() {

  size(842, 596);
  background(255);
  indiceCount=1;
  smooth();
  savedTime = millis();
  
  beatNull = color(80);
  beatFail = color(255, 0, 0);
  beatOK = color(0);
  beatWait = color(255);

  PFont myTempFont = createFont("Verdana-Bold", 100);
  textFont(myTempFont, 20);
  splash = loadImage("foto4.jpg");
  splash.resize(width, height);

  controlP5 = new ControlP5(this);
  controlP5.addSlider(" baseTime [100/2000]", 100, 2000, baseTime, width-220, height-50, 150, 15).setId(1);

  stage = START;

  minim=new Minim(this);
  for (int sampleIndex=0; sampleIndex < boom.length; sampleIndex++) {
    //println("Loading: " + sampleFilenames[sampleIndex % sampleFilenames.length]);
    boom[sampleIndex] = minim.loadSample(sampleFilenames[sampleIndex % sampleFilenames.length]);
  }
  
  palos = new Palo[3];
  palos[0] = new Palo("TANGOS", tangos_angel);
  palos[1] = new Palo("BULERÍAS-SOLEÁ", buleria);
  palos[2] = new Palo("SEGUIRIYAS", sighirilla, null, boom[1]);
  
  startButton = loadImage("jugar_clic_03.png");
  startButton.resize(startButton.width / 4, 0);
  avatar_hombre_start = loadImage("ABATAR_HOMBRE_2.png");
  avatar_mujer_start = loadImage("ABATAR_MUJER_2.png");
    avatar_hombre = loadImage("ABATAR_HOMBRE_3.png");
  avatar_mujer = loadImage("ABATAR_MUJER_3.png");
  avatar_hombre.resize(0, floor(.8 * height));
  avatar_mujer.resize(0, floor(.8 * height));
    avatar_hombre_start.resize(0, floor(.8 * height));
  avatar_mujer_start.resize(0, floor(.8 * height));
  anajarro = loadImage("anajarro.png");
  anajarro.resize(0, floor(height * .9));
  score = loadImage("score2.png");
  score.resize(floor(score.width * .75), 0);
}


void draw() {
  
    fill(244);
  textSize(15);
  textAlign(CENTER);
  if (stage == SCORE) {
      consejo(splash, anajarro, score);
      //image(startButton, width * .5 - startButton.width * .5, 40);
//      text("CLICK TO START", width/2, 40);
  }
  else if (stage == START) {
    background(splash);
  //background(200);

  tint(255, 255);
  image(avatar_hombre_start, .05 * width, .1 * height);
  image(avatar_mujer_start, .95 * width - avatar_mujer.width, .12 * height);
    image(startButton, width * .5 - startButton.width * .5, 40);
  }
  else {
    background(splash);
  //background(200);
    tint(255, 50);
  image(avatar_hombre, .05 * width, .1 * height);
  image(avatar_mujer, .95 * width - avatar_mujer.width, .12 * height);
  tint(23, 203, 135, 255);
  proportionalImage(avatar_hombre, .05 * width, .1 * height, success, 24);
  proportionalImage(avatar_mujer, .95 * width - avatar_mujer.width, .12 * height, success, 24);
 fill(255);
  text("DANCING WITH THE BNE", width/2, 40);
  textSize(12);
  text("Nivel " + (livelliDifficoltaRitmi + 1) + ": " + palos[livelliDifficoltaRitmi].nombre , width * .5, 70);
  float t=millis();
  passedTime = t - savedTime;


       fill(izq);
       if ((in_array(palos[livelliDifficoltaRitmi].ritmos, indiceCount) ? palos[livelliDifficoltaRitmi].acento : palos[livelliDifficoltaRitmi].base) != null)
ellipse(width/2,height * .6,tamIzq + 50 ,tamIzq + 50);
//fill(der);
//ellipse(width/2,height/2,tamDer +50, tamDer + 50);

  if (t - millisCounting > baseTime) {
    indiceCount+=1;
    beat = beatNull;
    if (indiceCount>maxindiceCount) {
      compases++;
      indiceCount=1;
    }


    millisCounting=t;
  }

  if(colorVerde==true){
    izq=beat;
    der=beatWait;
    tamIzq = palos[livelliDifficoltaRitmi].tieneAcento(indiceCount) ? TAM_GRANDE : TAM_PEQ;
    tamDer = TAM_PEQ;
  }
  else{
    izq=beatWait;
    der=beat; 
    tamIzq = TAM_PEQ;
    tamDer =  palos[livelliDifficoltaRitmi].tieneAcento(indiceCount) ? TAM_GRANDE : TAM_PEQ;
  }
  
  iniziaSezioniStates();  
  fill(255);
      text((t- t0) + " / " + GAME_DURATION, width/2, 490);

  if (t-t0 > GAME_DURATION) {
    stage = SCORE;

  }
  }
}


void iniziaSezioniStates() {

  palos[livelliDifficoltaRitmi].sequenza();

}


void keyPressed(){
  /*
  
  if(key=='1'){
    livello=0;
    
  }
   if(key=='2'){
    livello=1;
    
  }
   if(key=='3'){
    livello=2;
    
  }
  if(key=='4'){
    livello=3;
    
  }
  if(key=='m'){
  livello=(livello+1)%4;
  }
  
  */
}





void keyReleased() {




  

  if(key=='1'){
      livelliDifficoltaRitmi=0;
      iniziaSezioniStates();
  }
    if(key=='2'){
     livelliDifficoltaRitmi=1;
       iniziaSezioniStates();
  }
    if(key=='3'){
     livelliDifficoltaRitmi=2;
     iniziaSezioniStates();
  }

}




void mousePressed(){
  if (stage == START) {
    stage = GAME;
    t0 = millis();
    success = 0;
  }
  else if (stage == SCORE) {
    stage = START;
    println(compases);
  }
  else {
  if (palos[livelliDifficoltaRitmi].tieneAcento(indiceCount)) {
    beat = beatOK;
    success++;
  }
  else {
    beat = beatFail;
  }
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  for (int sampleIndex=0; sampleIndex < boom.length; sampleIndex++) {
    boom[sampleIndex].close();
  }
  

  minim.stop();

  super.stop();
}
void controlEvent(ControlEvent theEvent) {

  switch(theEvent.controller().id()) {

    case(1):
    /* controller numberbox1 with id 1 */
    baseTime = (int)(theEvent.controller().value());
    break;
  }
}

void proportionalImage(PImage img, float x, float y, int success, int levels) {
    float proportionalHeight = map(success, 0, levels, 0, img.height);
    image(
    img.get(
      0, 
      floor(img.height - proportionalHeight),
      img.width, 
      floor(proportionalHeight)
    ),
    x,
    y + img.height - proportionalHeight
  );
}


boolean in_array(int[] a, int b) {
  for (int i = 0; i < a.length; i++) {
    if (a[i] == b) {
      return true;
    }
  }
  return false;
}

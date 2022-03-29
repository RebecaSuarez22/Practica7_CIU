import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

//Notas musicales en notación anglosajona
String [] notas={"C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5"};
int tecla = 0;
void setup(){
  size(700, 200);
  background(255);
  minim = new Minim(this);
  out = minim.getLineOut();
}


void draw(){
  drawPiano();
  println("X --> "+ mouseX);
  println("Y --> "+ mouseY);
  println(tecla);
}

void mousePressed(){
  if(mouseX < 40 && mouseY > 110) tecla = 0;
  if(mouseX > 20 && mouseX < 50 && mouseY < 110 ) tecla = 1;
  if(mouseX > 40 && mouseX < 90 && mouseY > 110) tecla = 2;
  if(mouseX > 90 && mouseX < 140) tecla = 4;
  if(mouseX > 80 && mouseX < 110 && mouseY < 110 ) tecla = 3;
  
  if(mouseX > 140 && mouseX < 190) tecla = 5;
  if(mouseX > 190 && mouseX < 240) tecla = 7;
  if(mouseX > 170 && mouseX < 200 && mouseY < 110 ) tecla = 6;  
  if(mouseX > 240 && mouseX < 290) tecla = 9;
  if(mouseX > 225 && mouseX < 255 && mouseY < 110 ) tecla = 8;
  if(mouseX > 290 && mouseX < 340) tecla = 11;
  if(mouseX > 280 && mouseX < 310 && mouseY < 110 ) tecla = 10;
  
  if(mouseX > 340 && mouseX < 390) tecla = 12;
  if(mouseX > 390 && mouseX < 440) tecla = 14;
  if(mouseX > 375 && mouseX < 405 && mouseY < 110 ) tecla = 13;
  if(mouseX > 440 && mouseX < 490) tecla = 16;
  if(mouseX > 430 && mouseX < 460 && mouseY < 110 ) tecla = 15;
  
  if(mouseX > 490 && mouseX < 540) tecla = 17;
  if(mouseX > 540 && mouseX < 590) tecla = 19;
  if(mouseX > 520 && mouseX < 550 && mouseY < 110 ) tecla = 18;
  if(mouseX > 590 && mouseX < 640) tecla = 21;
  if(mouseX > 575 && mouseX < 605 && mouseY < 110 ) tecla = 20;
  if(mouseX > 640 && mouseX < 690) tecla = 23;
  if(mouseX > 630 && mouseX < 660 && mouseY < 110 ) tecla = 22;
  
  if(mouseX > 690) tecla = 24;
  
  
  
  out.playNote( 0.0, 0.9, new SineInstrument( Frequency.ofPitch( notas[tecla] ).asHz())); 
}


void drawPiano(){
  //Dibujamos las celdas/teclas
  fill(0);
  for (int i=0;i<8;i++){
    line(i*100-10,0,i*100-10,200);
    line(i*100-60,0,i*100-60,200);
  }  
  
   rect(20,0,30,110);
   rect(80,0,30,110);
   
   rect(170,0,30,110);
   rect(225,0,30,110);
   rect(280,0,30,110);
   
   rect(375,0,30,110);
   rect(430,0,30,110);
   
   rect(520,0,30,110);
   rect(575,0,30,110);
   rect(630,0,30,110); 

}

// Clase que describe la interfaz del instrumento, idéntica al ejemplo
//Modifcar para nuevos instrumentos
class SineInstrument implements Instrument{
  Oscil wave;
  Line  ampEnv;

  SineInstrument(float frequency){
    // Oscilador sinusoidal con envolvente
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }

  // Secuenciador de notas
  void noteOn(float duration){
    // Amplitud de la envolvente
    ampEnv.activate( duration, 0.5f, 0 );
    // asocia el oscilador a la salida
    wave.patch( out );
  }

  // Final de la nota
  void noteOff(){
    wave.unpatch( out );
  }
}

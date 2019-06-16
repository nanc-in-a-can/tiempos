/* ----------------- Processing code --------------------- */

import oscP5.*;
import netP5.*;

OscP5 oscP5;



// lineas
int widthSize = 1375;
int heightSize = 700;

int index = 0;

// texto
String texto1 = "  ";
String timer1 = "  ";

String texto2 = "  ";
String timer2 = "  ";

String texto3 = "  ";
String timer3 = "  ";

String texto4 = "  ";
String timer4 = "  ";

// colores


// Coordenadas
//  citas3 arriba izquierda Tempo: 15
float tx3_X1 = 10; float tx3_X2 = (width/2)-15;
float tx3_Y1 = 50; float tx3_Y2 = (height/2)-55;
// citas2 abajo izquierda Tempo: 14
float tx2_X1 = 10; float tx2_X2 = (width/2)-15;
float tx2_Y1 = (height/2)+50; float tx2_Y2 = (height)-55;
// citas1 Abajo Derecha Tempo: 13
float tx1_X1 = (width/2)+10; float tx1_X2 = (width)-15;
float tx1_Y1 = (height/2)+50; float tx1_Y2 = (height)-55;
// citas4 Arriba Derecha Tempo: 16
float tx4_X1 = (width/2)+10; float tx4_X2 = (width)-15;
float tx4_Y1 = 50; float tx4_Y2 = (height/2)-55;

// Instrucciones
// Instrucciones3 arriba izquierda 
float inst3_X1 = 10; float inst_X2 = (width/2)-15;
float inst3_Y1 = (height/2)-150; float inst_Y2 = (height/2)-5;
// Instrucciones2 abajo izquierda 
float inst2_X1 = 10; float inst2_X2 = (width/2)-15;
float inst2_Y1 = (height/2)+200; float inst2_Y2 = height;
// Instrucciones1 Abajo Derecha
float inst1_X1 = (width/2)+10; float inst1_X2 = (width)-15;
float inst1_Y1 = (height/2)+200; float inst1_Y2 = (height);
// Instrucciones4 Arriba Derecha
float inst4_X1 = (width/2)+10; float inst4_X2 = (width)-15;
//float inst4_Y1 = 200; float inst4_Y2 = 



// quien toca

/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation;

void setup() {
//  size(1375, 700);
fullScreen();
  
  frameRate(30);

  /* create a new instance of oscP5.
   * 12000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this, 12000);

  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */

  // aqui recibes cosas en supercollider
  /* the address of the osc broadcast server */
  myBroadcastLocation = new NetAddress("127.0.0.1", 57120);
}


void draw() {


  background(0);  
  fill(250,250,250);
  
  // heart thing
  ellipse(width/2, height/2, 20+random(-2.5,2.5), 20+random(-2.5,2.5));
  // delimitar los cuadrantes
  line(width/2+random(-3.5,3.5), 0, width/2+random(-3.5,3.5), height);
  line(0, height/2+random(-3.5,3.5), width, height/2+random(-3.5,3.5));
  
  //  Arriba-izquierda Tempo: 15
  fill(250,250,250);
  textSize(30);
  text(timer3, 10+random(-3.5,3.5), 10+random(-3.5,3.5), 1000,500);
  
  fill(125,125,125);
  textSize(22);
  text(texto3, 10, 50, (width/2)-15, (height/2)-55);
  
  // Abajo-izquierda  Tempo: 14
  fill(250,250,250);
  textSize(30);
  text(timer2, 10+random(-3.5,3.5), (height/2)+10+random(-3.5,3.5), 1000,500);
  
  fill(125,125,125);
  textSize(22);
  text(texto2, 10, (height/2)+50, (width/2)-15, (height/2)-55);
  
  // Derecha-Abajo  Tempo: 13
  fill(250,250,250);
  textSize(30);
  text(timer1, (width-170)+10+random(-3.5,3.5), (height/2)+10+random(-3.5,3.5), 1000,500);
  
  fill(125,125,125);
  textSize(22);
  text(texto1, (width/2)+10, (height/2)+50, (width/2)-15, (height/2)-55);
  
  // Derecha-Arriba Tempo: 16
  fill(250,250,250);
  textSize(30);
  text(timer4, (width-170)+10+random(-3.5,3.5), 10+random(-3.5,3.5), 1000,500);
  fill(125,125,125);
  textSize(22);
  text(texto4, (width/2)+10, 50, (width/2)-15, (height/2)-55);


//  fill(200,200,200);
//  textSize(30);
//  text("canon2 gestural indications XXXXX", 170, 10, (width/2)-170, 50);


  index++;

  stroke(250,250,250);
 // strokeWeight(strokeW);
 // line(coordx1, coordy1, coordx2, coordy2);

}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/voice0")==true) {
    theOscMessage.print();
//    println(theOscMessage.addrPattern());
    texto1 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice1")==true) {
    theOscMessage.print();
    texto2 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice2")==true) {
    theOscMessage.print();
    texto3 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice3")==true) {
    theOscMessage.print();
    texto4 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/timer0")==true) {
    theOscMessage.print();
    timer1 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/timer1")==true) {
    theOscMessage.print();
    timer2 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/timer2")==true) {
    theOscMessage.print();
    timer3 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/timer3")==true) {
    theOscMessage.print();
    timer4 = theOscMessage.get(0).stringValue();
  }


}

/* ----------------- Processing code --------------------- */

import oscP5.*;
import netP5.*;

OscP5 oscP5;



// lineas
int widthSize = 1375;
int heightSize = 700;

int index = 0;

// texto
String text1Canon1 = "  ";
String timer1 = "  ";

String text2Canon2 = "  ";
String timer2 = "  ";

String text3Canon3 = "  ";
String timer3 = "  ";

String text4Canon4 = "  ";
String timer4 = "  ";

// colores


/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation;

void setup() {
  size(1375, 700);
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
  ellipse(width/2, height/2, 20+random(-2.5,2.5), 20+random(-2.5,2.5));
  line(width/2+random(-3.5,3.5), 0, width/2+random(-3.5,3.5), height);
  line(0, height/2+random(-3.5,3.5), width, height/2+random(-3.5,3.5));
  fill(250,250,250);
  textSize(30);
  text(timer3, 10+random(-3.5,3.5), 10+random(-3.5,3.5), 1000,500);
  fill(125,125,125);
  textSize(22);
  text(text3Canon3, 10, 50, (width/2)-15, (height/2)-55);
  fill(250,250,250);
  textSize(30);
  text(timer2, 10+random(-3.5,3.5), (height/2)+10+random(-3.5,3.5), 1000,500);
  fill(125,125,125);
  textSize(22);
  text(text2Canon2, 10, (height/2)+50, (width/2)-15, (height/2)-55);
  fill(250,250,250);
  textSize(30);
  text(timer1, (width-170)+10+random(-3.5,3.5), (height/2)+10+random(-3.5,3.5), 1000,500);
  fill(125,125,125);
  textSize(22);
  text(text1Canon1, (width/2)+10, (height/2)+50, (width/2)-15, (height/2)-55);
  fill(250,250,250);
  textSize(30);
  text(timer4, (width-170)+10+random(-3.5,3.5), 10+random(-3.5,3.5), 1000,500);
  fill(125,125,125);
  textSize(22);
  text(text4Canon4, (width/2)+10, 50, (width/2)-15, (height/2)-55);


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
    text1Canon1 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice1")==true) {
    theOscMessage.print();
    text2Canon2 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice2")==true) {
    theOscMessage.print();
    text3Canon3 = theOscMessage.get(0).stringValue();
  }
  if (theOscMessage.checkAddrPattern("/voice3")==true) {
    theOscMessage.print();
    text4Canon4 = theOscMessage.get(0).stringValue();
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

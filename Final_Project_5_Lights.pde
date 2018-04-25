//import processing.io.*;

LightBulb[] Lights = new LightBulb[10];
LightBulb Red,Green,Blue,White,Yellow, PRed,PGreen,PBlue,PWhite,PYellow;
ArrayList<LightBulb> simonSaid=new ArrayList<LightBulb>();


void setup(){ 
  size(700,500);
  
  int i = 0;
  Red=new LightBulb(4);Lights[i]=Red;
  i++;
  Green=new LightBulb(17);Lights[i]=Green;
  i++;
  Blue=new LightBulb(22);Lights[i]=Blue;
  i++;
  White=new LightBulb(5);Lights[i]=White;
  i++;
  Yellow=new LightBulb(6);Lights[i]=Yellow;
  i++;
  PRed=new LightBulb(13);Lights[i]=PRed;
  i++;
  PGreen=new LightBulb(26);Lights[i]=PGreen;
  i++;
  PBlue=new LightBulb(18);Lights[i]=PBlue;
  i++;
  PWhite=new LightBulb(23);Lights[i]=PWhite;
  i++;
  PYellow=new LightBulb(25);Lights[i]=PYellow;
  
  for (LightBulb b : Lights){
    //GPIO.pinMode(b.index,GPIO.OUTPUT);
  }
  
}

void draw(){
  stroke(0);
  noFill();
  rect(0,0,500,500);
  
  for(LightBulb b : Lights){
    b.Display();
  }
  
  //ONLY FOR PC
  for (int i=0; i<Lights.length;i++){
    if(Lights[i].on){fill(255);}
    else{fill(0);}
    ellipse(600,i*30+20,20,20);
  }
  //END ONLY FOR PC
  Yellow.On();
}

void allOff(){
  for (LightBulb b : Lights){
    b.Off();
  }
}

void allOn(){
  for (LightBulb b : Lights){
    b.On();
  }
}

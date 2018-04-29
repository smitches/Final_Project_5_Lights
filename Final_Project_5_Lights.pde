//import processing.io.*;
Timer t = new Timer();
LightBulb[] Lights = new LightBulb[5];
LightBulb Red,Green,Blue,White,Yellow;
ArrayList<LightBulb> simonSaid=new ArrayList<LightBulb>();
ArrayList<LightBulb> playerSaid=new ArrayList<LightBulb>();
Boolean playerKey, simonSaying;
String[] Screens = new String[4];
String thisScreen;int i=0;
int idx = 0;


void setup(){ 
  simonSaying = true;
  size(700,500);
  int i = 0;
  Red=new LightBulb(4,13);Lights[i]=Red;
  i++;
  Green=new LightBulb(17,26);Lights[i]=Green;
  i++;
  Blue=new LightBulb(22,18);Lights[i]=Blue;
  i++;
  White=new LightBulb(5,23);Lights[i]=White;
  i++;
  Yellow=new LightBulb(6,25);Lights[i]=Yellow;
  i++;
  
  for (LightBulb b : Lights){
    //GPIO.pinMode(b.index,GPIO.OUTPUT);
  }
  
  
  thisScreen=Screens[0]="MainMenuScreen";
  Screens[1]="PlayScreen";
  Screens[2]="GetNameScreen";
  Screens[3]="DisplayHighScoreScreen";
}

void draw(){
  
  if (thisScreen==Screens[0])
    {displayMainMenu();}
  else if(thisScreen==Screens[1])
    {displayPlayScreen();}
  else if(thisScreen==Screens[2])
    {displayGetNameScreen();}  
  else if(thisScreen==Screens[3])
    {displayHighScoreScreen();}
  
  
  for(LightBulb b : Lights){b.Display();}
  
  //ONLY FOR PC
  for (int i=0; i<Lights.length;i++){
    if(Lights[i].on){fill(255);}
    else{fill(0);}
    ellipse(600,i*30+20,20,20);
  }
  //END ONLY FOR PC
  
}

void displayMainMenu(){
  noStroke();
  fill(0,255,0);
  rect(0,0,500,500);
}
void displayPlayScreen(){
  noStroke();
  fill(0,255,255);
  rect(0,0,500,500);
  if (simonSaying) {
    simonSays();
  }else {
    playerSays();
  }
}
void displayGetNameScreen(){
  noStroke();
  fill(255,255,0);
  rect(0,0,500,500);
}
void displayHighScoreScreen(){
  noStroke();
  fill(255,0,255);
  rect(0,0,500,500);
}
void simonAdds(){
  int i = int(random(5));
  simonSaid.add(Lights[i]);
}
void simonDisplay(LightBulb L){
  playerKey = false;
  L.On();
}
void simonSays(){
  t.setPeriod(500);
  t.now(); //records the starttime 
  if (t.next()){
    simonDisplay(simonSaid.get(idx));
    idx += 1; 
  }if (idx == simonSaid.size()){
    idx = 0;
    simonAdds();
    simonSaying = false;
  }
  
}
void playerSays(){
}

  

void mouseClicked(){
  thisScreen=Screens[i%Screens.length];
  
  Lights[i%Lights.length].On();
  i++;
}

void keyPressed(){
  //Lights[int(random(0,Lights.length))].On();
}
void allOff(){
  for (LightBulb b : Lights){
    b.Off();
  }
}
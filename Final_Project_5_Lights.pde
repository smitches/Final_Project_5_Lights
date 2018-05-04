//import processing.io.*;
import processing.sound.*;
Timer t = new Timer();
Table highScores; 
LightBulb[] Lights = new LightBulb[5];
LightBulb Red,Green,Blue,White,Yellow;
ArrayList<LightBulb> simonSaid=new ArrayList<LightBulb>();
ArrayList<LightBulb> playerSaid=new ArrayList<LightBulb>();
Boolean simonSaying;
String[] Screens = new String[5];
String thisScreen; 
int i=0;
int idx = 0;
int score = 0;
Boolean firstCall=true;
Boolean written = false;
String scoretxt = "Score: 0";
String name = "";
ArrayList<String> scoreList = new ArrayList<String>();
color green = #2EAF04;
color red = #F01317;
color white = #FFFFFF;
color blue = #1D21ED;
color yellow = #FFF931;
color[] array = {red,green,blue,white,yellow};
PFont font;
int x;
PImage img;

String[] instruct = new String[5];
int idxl=0, jdx=0, ydx = 20;
float xdx = 10;
String message;

Button home;

SoundFile playing;


//TODO: RESET = > Remember to reset the varibles;
//TODO: Input name when the player dies and store string name as the input
//TODO: ALL GUI SCREENS. LOOK AT THE FUNCTIONS BELOW DRAW

void setup(){ 
  frameRate(60);
  simonSaying = true;
  img = loadImage("psych.jpg");
  font = createFont("GILLUBCD.TTF",48);//loadFont("GillSans-UltraBold-48.vlw");
  size(700,500);
  home = new Button(10,height-70,120,50,"Main Menu");
  int i = 0;
  //remember to add in the s when initializing lightbulbs
  SoundFile s = new SoundFile(this,"1.wav");
  Red=new LightBulb(4,13,s);Lights[i]=Red;
  i++;
  playing =s;
  s = new SoundFile(this,"2.wav");
  Green=new LightBulb(17,26,s);Lights[i]=Green;
  i++;
  s = new SoundFile(this,"3.wav");
  Blue=new LightBulb(22,18,s);Lights[i]=Blue;
  i++;
  s = new SoundFile(this,"4.wav");
  White=new LightBulb(5,23,s);Lights[i]=White;
  i++;
  s = new SoundFile(this,"5.wav");
  Yellow=new LightBulb(6,25,s);Lights[i]=Yellow;
  i++;
  for (LightBulb b : Lights){
    //GPIO.pinMode(b.index,GPIO.OUTPUT);
  }
  
  
  thisScreen=Screens[0]="MainMenuScreen";
  Screens[1]="PlayScreen";
  Screens[2]="Instructions";
  Screens[3]="DisplayHighScoreScreen";
  Screens[4]="DisplayLoseScreen";
}

void draw(){
  frameRate(60);
  if (thisScreen==Screens[0])
    {displayMainMenu();}
  else if(thisScreen==Screens[1])
    {displayPlayScreen();
    for(LightBulb b : Lights){b.Display();}
    for (int i=0; i<Lights.length;i++){
    if(Lights[i].on && i == 0)
       {fill(red);}
    else if (Lights[i].on && i == 1){
       fill(green);}
    else if (Lights[i].on && i == 2){
       fill(blue);}
    else if (Lights[i].on && i == 3){
       fill(white);}
    else if (Lights[i].on && i == 4){
       fill(yellow);}
    else{fill(0);}
    ellipse(350,i*30+140,20,20);
  }}//END ONLY FOR PC}
  else if(thisScreen==Screens[2])
    {displayInstructions();}  
  else if(thisScreen==Screens[3])
    {displayHighScoreScreen();}
  else if(thisScreen==Screens[4])
    {displayLoseScreen(); }
  if (thisScreen!=Screens[0]){home.Display();home.isOver();}
  
}

void displayMainMenu(){
  background(200);
  for (int x = 0; x <= width;x+= 15){
    for (int y = 0;y <= height;y+= 15){
      fill(#FFFFFF);
      fill(random(255),random(255),random(255));
      ellipse(x,y,11,11);
    }
  }
  //titleButton
  fill(0);
  rect(100,50,500,100);
  fill(255);
  textFont(font,80);
  text("5 - Lights",112,125);
  //play
  fill(0);
  rect(275,200,125,50);
  fill(255);
  textFont(font,30);
  text("Play",300,235);
  //Instructions
  fill(0);
  rect(220,290,250,50);
  fill(255);
  textFont(font,30);
  text("Instructions",230,325);
  //High Scores
  fill(0);
  rect(220,380,250,50);
  fill(255);
  textFont(font,30);
  text("High Scores",235,415);
 // noStroke();
 // fill(0,255,0);
 // rect(0,0,500,500);
}
void displayPlayScreen(){
  background(255);
  img.resize(700,500);
  image(img,0,0);
  strokeWeight(10);
  stroke(0);
  fill(#C4C4C0);
  rect(300,100,100,200);
  noStroke();
  strokeWeight(5);
  stroke(0);
  fill(#C4C4C0);
  rect(0,0,140,40);
  fill(#C4C4C0);
  rect(200,350,300,100);
  textSize(20);
  fill(0);
  text("Simon is talking...",230,400);
  fill(0);
  textSize(20);
  text(scoretxt, 10,25);
  if (simonSaying) {
    simonSays();
  }else {
    playerSays();
  }
  noStroke();
}

void displayLoseScreen(){
  background(0);
  image(img,0,0);
  fill(255);
  stroke(12);
  rect(245,100,200,100);
  fill(0);
  textSize(30);
  text("YOU LOSE",280,150);
  fill(255);
  stroke(12);
  rect(245,275,200,100);
  fill(0);
  textSize(30);
  text("Enter Name: ", 260,300);
  text(name,260,320);
  if (written == false){
  writeCsv();
  updateScoresLists();
  written = true;
  }
}

void displayInstructions(){
  background(255);
  instruct[0] = "Welcome to the game 5 lights which is simlar to Simon Says!!";
  instruct[1] = "The game will consist of Simon displaying 5 different colored lights in a sequence!!";
  instruct[2] = "Your job is to match that sequence whenever its your turn by pressing the right key!!"; 
  instruct[3] = "The squares below indicate which key pad corresponds to which color!!";
  instruct[4] = "Good luck and make sure you pay attention to what Simon is saying!!";

  textSize(16);
  pushMatrix();
  translate(0, 20);
  fill(0);
 for (int count = 0; count < instruct.length; count ++){
  if (idxl<instruct.length) {
    message = instruct[idxl];
  }
  
  else{
    message = "";}
  if (jdx < message.length()) {
    text(message, xdx, ydx*idxl+10);
    xdx += textWidth(message.charAt(jdx)); 
    jdx++;
    
  }
  else { 
    jdx=0;
    idxl++;
    xdx = 10;
 }
 }
 popMatrix();
 buttons();
 
 
}

void buttons(){

  textSize(30);
  stroke(255);
  strokeWeight(3);
  
  fill(#FA0808);
  rect(200, 200, 70,70);
 
  
  fill(#08FA19);
  rect(290, 200,70,70);
  
  fill(#081DFA);
  rect(380, 200, 70, 70);

  
  fill(255, 255, 255);
  rect(240,300, 70, 70);
  
  fill(#FFF305);
  rect(340, 300, 70, 70);
 
  fill(0);
  text("1",228, 245);
  text("2",318, 245);
  text("3",406, 245);
  text("4",268, 340);
  text("5",368, 340);

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
void simonSays(){
  if (simonSaid.size()==0){ 
    int randint=int(random(5));
    simonSaid.add(Lights[randint]);
    playing=Lights[randint].file;
  }
  if(idx==0&&firstCall){
    t.setPeriod(1000);
    t.now();
  }
  firstCall=false;
  simonSaid.get(idx).On();
  if (t.next()){
    idx += 1; 
    allOff();
  }
  if (idx == simonSaid.size()){
    idx = 0;
    simonAdds();
    simonSaying = false;
    allOff();
    playerSaid=new ArrayList<LightBulb>();
  }
  
}
void playerSays(){
  if(playerSaid.size()>0){
    playerSaid.get(playerSaid.size()-1).On();
    if (t.elapsed()<50)
      {allOff();}
    if(!firstCall)
      {firstCall=true;
       t.now();}
  }
  if(playerSaid.size()==simonSaid.size()-1&&t.next())
    {allOff();
     if(!compare())
       {thisScreen=Screens[4];}
     else {
     updateScore(playerSaid.size());
     simonSaying=true;}
    }
  
}

Boolean compare(){
  Boolean returnvalue = true;
  for (int j=0;j<playerSaid.size();j++){
    if (playerSaid.get(j)!=simonSaid.get(j))
      {returnvalue=false;}
  }
  return (returnvalue);
}

void mouseClicked(){
  if ((mouseX > 275 && mouseX < 400) && (mouseY > 200 && mouseY < 250)){
  thisScreen=Screens[1];
  //Lights[i%Lights.length].On();
  //i++;
  }
  if((mouseX > 220 && mouseX < 470) && (mouseY > 290 && mouseY < 340)){
    thisScreen = Screens[2];}
  if((mouseX > 220 && mouseX < 470) && (mouseY > 380 && mouseY < 430)){
    thisScreen = Screens[3];}
    
}
void keyPressed(){allOff();}
void keyReleased(){
  getName();
  if (!simonSaying){
    t.now();
    if(key=='1'){
      playerSaid.add(Lights[0]);
    }
    else if(key=='2'){
      playerSaid.add(Lights[1]);
    }
    else if(key=='3'){
      playerSaid.add(Lights[2]);
    }
    else if(key=='4'){
      playerSaid.add(Lights[3]);
    }
    else if(key=='5'){
      playerSaid.add(Lights[4]);
    }    
  }
}
void allOff(){
  for (LightBulb b : Lights){
    b.Off();
  }
}

void playfile(SoundFile f){
  playing.stop();
  playing=f;
  playing.play();
}

void updateScore(int n){
  score = 10 * n;
  scoretxt = "Score: " + str(score);
}

void writeCsv(){
  highScores = loadTable("Scores.csv", "header");
  TableRow newRow = highScores.addRow();
  newRow.setString("Name", name);
  newRow.setInt("Score", score);
  saveTable(highScores, "Scores.csv");
}

void updateScoresLists(){
  highScores = loadTable("Scores.csv", "header");
  highScores.setColumnType("Score", Table.INT);
  highScores.sortReverse("Score");
  int rows = highScores.getRowCount();
  if (rows > 10){
    rows = 10;
  }
  for (int r = 0; r < rows; r++) {
  TableRow row = highScores.getRow(r);
  String oneScore = "";
  oneScore += row.getString("Name");
  oneScore += " : ";
  oneScore += row.getString("Score");
  scoreList.add(oneScore);
  }
}
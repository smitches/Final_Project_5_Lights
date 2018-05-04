import processing.io.*;
//import processing.sound.*;
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

//SoundFile playing;


//TODO: RESET = > Remember to reset the varibles;
//TODO: Input name when the player dies and store string name as the input
//TODO: ALL GUI SCREENS. LOOK AT THE FUNCTIONS BELOW DRAW

void setup(){ 
  simonSaying = true;
  size(700,500);
  int i = 0;
  //remember to add in the s when initializing lightbulbs
  //SoundFile s = new SoundFile(this,"1.wav");
  Red=new LightBulb(4,13);Lights[i]=Red;
  i++;
  //playing =s;
 // s = new SoundFile(this,"2.wav");
  Green=new LightBulb(17,26);Lights[i]=Green;
  i++;
//  s = new SoundFile(this,"3.wav");
  Blue=new LightBulb(22,18);Lights[i]=Blue;
  i++;
 // s = new SoundFile(this,"4.wav");
  White=new LightBulb(5,23);Lights[i]=White;
  i++;
//  s = new SoundFile(this,"5.wav");
  Yellow=new LightBulb(6,25);Lights[i]=Yellow;
  i++;
  for (LightBulb b : Lights){
    GPIO.pinMode(b.index,GPIO.OUTPUT);
  }
  
  
  thisScreen=Screens[0]="MainMenuScreen";
  Screens[1]="PlayScreen";
  Screens[2]="GetNameScreen";
  Screens[3]="DisplayHighScoreScreen";
  Screens[4]="DisplayLoseScreen";
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
  else if(thisScreen==Screens[4])
    {displayLoseScreen(); }
  
  
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
  fill(0);
  textSize(20);
  text(scoretxt, 10,25);
  if (simonSaying) {
    simonSays();
  }else {
    playerSays();
  }
}

void displayLoseScreen(){
  background(0);
  if (written == false){
  writeCsv();
  updateScoresLists();
  written = true;
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
void simonSays(){
  if (simonSaid.size()==0){ 
    int randint=int(random(5));
    simonSaid.add(Lights[randint]);
  //playing=Lights[randint].file;
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
  thisScreen=Screens[1];
  Lights[i%Lights.length].On();
  i++;
}

void keyReleased(){
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

/*void playfile(SoundFile f){
  playing.stop();
  playing=f;
  playing.play();
}*/

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
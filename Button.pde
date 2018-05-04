class Button{
  float x,y,w,h;
  String txt;
  color c;
  Button(float X,float Y,float W, float H,String Txt){
    x=X;y=Y;w=W;h=H;txt=Txt;c=color(0);
  }
  void Display(){
    fill(c);
    rect(x,y,w,h);
    fill(255);
    textSize(20);
    text(txt,x+5,y+25);
  }
  Boolean isOver(){
    if(mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h){
      c=color(200,0,0);
      if(mousePressed){
        t = new Timer();
 
Lights = new LightBulb[5];
simonSaid=new ArrayList<LightBulb>();
playerSaid=new ArrayList<LightBulb>();
Screens = new String[5];
i=0;
idx = 0;
score = 0;
firstCall=true;
written = false;
scoretxt = "Score: 0";
name = "";
scoreList = new ArrayList<String>();




        setup();
      }
      return true;
    }
    else{c=color(0);return false;}
  }
}

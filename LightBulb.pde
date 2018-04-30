class LightBulb{
  int index, idx2;
  boolean on;
  SoundFile file;
  LightBulb(int index, int idx2, SoundFile file){
    this.index=index;
    this.idx2=idx2;
    on = false;
    this.file=file;
  }
  void On(){
    if (!on){file.jump(29);file.play();}
    for (LightBulb b : Lights){
      b.Off();
    }
    on=true;
  }
  void Off(){
    on=false;
  }
  void Display(){
    //if (on){GPIO.digitalWrite(index,GPIO.HIGH);GPIO.digitalWrite(idx2,GPIO.HIGH);}
    //else{GPIO.digitalWrite(index,GPIO.LOW);GPIO.digitalWrite(idx2,GPIO.LOW);}
    
  }
}

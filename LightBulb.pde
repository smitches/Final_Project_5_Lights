class LightBulb{
  int index, idx2;
  boolean on;
  LightBulb(int index, int idx2){
    this.index=index;
    this.idx2=idx2;
    on = false;
  }
  void On(){
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

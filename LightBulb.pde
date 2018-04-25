class LightBulb{
  int index;
  boolean on;
  LightBulb(int index){
    this.index=index;on = false;
  }
  void On(){
    on=true;
  }
  void Off(){
    on=false;
  }
  void Display(){
    //if (on){GPIO.digitalWrite(index,GPIO.HIGH);}
    //else{GPIO.digitalWrite(index,GPIO.LOW);}
  }
}

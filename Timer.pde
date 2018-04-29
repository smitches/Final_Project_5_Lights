class Timer{
  float startTime;
  float period;
  Timer(){
  }
  void now(){startTime=millis();}
  float elapsed(){
    return (millis()-startTime);
  }
  void setPeriod(float p){
    period=p;
  }
  boolean next(){
    boolean returnvalue=false;
    if (elapsed()>period){
      now();
      returnvalue=true;
    }
    return (returnvalue);
  }
}
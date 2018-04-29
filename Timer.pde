class Timer{
  float last, interval;
  int index, range;
  boolean pause;
  Timer(float interval, int range){
    this.interval = interval;
    this.last = millis();
    this.range = range;
    this.index = 0;
    pause=false;
  }
  int getIndex(){
    if (pause){return index;}
    else if (millis() >= last + interval){
      index +=1;
      index = index%range;
      last = millis();
    }
    return index;
  }
  void click(){
    pause=!(pause);
  }
  
}

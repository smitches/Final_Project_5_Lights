void getName(){
  if (thisScreen == Screens[4] && key != ENTER){
    name += str(key);}
  else{
    writeCsv();
  }
}
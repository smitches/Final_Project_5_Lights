void getName(){
  if (thisScreen == Screens[4] && key != ENTER ){
    name += str(key);}
  if (thisScreen == Screens[4] && key == ENTER && !name.equals("")){
    writeCsv();
    thisScreen = Screens[0];
  }
}

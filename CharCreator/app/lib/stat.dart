abstract class AffectsStat {
  void apply();
  void delete();
}
class Stat {
  int value = 0;
  int mod = 0;

  int Stat2Modifier(){
    return ((value-10) / 2).floor(); 
  }
  Stat(int v){
    value = v;
    mod = Stat2Modifier();
  }
}
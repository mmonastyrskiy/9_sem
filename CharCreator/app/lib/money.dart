// ignore_for_file: non_constant_identifier_names, constant_identifier_names
enum MoneyTypes {
  Platinum,
  Gold,
  Elec,
  Silver,
  Coper
}

class Money {
  int platinum = 0;
  int gold = 0;
  int elec= 0;
  int silver=0;
  int coper=0;

  Money([this.platinum=0,this.gold=0,this.elec=0,this.silver=0,this.coper=0]);
  void add([int platinum=0,int gold=0,int elec=0,int silver=0,int coper=0]) {
    this.platinum += platinum;
    this.gold += gold;
    this.elec += elec;
    this.silver += silver;
    this.coper += coper;
    
  }
 
  void add_gold(int a) => gold += a;
  void add_plat(int a) => platinum += a;
  void add_elec(int a) => elec += a;
  void add_silver(int a) => silver += a;
  void add_coper(int a) => gold += a;
  int _to_coper() => platinum*1000+gold*100+elec*50+silver*10+coper;
  void _optimize(int t){
    platinum = t ~/ 1000;
    t-= platinum*1000;

    gold = t ~/ 100;
    t-= gold*100;

    elec = t ~/ 50;
    t-= elec*50;

    silver = t ~/ 10;
    t-= silver*10;
    coper = t;



  }
  bool buy(Price p){
  if (p._to_coper() > _to_coper()){
    return false;
  }
  else{
    int new_coper = _to_coper() - p._to_coper();
    _optimize(new_coper);
    return true;

  }

}
void sell(Price p) {
  int new_coper = _to_coper() + p._to_coper();
  _optimize(new_coper);
}  
}
class Price extends Money{}
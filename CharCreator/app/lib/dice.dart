
// ignore_for_file: constant_identifier_names, camel_case_types, non_constant_identifier_names

import 'dart:math';

enum DiceType  {
D4,D6,D10,D12,D100,D8,DN
}

class DieResult
{
  DiceType? type;
  int result=0;
DiceType dim2type (int dt){
  switch(dt){
    case 4: return DiceType.D4;
    case 6: return DiceType.D6;
    case 8: return DiceType.D8;
    case 10: return DiceType.D10;
    case 12: return DiceType.D12;
    case 100: return DiceType.D100;
    default: return DiceType.DN;

  }
}
DieResult(int dt, int rr){
type = dim2type(dt);
result = rr;
}

}

class diceFactory{
  int dim=0;
  final rnd =Random();


diceFactory (int dt){
dim = dt;
}

  
DieResult throwdie(){
  int result = rnd.nextInt(dim-1) + 1;
  return DieResult(dim,result);

}
}
class D4 extends diceFactory{
  D4() :super(4);
}
class D6 extends diceFactory{
  D6() :super(6);
}
class D8 extends diceFactory{
  D8() :super(8);
}

class D10 extends diceFactory{
D10() :super(10);
}
class D12 extends diceFactory{
D12() :super(12);
}
class D100 extends diceFactory{
  D100() : super(100);
}
class DN extends diceFactory{
  DN(super.dt);
}



class ThrowObject{
List<DieResult> res = [];
List<diceFactory> tothrow = [];

int total() {
  int t = 0;
  for (DieResult r in res){
    t += r.result;
  }
  return t;
}
void add(int dim,{int ammount=1}) {
  if(ammount <= 0){
    return;
  }

  for(int i=0; 1<ammount;i++){
  switch(dim){
    case 4: tothrow.add(D4());
    case 6: tothrow.add(D6());
    case 8: tothrow.add(D8());
    case 10: tothrow.add(D10());
    case 12: tothrow.add(D12());
    case 100: tothrow.add(D100());
    default: tothrow.add(DN(dim));

  }
}
}
  void addDT(DiceType dt){
    switch(dt){
      case DiceType.D4: tothrow.add(D4());
      case DiceType.D6: tothrow.add(D6());
      case DiceType.D10: tothrow.add(D10());
      case DiceType.D12: tothrow.add(D12());

      default: tothrow.add(D100());
    }

  }


void DoRoll(){
  for(diceFactory d in tothrow){
    res.add(d.throwdie());
  }
  tothrow.clear();
  res.sort((a, b) => a.result.compareTo(b.result));

}
void strip(int idx) => res.removeRange(0, idx);

void clear(){
  tothrow.clear();
  res.clear();
}
String tostr(){
  String s = "";
  for(var r in res) {
    s += ("${r.type} -> ${r.result}");
    s+= "\n";
  }
  return s;
}
}
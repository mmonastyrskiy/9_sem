// ignore_for_file: constant_identifier_names

import 'stat.dart';
enum BackgroundNames  {
  Entertainer,
  Urchin,
  Noble,
  Guild_artisan,
  Sailor,
  Sage,
  Folk_Hero,
  Hermit,


}
abstract class Background implements AffectsStat {
  factory Background(String chosen)
  {
    switch(chosen.toLowerCase()){
      case "артист": return Entertainer();
      default: return Entertainer();

    }
  
}
}
final class Entertainer implements Background {
  @override
  void apply() {
    // TODO: implement apply
  }

  @override
  void delete() {
    // TODO: implement delete
  }
  Entertainer(){
    apply();
  }

}



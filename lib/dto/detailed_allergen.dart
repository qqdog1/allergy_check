import '../const/allergen_level.dart';

class DetailedAllergen {
  List<TypeAllergen> lst;

  DetailedAllergen(this.lst);
}

class TypeAllergen {
  String type;
  List<Allergen> lst;

  TypeAllergen(this.type, this.lst);
}

class Allergen {
  String name;
  AllergenLevel allergenLevel;

  Allergen(this.name, this.allergenLevel);
}

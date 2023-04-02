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
  int score;

  Allergen(this.name, this.score);
}

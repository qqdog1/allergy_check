import 'dart:convert';

class UserAllergen {
  String name;
  // TODO 之後再想怎麼換成enum
  String allergyLevel;

  UserAllergen(this.name, this.allergyLevel);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'allergyLevel': allergyLevel
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
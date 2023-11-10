import 'dart:io';

class StudentModel {
  int? id;
  late String name;
  File? image;
  late int preparationTime;
  late String ingredients;
  late String instruction;

  StudentModel(
      {this.id,
      required this.name,
      this.image,
      required this.preparationTime,
      required this.instruction,
      required this.ingredients});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      // 'isFavorite': isFavorite? 1:0,
      'preparationTime': preparationTime,
      'ingredients': ingredients,
      'instructions': instruction,
      'image': image == null ? '' : image!.path
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      preparationTime: map['preparationTime'],
      instruction: map['instructions'],
      ingredients: map['ingredients'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}

import 'dart:io';

class StudentModel {
  int? id;
  late String name;
  File? image;
  late int age;
  late String address;
  late String email;
  late int phoneNumber;

  StudentModel(
      {this.id,
      required this.name,
      this.image,
      required this.age,
      required this.address,
      required this.email,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'image': image == null ? '' : image!.path
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      address: map['address'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }
}

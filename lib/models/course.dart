import 'package:flutter/material.dart';

class Course {
  final int id;
  final String name, imageName, authorName;
  final String color;

  static final List<String> column = [
    "id",
    "name",
    "imageName",
    "authorName",
  ];

  Course({
    this.id,
    @required this.name,
    @required this.imageName,
    @required this.authorName,
    this.color,
  });

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(
      id: data['id'],
      name: data['name'],
      authorName: data['authorName'],
      imageName: data['imageName'],
      color: data['color'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'authorName': authorName,
        'imageName': imageName,
        'color': color,
      };
}

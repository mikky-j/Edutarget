import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class Lesson {
  final String name, description;
  final Color color;

  const Lesson({this.name, this.description, this.color});

  String generateBody(int paragraphs, int words) {
    return lorem(paragraphs: paragraphs, words: words);
  }
}

import 'package:new_edutarget/models/course.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _username = "";
  String _email = "";
  String _password = "";
  String _firstName = "";
  String _lastName = "";
  String _phoneNumber = "";
  String _country = "";
  String _preferredLanguage = "";
  String _bio = "";
  String _image = "";
  Set<Course> _courses = {};

  set username(value) {
    _email = "";
    _username = value;
    notifyListeners();
  }

  set email(value) {
    _email = value;
    notifyListeners();
  }

  set password(value) {
    _password = value;
    notifyListeners();
  }

  set image(value) {
    _image = value;
    notifyListeners();
  }

  set courses(value) {
    _courses = value;
    notifyListeners();
  }

  set firstName(value) {
    _firstName = value;
    notifyListeners();
  }

  set lastName(value) {
    _lastName = value;
    notifyListeners();
  }

  set phoneNumber(value) {
    _phoneNumber = value;
    notifyListeners();
  }

  set country(value) {
    _country = value;
    notifyListeners();
  }

  set preferredLanguage(value) {
    _preferredLanguage = value;
    notifyListeners();
  }

  set bio(value) {
    _bio = value;
    notifyListeners();
  }

  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get country => _country;
  String get image => _image;
  String get preferredLanguage => _preferredLanguage;
  String get bio => _bio;
  Set<Course> get courses => _courses;

  void signOut() {
    _username = "";
    _email = "";
    _password = "";
    _firstName = "";
    _lastName = "";
    _phoneNumber = "";
    _country = "";
    _preferredLanguage = "";
    _bio = "";
    _image = "";
    _courses = {};
  }
}

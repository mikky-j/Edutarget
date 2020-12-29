import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:new_edutarget/models/user.dart';
import 'package:provider/provider.dart';

class CompleteAccountPage extends StatefulWidget {
  final bool edit;
  const CompleteAccountPage({Key key, this.edit = false}) : super(key: key);

  @override
  _CompleteAccountPageState createState() => _CompleteAccountPageState();
}

class _CompleteAccountPageState extends State<CompleteAccountPage> {
  File _image;
  String _sValue = "Country 1";
  String _tValue = "None";
  String _userImagePath = "";

  Future cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      cropStyle: CropStyle.circle,
      compressFormat: ImageCompressFormat.jpg,
      maxHeight: 512,
      maxWidth: 512,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      androidUiSettings: AndroidUiSettings(
        lockAspectRatio: true,
        toolbarColor: Colors.deepPurple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: "Crop Image",
        activeControlsWidgetColor: Colors.deepPurple,
      ),
    );
    setState(() {
      print(cropped.path);
      _userImagePath = cropped.path;
      if (cropped != null)
        _image = cropped;
      else
        _image = null;
    });
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage();
      } else {
        print('No image was selected');
      }
    });
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Consumer<User>(
              builder: (context, user, child) => Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: getImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          shape: BoxShape.circle,
                          image: (user.image != "")
                              ? DecorationImage(
                                  image: FileImage(File(user.image)),
                                  fit: BoxFit.contain)
                              : (_image != null)
                                  ? DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image:
                                          AssetImage("assets/img/account.png"),
                                      fit: BoxFit.cover)),
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.add),
                    ),
                  ),
                  columnPadding,
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        (widget.edit)
                            ? TextFormField(
                                initialValue: user.username,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    user.username = value;
                                    return null;
                                  }
                                  return "Please input your user name";
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                ),
                              )
                            : SizedBox(),
                        columnPadding,
                        TextFormField(
                          initialValue: user.firstName,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          validator: (value) {
                            if (value.isNotEmpty) {
                              user.firstName = value;
                              return null;
                            }
                            return "Please input your first name";
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "First Name",
                          ),
                        ),
                        columnPadding,
                        TextFormField(
                          initialValue: user.lastName,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isNotEmpty) {
                              user.lastName = value;
                              return null;
                            }
                            return "Please input your last name";
                          },
                          decoration: InputDecoration(
                            labelText: "Last Name",
                          ),
                        ),
                        columnPadding,
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Country",
                          ),
                          value: (user.country != "") ? user.country : _sValue,
                          items: List.generate(
                            50,
                            (index) => DropdownMenuItem(
                              child: Text('Country $index'),
                              value: "Country $index",
                            ),
                          ),
                          onChanged: (value) {
                            _sValue = value;
                            user.country = value;
                          },
                        ),
                        columnPadding,
                        DropdownButtonFormField<String>(
                          decoration:
                              InputDecoration(labelText: "Preferred Language"),
                          value: (user.preferredLanguage != "")
                              ? user.preferredLanguage
                              : _tValue,
                          items: [
                            DropdownMenuItem(
                              child: Text("None"),
                              value: "None",
                            ),
                            DropdownMenuItem(
                              child: Text("Python"),
                              value: "Python",
                            ),
                            DropdownMenuItem(
                              child: Text("Java"),
                              value: "Java",
                            ),
                            DropdownMenuItem(
                              child: Text("C++"),
                              value: "C++",
                            ),
                            DropdownMenuItem(
                              child: Text("C#"),
                              value: "C#",
                            ),
                            DropdownMenuItem(
                              child: Text("JavaScript"),
                              value: "JavaScript",
                            ),
                          ],
                          onChanged: (value) {
                            _tValue = value;
                            user.preferredLanguage = value;
                          },
                        ),
                        columnPadding,
                        TextFormField(
                          initialValue: user.bio,
                          maxLines: 5,
                          validator: (value) {
                            if (value.isNotEmpty) {
                              user.bio = value;
                              return null;
                            }
                            return "Please input something about you";
                          },
                          decoration: InputDecoration(
                            labelText: "Bio",
                          ),
                        ),
                        columnPadding,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5),
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Consumer<User>(
                builder: (context, user, child) {
                  return RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        if (_userImagePath != '' && _userImagePath != null) {
                          user.image = _userImagePath;
                        }
                        if (widget.edit) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(context,
                              customTransition(CongratsCompletePage()));
                        }
                      }
                    },
                    child: Text(
                      (widget.edit)
                          ? "Update Profile"
                          : "Complete your Profile",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
            (!widget.edit)
                ? TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text("Skip, I'll do this later"),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CongratsCompletePage extends StatelessWidget {
  const CongratsCompletePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.checkCircle,
              size: 100,
              color: Colors.green,
            ),
            columnPadding,
            AutoSizeText(
              "Congrats on Completing your profile",
              minFontSize: 24,
            ),
            columnPadding,
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 135,
//                                   child: DropdownButtonFormField<int>(
//                                     value: _value,
//                                     items: [
//                                       DropdownMenuItem(
//                                         child: Text("+234"),
//                                         value: 0,
//                                       ),
//                                       DropdownMenuItem(
//                                         child: Text("+001"),
//                                         value: 1,
//                                       ),
//                                       DropdownMenuItem(
//                                         child: Text("+111"),
//                                         value: 2,
//                                       )
//                                     ],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _value = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: TextFormField(
//                                     onEditingComplete: () =>
//                                         FocusScope.of(context).nextFocus(),
//                                     keyboardType: TextInputType.number,
//                                     validator: (value) {
//                                       if (value.isNotEmpty &&
//                                           value.contains(r'[/d]{8, 11}')) {
//                                         user.phoneNumber = value;
//                                         return null;
//                                       }
//                                       return "Please input your Phone number";
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: "Phone Number",
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

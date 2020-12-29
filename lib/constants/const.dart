import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password is too weak");
    } else if (e.code == "email-already-in-use") {
      print("The email has been taken");
    }
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> register(String email, String password, String username) async {
  try {
    final currentUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await currentUser.user.updateProfile(displayName: username);
    FirebaseAuth.instance.currentUser.reload();
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password is too weak");
    } else if (e.code == "email-already-in-use") {
      print("The email has been taken");
    }
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Widget changingIcon(bool valid) {
  if (valid) {
    return Icon(
      Icons.visibility,
    );
  } else {
    return Icon(
      Icons.visibility_off,
    );
  }
}

enum SearchType { name, author, tag }

Future<String> readFile(String path) async {
  return await File(path).readAsString();
}

class CheckboxTile extends StatefulWidget {
  final String title;
  final Color color;
  const CheckboxTile({
    @required this.title,
    @required this.color,
    Key key,
  }) : super(key: key);

  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _checked,
      onChanged: (bool value) {
        setState(() {
          _checked = !_checked;
        });
      },
      activeColor: widget.color,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        widget.title,
      ),
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                contentPadding: const EdgeInsets.all(0),
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

class CustomTimer {
  // creates the stream controller
  final _controller = StreamController<int>();
  // the number you want to count down
  int count = 10;
  CustomTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _controller.sink.add(count);
      //logic to close the stream and stop the timer when the value has reached 0
      if (count == 0) {
        _controller.close();
        timer.cancel();
      }
      count--;
    });
  }
  // creating a getter to get the stream
  Stream<int> get stream => _controller.stream;
}

PageRouteBuilder customTransition(Widget widget) {
  Tween<Offset> offset = new Tween<Offset>(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: offset
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeIn)),
        child: child,
      );
    },
    transitionDuration: Duration(
      milliseconds: 250,
    ),
  );
}

const SizedBox columnPadding = SizedBox(
  height: 25.0,
);

bool passwordValidation(String value) {
  RegExp pattern = RegExp(r"[!@#$%^&*\d]");
  return (pattern.hasMatch(value) && value.length >= 8);
}

bool emailValidation(String value) {
  RegExp pattern = RegExp(r"\w+@\w+\.\w+");
  return (pattern.allMatches(value.toLowerCase()).length == 1);
}

bool usernameValidation(String value) {
  return value.isNotEmpty;
}

final Map<String, Color> colors = const {
  "purple": Colors.deepPurple,
  "blue": Colors.blue,
  "pink": Colors.pink,
  "indigo": Colors.indigo,
  "orange": Colors.orange,
  "amber": Colors.amber,
  "cyan": Colors.cyan,
  "green": Colors.green,
  "red": Colors.red,
  "teal": Colors.teal,
};

const List<String> colorKeys = [
  "purple",
  "blue",
  "pink",
  "indigo",
  "orange",
  "amber",
  "cyan",
  "green",
  "red",
  "teal"
];

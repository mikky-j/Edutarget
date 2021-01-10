import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_edutarget/models/forum_post.dart';

const Map<String, LinearGradient> linearGradients = {
  'red': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.red,
        Color(0xFFE57373),
      ]),
  'blue': LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xff1488cc),
      Color(0xff2b32b2),
    ],
  ),
  'purple': LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xfffbc2eb),
        Color(0xffa18cd1),
      ])
};

String formatNumber(int number) {
  if (number >= 1000)
    return "${(number / 1000).toStringAsFixed(1)}K";
  else if (number >= 1000000)
    return "${(number / 1000000).toStringAsFixed(1)}M";
  else if (number >= 1000000000)
    return "${(number / 1000000000).toStringAsFixed(1)}B";
  return "$number";
}

ForumPost posts = ForumPost(
  name: "Random Programming Question",
  comments: 2500,
  likes: 1555,
  views: 5000,
  userName: "Random User",
  post:
      "This is a dumb question from a noob programmer. I ask Dami all the questions because he is a literal god when it comes to programming.\n This is just some more text to test the overflow",
  tags: ["Programming", "Flutter", "Noob"],
);

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
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      Color activeColor = Colors.deepPurple})
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
                activeColor: activeColor,
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

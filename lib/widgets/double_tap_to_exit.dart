import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleTapToExit extends StatelessWidget {
  final Widget child;
  DoubleTapToExit({Key key, this.child}) : super(key: key);

  DateTime currentBackPressTime;

  Future<bool> _onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap again to exit",
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).textTheme.bodyText1.color);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child, onWillPop: () => _onWillPop(context));
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreeen extends StatefulWidget {
  final int seconds;
  final double width, height;
  final String routeName;
  final Color backgroundColor;
  final Widget child;
  const SplashScreeen({
    Key key,
    @required this.seconds,
    @required this.routeName,
    @required this.backgroundColor,
    @required this.child,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    Timer(Duration(seconds: widget.seconds), () {
      Navigator.pushReplacementNamed(context, widget.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: widget.child,
                  ),
                ),
              ),
              // const Padding(
              //   padding: const EdgeInsets.only(bottom: 50.0),
              //   child: CircularProgressIndicator(
              //     backgroundColor: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

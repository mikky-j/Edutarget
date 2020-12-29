import 'package:flutter/material.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.5,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: FlatButton(
                      onPressed: () => print("hello"),
                      child: Text("Click me"),
                    ),
                  ),
                  Container(
                    height: size.height * 0.5,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

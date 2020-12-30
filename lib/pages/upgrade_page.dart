import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              child: Container(
                child: Column(
                  children: <Widget>[
                    UpgradePageHeading(size: size),
                    Container(
                      height: size.height * 0.5,
                    ),
                  ],
                ),
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

class UpgradePageHeading extends StatelessWidget {
  const UpgradePageHeading({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.trophy,
            size: 56,
            color: Colors.amber,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Edutarget Pro",
            style: Theme.of(context).textTheme.headline4,
          ),
          Text("Start a free trial today"),
        ],
      ),
    );
  }
}

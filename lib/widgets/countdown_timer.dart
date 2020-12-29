import 'package:flutter/material.dart';

class CountDownTimer extends StatelessWidget {
  final Stream<String> stream;
  const CountDownTimer({
    this.stream,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == '00:00') {
            print("done");
          }
          return Text(snapshot.data);
        }
        return Text('');
      },
    );
  }
}

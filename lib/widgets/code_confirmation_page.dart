import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/widgets/countdown_timer.dart';

import 'change_password_page.dart';

class CodeConfirmationPage extends StatelessWidget {
  final String email;
  CodeConfirmationPage({
    Key key,
    @required this.email,
  }) : super(key: key);

  final Stream<String> stream = CustomTimer().stream.map((e) {
    int min = e ~/ 60; // this is the same as saying (e/60).toInt()
    int sec = e % 60;
    String ssmin = (min < 10) ? '0$min' : '$min';
    String ssec = (sec < 10) ? '0$sec' : '$sec';
    return '$ssmin:$ssec';
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              "Input Confirmation Code",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
              "We have sent a confirmation code to \"$email\"",
              maxLines: 2,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey[100],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Code",
              ),
            ),
            CountDownTimer(
              stream: stream,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    customTransition(
                      ChangePasswordPage(),
                    ),
                  );
                },
                icon: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                label: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

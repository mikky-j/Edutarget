import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  final bool forgot;
  const ChangePasswordPage({Key key, this.forgot = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                (forgot) ? "Create a new Password" : "Change your Password",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: 20.0,
              ),
              AutoSizeText(
                "Your new password must different from your old one",
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                child: Column(
                  children: [
                    Visibility(
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Enter Old Password"),
                      ),
                      visible: !forgot,
                    ),
                    SizedBox(
                      height: (!forgot) ? 20.0 : 0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/signin');
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

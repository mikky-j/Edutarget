import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/widgets/code_confirmation_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    String email;
    return GestureDetector(
      child: Scaffold(
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Reset Password",
                  style: text.headline5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                AutoSizeText(
                  "Enter the email associated with your account and we'll send an email with instructions to reset your password",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[100],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (!emailValidation(value)) {
                      return "Please Enter A valid Email";
                    }
                    email = value;
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email Address",
                  ),
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
                          CodeConfirmationPage(
                            email: email,
                          ),
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
        ),
      ),
    );
  }
}

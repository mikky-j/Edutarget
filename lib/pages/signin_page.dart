import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/user.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool obscured = true;
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    _tapGestureRecognizer = TapGestureRecognizer();
    super.initState();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    Size size = MediaQuery.of(context).size;
    TextTheme text = Theme.of(context).textTheme;
    _tapGestureRecognizer
      ..onTap = () => Navigator.pushReplacementNamed(context, '/signup');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/img/Edutarget Logo.png"),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AutoSizeText(
                    "Sign In",
                    style: text.headline5.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Consumer<User>(
                    builder: (context, user, child) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                              ),
                              validator: (value) {
                                if (value.isNotEmpty) {
                                  email = value;
                                  return null;
                                }
                                return "User does not exist";
                              },
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              obscureText: obscured,
                              validator: (value) {
                                if (value.isNotEmpty) {
                                  password = value;
                                  return null;
                                }
                                return;
                              },
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscured = !obscured;
                                    });
                                  },
                                  child: changingIcon(obscured),
                                ),
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/forgot-password'),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  CheckboxTile(
                    title: "Keep Me Signed In",
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print('$email and $password');
                          bool value = await signIn(email, password);
                          if (value)
                            // if (await signIn(email, password))
                            Navigator.pushReplacementNamed(context, '/home');
                          else
                            print("something went wrong");
                        }
                      },
                      child: Text(
                        "Sign In".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Don't Have An Account? ",
                      children: [
                        TextSpan(
                          text: "Join Now",
                          style: TextStyle(color: Colors.deepPurple),
                          recognizer: _tapGestureRecognizer,
                        ),
                      ],
                      style: text.bodyText1.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

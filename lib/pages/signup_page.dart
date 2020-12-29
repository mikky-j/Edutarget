import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/user.dart';
import 'package:new_edutarget/widgets/double_tap_to_exit.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    _tapGestureRecognizer = new TapGestureRecognizer();
    super.initState();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme text = Theme.of(context).textTheme;
    _tapGestureRecognizer
      ..onTap = () => Navigator.pushReplacementNamed(context, '/signin');
    return DoubleTapToExit(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(20.0),
              width: size.width,
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AutoSizeText(
                    "Create Your Account",
                    style: text.headline5.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  SignUpForm(),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an Account? ",
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          recognizer: _tapGestureRecognizer,
                        ),
                      ],
                      style: text.bodyText1.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) {
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insert A Name";
                  }
                  user.username = value;
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "User Name",
                ),
              ),
              columnPadding,
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (emailValidation(value)) {
                    user.email = value;
                    return null;
                  }
                  return "Please Enter a Valid Email Address";
                },
              ),
              columnPadding,
              TextFormField(
                enableInteractiveSelection: true,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                obscureText: obscured,
                validator: (value) {
                  if (passwordValidation(value)) {
                    user.password = value;
                    return null;
                  }
                  return "Password must contain a symbol and must have a length of 8";
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
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
              CheckboxFormField(
                title: Text("Accept Terms and Conditions"),
                validator: (value) =>
                    value ? null : "You must accept the Terms and Conditions",
              ),
              CheckboxFormField(
                title: Text("Email Me about Special Promotions and More"),
                // color: Theme.of(context).accentColor,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState.validate()) {
                      Navigator.pushReplacementNamed(
                          context, '/complete-account');
                    }
                  },
                  child: Text(
                    "Create Account".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

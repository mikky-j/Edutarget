import 'package:flutter/material.dart';
import 'package:new_edutarget/models/auth_service.dart';
import 'package:new_edutarget/models/shared_prefrences_helper.dart';
import 'package:new_edutarget/models/theme_notifier.dart';
import 'package:new_edutarget/models/user.dart';
import 'package:new_edutarget/pages/account_page.dart';
import 'package:new_edutarget/pages/add_question_page.dart';
import 'package:new_edutarget/pages/complete_account_page.dart';
import 'package:new_edutarget/pages/course_page.dart';
import 'package:new_edutarget/pages/forgot_password_page.dart';
import 'package:new_edutarget/pages/home_page.dart';
import 'package:new_edutarget/pages/lesson_page.dart';
import 'package:new_edutarget/pages/notification_page.dart';
import 'package:new_edutarget/pages/search_page.dart';
import 'package:new_edutarget/pages/settings_page.dart';
import 'package:new_edutarget/pages/signup_page.dart';
import 'package:new_edutarget/pages/signin_page.dart';
import 'package:new_edutarget/pages/welcome_page.dart';
import 'package:new_edutarget/widgets/splashscreen.dart';
import 'package:provider/provider.dart';
import 'constants/const.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SharedPreferencesHelper().readString("color-value"),
      initialData: "purple",
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => User()),
              ChangeNotifierProvider(
                create: (_) => ThemeNotifier(colorIndex: snapshot.data),
              ),
              Provider(create: (_) => AuthService()),
            ],
            child: MainApp(),
          );
        } else {
          return MaterialApp(
              home: Scaffold(
            body: Center(
              child: Text("Sorry an Error occured"),
            ),
          ));
        }
      },
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  Route _generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CustomTransistion(
          builder: (_) => SplashScreeen(
            seconds: 5,
            routeName: '/welcome',
            backgroundColor: Colors.deepPurple,
            child: Image.asset("assets/img/Edutarget main Logo.png"),
            height: 300,
            width: 300,
          ),
          settings: settings,
        );
      case '/home':
        return CustomTransistion(
          builder: (_) => Home(),
          settings: settings,
        );
      case '/welcome':
        return CustomTransistion(
          builder: (_) => WelcomePage(),
          settings: settings,
        );
      case '/course-page':
        return CustomTransistion(
          builder: (_) => CoursePage(),
          settings: settings,
        );
      case '/lesson-page':
        return CustomTransistion(
          builder: (_) => LessonPage(),
          settings: settings,
        );

      case '/signup':
        return CustomTransistion(
          builder: (_) => SignUpPage(),
          settings: settings,
        );
      case '/settings':
        return CustomTransistion(
          builder: (_) => SettingsPage(),
          settings: settings,
        );

      case '/signin':
        return CustomTransistion(
          builder: (_) => SignInPage(),
          settings: settings,
        );
      case '/forgot-password':
        return CustomTransistion(
          builder: (_) => ForgotPasswordPage(),
          settings: settings,
        );
      case '/account':
        return CustomTransistion(
          builder: (_) => AccountPage(),
          settings: settings,
        );
      case '/add-forum-post':
        return CustomTransistion(
          builder: (_) => AddQuestionPage(),
          settings: settings,
        );
      case '/complete-account':
        return CustomTransistion(
          builder: (_) => CompleteAccountPage(),
          settings: settings,
        );
      case '/notification':
        return CustomTransistion(
          builder: (_) => NotificationPage(),
          settings: settings,
        );
      case '/search':
        return CustomTransistion(
          builder: (_) => SearchPage(),
          settings: settings,
        );
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          ThemeData lightTheme = ThemeData.light().copyWith(
            appBarTheme: ThemeData.light().appBarTheme.copyWith(
                color: ThemeData.light().scaffoldBackgroundColor,
                iconTheme: IconThemeData(
                  color: Colors.black,
                )),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'Nunito Sans',
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                ),
            bottomSheetTheme: ThemeData.light().bottomSheetTheme.copyWith(
                  backgroundColor: Colors.transparent,
                ),
            accentColor: colors[themeNotifier.colorIndex],
            primaryColor: colors[themeNotifier.colorIndex],
            tabBarTheme: ThemeData.light().tabBarTheme.copyWith(
                  labelColor: Colors.black,
                ),
          );
          ThemeData darkTheme = ThemeData.dark().copyWith(
            appBarTheme: ThemeData.dark().appBarTheme.copyWith(
                  color: ThemeData.dark().scaffoldBackgroundColor,
                ),
            textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Nunito Sans',
                displayColor: Colors.white,
                bodyColor: Colors.white),
            bottomSheetTheme: ThemeData.dark().bottomSheetTheme.copyWith(
                  backgroundColor: Colors.transparent,
                ),
            primaryColor: colors[themeNotifier.colorIndex],
            textSelectionHandleColor: colors[themeNotifier.colorIndex],
            accentColor: colors[themeNotifier.colorIndex],
            inputDecorationTheme:
                ThemeData.dark().inputDecorationTheme.copyWith(
                      border: OutlineInputBorder(),
                    ),
          );
          return MaterialApp(
            title: 'EduTarget',
            initialRoute: '/',
            theme: lightTheme,
            onGenerateRoute: _generateRoutes,
            darkTheme: darkTheme,
            themeMode: themeNotifier.theme,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class CustomTransistion<T> extends MaterialPageRoute<T> {
  CustomTransistion({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Tween<Offset> offset = new Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    );
    return SlideTransition(
      position: offset.animate(animation),
      child: child,
    );
  }
}

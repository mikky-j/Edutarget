import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_edutarget/widgets/double_tap_to_exit.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController _controller;
  ValueNotifier _notifier;
  @override
  void initState() {
    _controller = new PageController();
    _notifier = new ValueNotifier<int>(0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _controller,
                onPageChanged: (value) {
                  _notifier.value = value;
                },
                children: [
                  CustomWelcomePage(
                    color: Colors.deepPurple[300],
                    heading: "Welcome to Edutarget",
                    subtitle: "The Home of Online Learning In Africa",
                    image: "Learning.svg",
                  ),
                  CustomWelcomePage(
                    color: Colors.pink[300],
                    heading: "Learn in comfort",
                    subtitle:
                        "Learn how to code even from the comfort of your home",
                    image: "Sitting in a chair.svg",
                  ),
                  CustomWelcomePage(
                    color: Colors.green[300],
                    heading: "Learn Anywhere",
                    subtitle:
                        "You can learn anywhere, anytime, even if you are offline",
                    image: 'Phone.svg',
                  ),
                  CustomWelcomePage(
                    color: Colors.indigo[300],
                    heading: "What are you Waiting for",
                    image: "Juggling.svg",
                    subtitle: "Join right now",
                    last: true,
                  )
                ],
              ),
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                // color: Colors.red,
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/signin'),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
            PageViewIndicator(notifier: _notifier),
          ],
        ),
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    Key key,
    @required ValueNotifier notifier,
  })  : _notifier = notifier,
        super(key: key);

  final ValueNotifier _notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CirclePageIndicator(
          currentPageNotifier: _notifier,
          itemCount: 4,
          dotColor: Colors.blueGrey[100],
          dotSpacing: 30,
          selectedDotColor: Colors.white,
        ),
      ),
    );
  }
}

class CustomWelcomePage extends StatelessWidget {
  final Color color;
  // final List<Widget> children;
  final String heading, subtitle, image;
  final bool last;
  CustomWelcomePage({
    Key key,
    @required this.color,
    // @required this.children,
    @required this.heading,
    @required this.image,
    @required this.subtitle,
    this.last = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    return Builder(
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
        color: color,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                heading,
                style: text.headline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              SizedBox(
                height: 10.0,
              ),
              AutoSizeText(
                subtitle,
                maxLines: 2,
                style: text.headline6,
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  child: SvgPicture.asset(
                    "assets/svg/" + image,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ]..addAll((last)
                ? [
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: Text("Get Started"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ]
                : const [const SizedBox()]),
          ),
        ),
      ),
    );
  }
}

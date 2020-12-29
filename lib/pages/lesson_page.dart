import 'dart:math';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/lesson.dart';

class LessonPage extends StatefulWidget {
  LessonPage({Key key}) : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  ScrollController _scrollController;
  static const double kExpandedHeight = 200;
  static const double _kBasePadding = 16;

  final ValueNotifier<double> _titlePaddingNotifier =
      ValueNotifier(_kBasePadding);

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 60.0;

    if (_scrollController.hasClients) {
      return min(
          _kBasePadding + kCollapsedPadding,
          _kBasePadding +
              (kCollapsedPadding * _scrollController.offset) /
                  (kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Lesson args = ModalRoute.of(context).settings.arguments;
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: kExpandedHeight,
              pinned: true,
              backgroundColor: args.color,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: false,
                titlePadding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                title: ValueListenableBuilder(
                  valueListenable: _titlePaddingNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: value),
                      child: Text(
                        args.name,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    );
                  },
                ),
                background:
                    Container(color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            _buildSliverPadding(context, args),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildSliverPadding(BuildContext context, Lesson lesson) {
    //   Flutter is a framework built by Google which runs on Dart Programming Language. Flutter is a fast and reliable framework used for building applications on **Android**, **IOS**, and **Web** [Beta].
    //   Flutter is so fast because it compiles directly to machine language.
    //   In this course you will learn how to write flutter code, how to create widgets, how to link directly with firebase, how to do animations and so much more. So what are you waiting for click that button below 👇
    // ";
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed(
          <Widget>[
            Text(
              lesson.description,
              style: TextStyle(fontSize: 16),
            ),
            Text(lesson.generateBody(10, 400)),
          ]..addAll([
              columnPadding,
              RaisedButton.icon(
                onPressed: () {},
                label: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                icon: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
                color: lesson.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              columnPadding,
            ]),
        ),
      ),
    );
  }
}

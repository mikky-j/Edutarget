import 'package:flutter/material.dart';
import 'package:new_edutarget/pages/account_page.dart';
import 'package:new_edutarget/pages/discover_page.dart';
import 'package:new_edutarget/pages/forum_page.dart';
import 'package:new_edutarget/widgets/double_tap_to_exit.dart';
import 'all_courses_page.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            children: [
              DiscoverPage(controller: _tabcontroller),
              AllCoursesPage(),
              ForumPage(),
              AccountPage(),
            ],
            controller: _tabcontroller,
          ),
        ),
        bottomNavigationBar: TabBar(
          indicatorWeight: 0.01,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.blueGrey,
          tabs: [
            Tab(
              icon: Icon(Icons.video_collection),
            ),
            Tab(
              icon: Icon(Icons.play_circle_fill),
            ),
            Tab(
              icon: Icon(Icons.forum_rounded),
            ),
            Tab(
              icon: Icon(Icons.account_circle),
            ),
          ],
          controller: _tabcontroller,
        ),
      ),
    );
  }
}

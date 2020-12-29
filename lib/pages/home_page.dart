import 'package:flutter/material.dart';
import 'package:new_edutarget/pages/account_page.dart';
import 'package:new_edutarget/pages/discover_page.dart';
import 'package:new_edutarget/widgets/double_tap_to_exit.dart';

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
    _tabcontroller = new TabController(length: 3, vsync: this);
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
              Container(
                color: Colors.blue,
              ),
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

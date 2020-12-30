import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/models/user.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<User>(
        builder: (context, user, child) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                // color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.pushNamed(context, "/notification");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/settings");
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  backgroundImage: (user.image != '')
                      ? FileImage(File(user.image))
                      : AssetImage('assets/img/account.png'),
                  onBackgroundImageError: (exception, stackTrace) {
                    print(exception);
                    print(stackTrace);
                  },
                  radius: 75,
                ),
              ),
              AutoSizeText(
                user.username,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              AccountHeading(
                tabController: _tabController,
              ),
            ],
          );
        },
      ),
    );
  }
}

class AccountHeading extends StatelessWidget {
  final TabController tabController;
  const AccountHeading({Key key, @required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Theme.of(context).accentColor,
      tabs: [
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.code),
        ),
        Tab(
          icon: Icon(Icons.bar_chart),
        ),
        Tab(
          icon: Icon(Icons.forum),
        ),
      ],
    );
  }
}

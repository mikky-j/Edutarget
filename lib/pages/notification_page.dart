import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "You have 1 new notification",
              style: TextStyle(fontSize: 16),
            ),
            columnPadding,
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text("You just created your Account"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

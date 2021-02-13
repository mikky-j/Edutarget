import 'package:flutter/material.dart';

class SavedForumPosts extends StatelessWidget {
  const SavedForumPosts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("You do not have any saved forum posts"),
      ),
    );
  }
}

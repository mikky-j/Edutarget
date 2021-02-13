import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';

class AddQuestionPage extends StatelessWidget {
  const AddQuestionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Forumn Post"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            columnPadding,
            TextField(
              decoration: InputDecoration(
                labelText: "Name of your post",
              ),
            ),
            columnPadding,
            TextField(
              minLines: 10,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Write your post",
              ),
            ),
            columnPadding,
            TextField(
              decoration: InputDecoration(
                labelText: "Enter some tags",
              ),
            ),
            columnPadding,
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Post"),
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

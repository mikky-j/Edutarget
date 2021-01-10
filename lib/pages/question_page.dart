import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/pages/forum_page.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Post"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          QuestionCardHeader(),
          Text(
            posts.post,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          ForumTagBar(),
          columnPadding,
          Text(
            "Replies (${formatNumber(posts.comments)})",
            style: Theme.of(context).textTheme.headline6,
          ),
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
      bottomSheet: QuestionReplySheet(),
    );
  }
}

class QuestionReplySheet extends StatelessWidget {
  const QuestionReplySheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      constraints: const BoxConstraints(maxHeight: 300),
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attachment),
            onPressed: () {},
          ),
          Expanded(
            child: const TextField(
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Reply...",
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class ForumTagBar extends StatelessWidget {
  const ForumTagBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: posts.tags
            .map(
              (e) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(right: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e,
                    style: TextStyle(),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

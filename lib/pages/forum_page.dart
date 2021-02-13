import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/main.dart';
import 'package:new_edutarget/pages/question_page.dart';
import 'package:new_edutarget/pages/saved_posts.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ForumPageTItle(text: "C++"),
            ForumPageHeader(),
            ForumTagBar(),
            columnPadding,
            const ForumHeading(
              title: "Popular Topics",
            ),
            TopicCardList(),
            columnPadding,
            const ForumHeading(
              title: "Trending Posts",
            ),
            QuestionCard(),
            QuestionCard(),
            QuestionCard(),
            QuestionCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.pushNamed(context, '/add-forum-post');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ForumPageTItle extends StatelessWidget {
  final String text;
  const ForumPageTItle({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class ForumPageHeader extends StatelessWidget {
  const ForumPageHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: ForumSearchBar(),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(context, customTransition(SavedForumPosts()));
            },
          ),
        ],
      ),
    );
  }
}

class TopicCardList extends StatelessWidget {
  const TopicCardList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      height: 150,
      child: ListView(
        padding: EdgeInsets.only(left: 20.0),
        scrollDirection: Axis.horizontal,
        children: [
          const ForumTopicCard(
            title: "C#",
            gradient: 'red',
          ),
          const ForumTopicCard(
            title: "Flutter",
            gradient: 'blue',
          ),
          const ForumTopicCard(
            title: "Python",
            gradient: 'purple',
          ),
          const ForumTopicCard(
            title: "C++",
          ),
          const ForumTopicCard(
            title: "JavaScript",
          ),
        ],
      ),
    );
  }
}

class ForumSearchBar extends StatelessWidget {
  const ForumSearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}

class ForumTopicCard extends StatelessWidget {
  final String title, gradient;
  final Function func;

  const ForumTopicCard({Key key, this.title, this.func, this.gradient = 'blue'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.only(right: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: linearGradients[gradient],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              "100 posts",
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForumHeading extends StatelessWidget {
  final String title;
  const ForumHeading({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          Divider(
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}

class ForumTagBar extends StatefulWidget {
  ForumTagBar({Key key}) : super(key: key);

  @override
  _ForumTagBarState createState() => _ForumTagBarState();
}

class _ForumTagBarState extends State<ForumTagBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Theme.of(context).primaryColor,
      tabs: [
        Tab(
          text: "Programming",
        ),
        Tab(
          text: "Mathematics",
        ),
        Tab(
          text: "English",
        ),
        Tab(
          text: "Physics",
        ),
        Tab(
          text: "Chemistry",
        ),
      ],
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        customTransition(
          QuestionPage(),
        ),
      ),
      child: Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionCardHeader(),
            Text(
              posts.post,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up_outlined),
                    onPressed: () {},
                    color: Colors.blueGrey[100],
                  ),
                  Text(
                    '${formatNumber(posts.likes)}',
                    style: TextStyle(
                      color: Colors.blueGrey[100],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {},
                    color: Colors.blueGrey[100],
                  ),
                  Text(
                    '${formatNumber(posts.comments)}',
                    style: TextStyle(
                      color: Colors.blueGrey[100],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {},
                    color: Colors.blueGrey[100],
                  ),
                  Text(
                    '${formatNumber(posts.views)}',
                    style: TextStyle(
                      color: Colors.blueGrey[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionCardHeader extends StatelessWidget {
  const QuestionCardHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/img/account.png"),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posts.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  posts.userName,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            height: 70,
          ),
        ),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {})
      ],
    );
  }
}

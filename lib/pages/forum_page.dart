import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ForumSearchBar(),
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
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
    return Container(
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
            "This is a dumb question from a noob programmer. I ask Dami all the questions because he is a literal god when it comes to programming. This is just some more text to test the overflow",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_outlined),
                  onPressed: () {},
                ),
                Text("12k"),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {},
                ),
                Text("2.3k"),
                IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {},
                ),
                Text("150k"),
              ],
            ),
          ),
        ],
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
                  "Some Random Question",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Some Random User",
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

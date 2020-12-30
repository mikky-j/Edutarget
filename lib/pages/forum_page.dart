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
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            //   child: Text(
            //     "Forum",
            //     style: Theme.of(context).textTheme.headline4,
            //   ),
            // ),
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
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: linearGradients[gradient],
        ),
        child: Text(title),
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
          Text(title, style: Theme.of(context).textTheme.headline5),
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
    return Card(
      color: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Text("data"),
      ),
    );
  }
}

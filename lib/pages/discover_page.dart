import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/course.dart';
import 'package:new_edutarget/models/user.dart' as localUser;
import 'package:new_edutarget/pages/search_page.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatelessWidget {
  final TabController controller;
  const DiscoverPage({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomAppBar(controller: controller),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: WelcomeMessage(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: HomeSearchBar(),
          ),
          TagBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: HomeGridView(),
          )
        ],
      ),
    );
  }
}

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.0,
      alignment: WrapAlignment.center,
      children: [
        CourseCard(
          course: Course(
              name: "Fundamentals of Mathematics",
              imageName: "assets/svg/Maths-alt.svg",
              authorName: "Damilola Oregunwa",
              color: "red"),
        ),
        CourseCard(
          course: Course(
              name: "Fundamentals of Learning",
              imageName: "assets/svg/Learning.svg",
              authorName: "Damilola Oregunwa",
              color: "green"),
        ),
        CourseCard(
          course: Course(
              name: "Fundamentals of cat",
              imageName: "assets/svg/Cool cat.svg",
              authorName: "Damilola Oregunwa",
              color: "blue"),
        ),
        CourseCard(
          course: Course(
              name: "Fundamentals of searching",
              imageName: "assets/svg/Search.svg",
              authorName: "Damilola Oregunwa",
              color: "pink"),
        ),
        CourseCard(
          course: Course(
              name: "Fundamentals of something",
              imageName: "assets/svg/Knowledge.svg",
              authorName: "Damilola Oregunwa",
              color: "amber"),
        ),
      ],
    );
  }
}

class TagBar extends StatefulWidget {
  const TagBar({Key key}) : super(key: key);

  @override
  _TagBarState createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TabBar(
        controller: _controller,
        // indicator: BoxDecoration(
        //   color: Colors.black54,
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // indicatorWeight: 0.001,
        isScrollable: true,
        indicatorColor: Theme.of(context).primaryColor,
        // // unselectedLabelColor: Colors.blueGrey,
        // labelColor: Colors.white,
        tabs: [
          Tab(
            // child: Text("hello"),
            text: "Popular",
          ),
          Tab(
            // child: Text("hello"),
            text: "Programming",
          ),
          Tab(
            // child: Text("hello"),
            text: "Flutter",
          ),
          Tab(
            // child: Text("hello"),
            text: "C-Objective",
          ),
          Tab(
            // child: Text("hello"),
            text: "JavaScript",
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({
    this.course,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(
          context,
          '/course-page',
          arguments: course,
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: course.name,
            child: Container(
              height: 250,
              width: 165,
              decoration: BoxDecoration(
                color: colors[course.color],
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: EdgeInsets.all(20.0),
            ),
          ),
          Container(
            height: 250,
            width: 165,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  course.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  course.imageName,
                  height: 150,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  final bool autofocus;
  const HomeSearchBar({
    Key key,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blueGrey[100].withOpacity(0.3),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Search",
                style: Theme.of(context).inputDecorationTheme.hintStyle,
              ),
            ),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: AutoSizeText(
        'What would \nyou like to \nlearn today?',
        maxLines: 3,
        style: TextStyle(fontSize: 32),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final TabController controller;
  const CustomAppBar({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<localUser.User>(
      builder: (context, user, child) {
        String username = user.username;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hello $username",
                style: Theme.of(context).textTheme.headline6,
              ),
              GestureDetector(
                onTap: () {
                  controller.index = 3;
                },
                child: CircleAvatar(
                  backgroundImage: (user.image != '')
                      ? FileImage(
                          File(user.image),
                        )
                      : AssetImage("assets/img/account.png"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

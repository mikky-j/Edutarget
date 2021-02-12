import 'package:flutter/material.dart';
import 'forum_page.dart';
import 'discover_page.dart';
import '../models/course.dart';
import '../constants/const.dart';

class AllCoursesPage extends StatelessWidget {
  const AllCoursesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 20),
            child: Text(
              "Courses",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ForumSearchBar(),
          const SizedBox(height: 10),
          ForumHeading(
            title: "Popular Courses",
          ),
          CourseCarousel(),
          ForumHeading(
            title: "Featured Courses",
          ),
          CourseCarousel(),
        ],
      ),
    );
  }
}

class CourseCarousel extends StatelessWidget {
  const CourseCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      margin: const EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      child: ListView.builder(
        itemCount: 12,
        padding: const EdgeInsets.only(left: 20.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return CourseCard(
            course: const Course(
                name: "Random Course",
                authorName: "Oregunwa Damilola",
                imageName: "assets/svg/Pc.svg",
                color: "pink"),
          );
        },
      ),
    );
  }
}

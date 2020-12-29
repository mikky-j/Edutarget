import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/course.dart';
import 'package:new_edutarget/models/lesson.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key key}) : super(key: key);

  List<Widget> _generateLessons(BuildContext context, int count, Color color) {
    List<Widget> widgets = [];
    for (var i = 0; i < count; i++) {
      widgets.add(
        ListTile(
          enabled: (i == 0),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/lesson-page',
              arguments: Lesson(
                name: 'Lesson ${i + 1}',
                description: "A little Description about lesson $i",
                color: color,
              ),
            );
          },
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          leading: CircularProgressIndicator(
            value: (i == 0) ? 0.1 : 0,
            backgroundColor: Theme.of(context).backgroundColor,
            valueColor: new AlwaysStoppedAnimation<Color>(color),
          ),
          // IconButton(
          //   icon: Icon(CupertinoIcons.play_arrow_solid),
          //   onPressed: () {},
          //   color: color,
          //   disabledColor: color.withOpacity(0.3),
          // ),
          title: Text("Lesson ${i + 1}"),
          subtitle: Text("A little information on Lesson ${i + 1}"),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final Course args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors[args.color],
        tooltip: "Play",
        onPressed: () {},
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colors[args.color].withOpacity(0.3),
                        ),
                        alignment: Alignment.center,
                        child:
                            Icon(Icons.arrow_back, color: colors[args.color]),
                      ),
                    ),
                    CoursePopUpMenu(args: args)
                  ],
                ),
                Text(
                  args.name,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: colors[args.color],
                      ),
                ),
                Text(
                  args.authorName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: Stack(
                    children: [
                      Hero(
                        tag: args.name,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: colors[args.color]),
                        ),
                      ),
                      SvgPicture.asset(
                        args.imageName,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Course",
                      style: Theme.of(context).textTheme.headline5,
                    )),
                    Container(
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: colors[args.color].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.book,
                            color: colors[args.color],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('10 lessons'),
                        ],
                      ),
                    )
                  ],
                ),
                ..._generateLessons(context, 10, colors[args.color])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoursePopUpMenu extends StatelessWidget {
  const CoursePopUpMenu({
    Key key,
    @required this.args,
  }) : super(key: key);

  final Course args;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 'Reset Progress':
            print("Hello");
            break;
          default:
            print("hey");
        }
      },
      itemBuilder: (context) {
        return ['Reset Progress', 'Settings']
            .map(
              (e) => PopupMenuItem(
                child: Text(e),
                value: e,
              ),
            )
            .toList();
      },
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Icon(
            Icons.more_vert,
            color: colors[args.color],
          ),
        ),
      ),
    );
  }
}

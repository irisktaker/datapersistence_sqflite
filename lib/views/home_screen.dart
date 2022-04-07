import 'package:datapersistence_sqflite/database/dbhelper.dart';
import 'package:datapersistence_sqflite/model/course_model.dart';
import 'package:datapersistence_sqflite/views/course_details_screen.dart';
import 'package:datapersistence_sqflite/views/course_update_screen.dart';
import 'package:datapersistence_sqflite/views/new_course_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Database'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewCourseScreen())),
          ),
        ],
      ),
      body: FutureBuilder(
        future: helper!.allCourses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                CourseModel course = CourseModel.fromMap(snapshot.data[i]);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("${course.name} - ${course.hours} Hours"),
                    ),
                    subtitle: Text(course.content),
                    trailing: Column(
                      children: [
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[300],
                            ),
                            onPressed: () {
                              setState(() {
                                helper!.deleteCourse(course.id);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                // helper!.deleteCourse(course.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CourseUpdateScreen(course)));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetailsScreen(course)));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

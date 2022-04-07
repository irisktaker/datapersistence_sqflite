// ignore_for_file: must_be_immutable

import 'package:datapersistence_sqflite/database/dbhelper.dart';
import 'package:datapersistence_sqflite/model/course_model.dart';
import 'package:flutter/material.dart';

class CourseUpdateScreen extends StatefulWidget {
  CourseUpdateScreen(this.course, {Key? key}) : super(key: key);

  CourseModel course;

  @override
  State<CourseUpdateScreen> createState() => _CourseUpdateScreenState();
}

class _CourseUpdateScreenState extends State<CourseUpdateScreen> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();

  DbHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    teName.text = widget.course.name;
    teContent.text = widget.course.content;
    teHours.text = widget.course.hours.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Course"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: teName),
            TextField(
              controller: teContent,
              maxLength: null,
            ),
            TextField(controller: teHours),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                var updatedCourse = CourseModel({
                  'id': widget.course.id,
                  'name': teName.text,
                  'content': teContent.text,
                  'hours': int.parse(teHours.text),
                });
                helper!.courseUpdate(updatedCourse);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

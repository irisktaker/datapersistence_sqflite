// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:datapersistence_sqflite/model/course_model.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  CourseModel? course;
  CourseDetailsScreen(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(course!.name, style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 20),
              Text(course!.content,
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 20),
              Text(course!.hours.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

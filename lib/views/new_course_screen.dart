import 'package:datapersistence_sqflite/database/dbhelper.dart';
import 'package:datapersistence_sqflite/model/course_model.dart';
import 'package:flutter/material.dart';

class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({Key? key}) : super(key: key);

  @override
  State<NewCourseScreen> createState() => _NewCourseScreenState();
}

class _NewCourseScreenState extends State<NewCourseScreen> {
  String? name, content;
  int? hours;
  DbHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('New Course')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Enter Course name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                maxLines: 10,
                decoration:
                    const InputDecoration(hintText: 'Enter Course Content'),
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Enter Course hours'),
                onChanged: (value) {
                  setState(() {
                    hours = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () async {
                  CourseModel course = CourseModel(
                    {'name': name, 'content': content, 'hours': hours},
                  );
                  int id = await helper!.createCourse(course);

                  Navigator.pop(context);
                  print("course id = $id");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'student.dart';

class ListStudentScreen extends StatefulWidget {
  @override
  _ListStudentScreenState createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Students'),
      ),
      body: students.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    students[index].name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Age: ${students[index].age}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _loadStudents() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'student_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );

    final List<Map<String, dynamic>> studentMaps =
        await database.query('students');

    setState(() {
      students = List.generate(studentMaps.length, (i) {
        return Student(
          id: studentMaps[i]['id'],
          name: studentMaps[i]['name'],
          age: studentMaps[i]['age'],
        );
      });
    });
  }
}

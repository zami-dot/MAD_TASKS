import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'liststudent.dart';
import 'searchstudent.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student Database App'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigate to the SearchStudentScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchStudentScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the ListStudentScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListStudentScreen()),
                  );
                },
                child: Text('List Students'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddStudentDialog(context); // Show the Add Student dialog
          },
          child: Icon(Icons.add),
        ));
  }

  void _showAddStudentDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await insertStudent(
                  _nameController.text,
                  int.tryParse(_ageController.text) ?? 0,
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> insertStudent(String name, int age) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'student_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );

    await database.insert(
      'students',
      {'name': name, 'age': age},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

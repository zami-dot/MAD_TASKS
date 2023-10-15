import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'student.dart';

class SearchStudentScreen extends StatefulWidget {
  @override
  _SearchStudentScreenState createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Student> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search by name'),
              onChanged: _onSearchTextChanged,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index].name),
                    subtitle: Text('Age: ${searchResults[index].age}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged(String value) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'student_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );

    final List<Map<String, dynamic>> studentMaps = await database
        .query('students', where: "name LIKE ?", whereArgs: ['%$value%']);

    setState(() {
      searchResults = List.generate(studentMaps.length, (i) {
        return Student(
          id: studentMaps[i]['id'],
          name: studentMaps[i]['name'],
          age: studentMaps[i]['age'],
        );
      });
    });
  }
}

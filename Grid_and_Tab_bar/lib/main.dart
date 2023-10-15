import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              child: const Text("Listview"),
            ),
            Tab(
              child: const Text("Gridview"),
            ),
          ]),
          leading: Icon(
            Icons.work_sharp,
            size: 40,
          ),
          title: const Text("LAb 2 App"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Person ${index + 1}"),
                    )),
            GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => Card(
                      child: Column(
                        children: [
                          Text("Person ${index + 1}"),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

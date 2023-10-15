import 'dart:html';

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
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Chats"),
            ),
            Tab(
              child: Text("Status"),
            ),
            Tab(
              child: Text("calls"),
            ),
          ]),
          title: const Text("Whatsapp"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                ),
                title: Text("Zameer ${index + 1}"),
                subtitle: const Text("Hello world"),
                trailing: const Text("10:51"),
                onTap: () {},
              ),
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                ),
                title: Text("Zameer ${index + 1}"),
                subtitle: const Text("10:51"),
                onTap: () {},
              ),
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                ),
                title: Text("Zameer ${index + 1}"),
                subtitle: const Text("10:51"),
                trailing: const Icon(Icons.call),
                onTap: () {},
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.message),
        ),
      ),
    );
  }
}

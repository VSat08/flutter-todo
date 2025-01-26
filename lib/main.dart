import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do App",
      theme: ThemeData.dark(useMaterial3: true),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void createTodo() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.all(20),
              // height: 220,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  Text(
                    "Add Task",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
        actions: [
          InkWell(
            onTap: createTodo,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Icon(
                Icons.more_vert,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Text("Hello"),
    );
  }
}

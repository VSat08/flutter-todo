import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/widgets/appbar.dart';
import 'package:todoapp/widgets/body.dart';

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
  List<String> todo = [];
  TextEditingController todoTitle = TextEditingController();

  void addTodo({required String todoTitle}) {
    if (todo.contains(todoTitle)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already Exists"),
              content: Text("This goal is already added!"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Okay"))
              ],
            );
          });
      return;
    }
    setState(() {
      todo.insert(0, todoTitle);
    });

    // print(todoTitle.text);
    updateLocalData();
    Navigator.pop(context);
  }

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
                  TextField(
                    decoration: InputDecoration(
                      // icon: Icon(Icons.golf_course_sharp),
                      contentPadding: EdgeInsets.all(10),
                      hintText: "What's your next task?",
                    ),
                    autofocus: true,
                    controller: todoTitle,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (todoTitle.text.isNotEmpty) {
                          addTodo(todoTitle: todoTitle.text);
                        }
                        todoTitle.text = "";
                      },
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

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an double value to 'decimal' key.
    await prefs.setStringList('todoList', todo);
  }

  void loadLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Save an double value to 'decimal' key.
      todo = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        createTodo: createTodo,
      ),
      body: Body(
        todo: todo,
        updateLocalData: updateLocalData,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTodo,
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }
}

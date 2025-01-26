import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final List<String> todo;
  final void Function() updateLocalData;
  const Body({super.key, required this.todo, required this.updateLocalData});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void deleteTodo({required int index}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            // height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 30,
              children: [
                Text(
                  "Delete Task",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Remove this Todo permanently?",
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.todo.removeAt(index);
                      });
                      Navigator.pop(context);
                      widget.updateLocalData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50)),
                    child: Text(
                      "yes, remove",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todo.isEmpty)
        ? Center(child: Text("List Empty"))
        : Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: widget.todo.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        setState(() {
                          widget.todo.removeAt(index);
                        });
                        widget.updateLocalData();
                      }
                    },
                    background: Container(
                      color: Colors.redAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.done),
                          )
                        ],
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Border radius here
                      ),
                      onTap: () {
                        deleteTodo(index: index);
                      },
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        widget.todo[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() createTodo;
  const MyAppBar({super.key, required this.createTodo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Todo",
        style: TextStyle(fontSize: 40),
      ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

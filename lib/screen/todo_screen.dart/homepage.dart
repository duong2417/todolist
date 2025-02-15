import 'package:flutter/material.dart';

import 'todo_list_container.dart';
import 'header.dart';

const DARK_MODE= Colors.green;
class TodoSCREEN extends StatefulWidget {
  const TodoSCREEN({super.key});

  @override
  State<TodoSCREEN> createState() => _TodoSCREENState();
}

class _TodoSCREENState extends State<TodoSCREEN> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:const EdgeInsets.all(10),
          child: Column(
            children: const [
               HEADER(),
             TodoListCONTAINER(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/models/task.dart';

class NotifiedPage extends StatelessWidget {
  final Task task;

  const NotifiedPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          task.title!,
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(task.note!),
        ),
      ),
    );
  }
}

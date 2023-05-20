import 'package:get/get.dart';
import 'package:to_do_app/src/db/db_helper.dart';
import 'package:to_do_app/src/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> task = await DbHelper.query();
    taskList.assignAll(task.map((data) => Task.fromJson(data)).toList());
  }
}

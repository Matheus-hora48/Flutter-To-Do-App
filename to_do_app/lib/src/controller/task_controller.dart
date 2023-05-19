import 'package:get/get.dart';
import 'package:to_do_app/src/db/db_helper.dart';
import 'package:to_do_app/src/models/task.dart';

class TaskController extends GetxController { 
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }
}
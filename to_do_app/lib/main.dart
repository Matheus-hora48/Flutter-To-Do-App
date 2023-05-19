import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/src/db/db_helper.dart';
import 'package:to_do_app/src/shared/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

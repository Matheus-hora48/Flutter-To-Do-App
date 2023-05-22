import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/controller/task_controller.dart';
import 'package:to_do_app/src/models/task.dart';
import 'package:to_do_app/src/pages/add_taks_bar.dart';
import 'package:to_do_app/src/pages/widget/buttons.dart';
import 'package:to_do_app/src/shared/services/theme_services.dart';

import 'widget/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();
  File? _userImage;

  final _taskController = Get.put(TaskController());

  final GetStorage _localStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadUserImage();
    _taskController.getTasks();
  }

  void _loadUserImage() {
    final String imagePath = _localStorage.read('user_image') ?? '';
    if (imagePath.isNotEmpty) {
      setState(() {
        _userImage = File(imagePath);
      });
    }
  }

  void _saveUserImage(String imagePath) {
    _localStorage.write('user_image', imagePath);
  }

  String getData(DateTime date) {
    initializeDateFormatting();
    return DateFormat.MMMMd('pt_BR').format(date);
  }

  Future<void> _selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userImage = File(pickedImage.path);
      });
      _saveUserImage(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(
            height: 10,
          ),
          showTask(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  Widget showTask() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, _taskController.taskList[index]);
                        },
                        child: TaskTile(
                          _taskController.taskList[index],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: 'Completar task',
                    onTap: () {
                      Get.back();
                    },
                    color: Theme.of(context).colorScheme.primary,
                    context: context,
                  ),
            _bottomSheetButton(
              label: 'Deletar Task',
              onTap: () {
                _taskController.delete(task);
                _taskController.getTasks();
                Get.back();
              },
              color: Theme.of(context).colorScheme.error,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: 'Fechar',
              onTap: () {
                Get.back();
              },
              isClose: true,
              color: Theme.of(context).colorScheme.onError,
              context: context,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required VoidCallback onTap,
    required Color color,
    required BuildContext context,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Theme.of(context).colorScheme.secondary
                : color,
          ),
          color: isClose == true ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isClose == false
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }

  Widget addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        locale: 'pt_br',
        initialSelectedDate: DateTime.now(),
        selectionColor: Theme.of(context).colorScheme.primary,
        dateTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
        dayTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
        monthTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Widget addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getData(
                  DateTime.now(),
                ),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                'Hoje',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await Get.to(
                const AddTaskPage(),
                routeName: '/addtask',
              );
              _taskController.getTasks();
            },
            child: const Text('+ Adicionar Task'),
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: [
        _userImage != null
            ? CircleAvatar(
                backgroundImage: FileImage(_userImage!),
              )
            : IconButton(
                icon: const Icon(Icons.person),
                onPressed: _selectImage,
              ),
        const SizedBox(width: 20),
      ],
    );
  }
}

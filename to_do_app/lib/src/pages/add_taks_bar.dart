import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/controller/task_controller.dart';
import 'package:to_do_app/src/models/task.dart';
import 'package:to_do_app/src/pages/widget/buttons.dart';
import 'package:to_do_app/src/pages/widget/custom_inputs.dart';
import 'package:to_do_app/src/shared/theme/others_color.g.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final titleEC = TextEditingController();
  final noteEC = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 AM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepet = "Nenhuma";
  List<String> repetList = [
    "Nenhuma",
    "Diária",
    "Semanal",
    "Mensal",
  ];

  int _selectedColor = 0;

  String getData(DateTime date) {
    initializeDateFormatting();
    return DateFormat.yMd('pt_BR').format(date);
  }

  String getTime(DateTime time) {
    initializeDateFormatting();
    return DateFormat.Hm('pt_BR').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Adicionar Tarefa',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
              ),
              CustomInputs(
                title: 'Título',
                hint: "Entre com o título",
                controller: titleEC,
              ),
              CustomInputs(
                title: 'Observação',
                hint: "Entre com as observações",
                controller: noteEC,
              ),
              CustomInputs(
                title: 'Date',
                hint: getData(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_today_rounded),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputs(
                      title: 'Hora inicial',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CustomInputs(
                      title: 'Hora final',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              CustomInputs(
                title: 'Lembrar',
                hint: '$_selectedRemind minutos',
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              CustomInputs(
                title: 'Repetir',
                hint: '$_selectedRepet',
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items:
                      repetList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepet = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPallete(),
                  ElevatedButton(
                    onPressed: () {
                      validateDate();
                    },
                    child: const Text('Criar tarefa '),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateDate() {
    if (titleEC.text.isNotEmpty && noteEC.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (titleEC.text.isEmpty || noteEC.text.isEmpty) {
      Get.snackbar(
        "Obrigatório",
        'Todos os campos são obrigatorios',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        icon: const Icon(Icons.warning_amber_rounded),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: titleEC.text,
        note: noteEC.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepet,
      ),
    );
    print(value);
  }

  colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Etiquetas',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            5,
            (int index) {
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0
                          ? OthersColors.bluishClr
                          : index == 1
                              ? OthersColors.pinkClr
                              : index == 2
                                  ? OthersColors.yellowClr
                                  : index == 3
                                      ? OthersColors.greenClr
                                      : OthersColors.purpleClr,
                      child: _selectedColor == index
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 18,
                            )
                          : Container(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          size: 20,
        ),
      ),
      actions: const [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      // locale: const Locale('pt', 'BR'),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print('Erro nas datas');
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(' ')[0]),
      ),
    );
  }
}

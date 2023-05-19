import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/pages/widget/custom_inputs.dart';
import 'package:to_do_app/src/shared/theme/others_color.g.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
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
              const CustomInputs(
                title: 'Título',
                hint: "Entre com o título",
              ),
              const CustomInputs(
                title: 'Observação',
                hint: "Entre com as observações",
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
                children: [
                  Column(
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
                          3,
                          (int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: (){
                                  
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? OthersColors.bluishClr
                                      : index == 1
                                          ? OthersColors.pinkClr
                                          : OthersColors.yellowClr,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
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

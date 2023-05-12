import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/pages/add_taks_bar.dart';
import 'package:to_do_app/src/pages/widget/buttons.dart';
import 'package:to_do_app/src/shared/services/notification_services.dart';
import 'package:to_do_app/src/shared/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   notifyHelper.initializeNotification();
  //   notifyHelper = NotifyHelper();
  // }
  String getData(DateTime date) {
    initializeDateFormatting();
    return DateFormat.MMMMd('pt_BR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(DateTime.now(),
          height: 100,
          width: 80,
          locale: 'pt_br',
          initialSelectedDate: DateTime.now(),
          selectionColor: Theme.of(context).colorScheme.primary,
          dateTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
          dayTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
          monthTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400, fontSize: 14), onDateChange: (date) {
        _selectedDate = date;
      }),
    );
  }

  addTaskBar() {
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
            onPressed: () => Get.to(
              const AddTaskPage(),
            ),
            child: const Text('+ Adicionar Task'),
          )
        ],
      ),
    );
  }

  appBar() {
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
}

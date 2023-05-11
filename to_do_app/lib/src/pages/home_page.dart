import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/src/shared/services/notification_services.dart';
import 'package:to_do_app/src/shared/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;

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
          Row(

            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getData(
                        DateTime.now(),
                      ),
                    ),
                    Text('Hoje')
                  ],
                ),
              )
            ],
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
      actions: [
        CircleAvatar(
          child: Image.asset('images/foto_minha.png'),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

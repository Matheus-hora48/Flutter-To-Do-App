import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/pages/widget/custom_inputs.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
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
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/main.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF363636),
      child: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: _buildBodyPage(),
      )),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTaskNameField(),
          _buildTaskDescriptionField(),
          _buildActionField(),
        ],
      ),
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      children: [
        Text(
          "create_task_name_label",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.87),
          ),
        ).tr(),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            // style của text khi nhập
            controller: _nameTaskTextController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: "create_task_name_place".tr(),
              hintStyle: const TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF979797),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "create_task_description_label",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffafafaf),
            ),
          ).tr(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              // style của text khi nhập
              controller: _descTaskTextController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "create_task_description_place".tr(),
                hintStyle: const TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color(0xFF979797),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionField() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/timer.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/tag.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/flag.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/send.png',
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

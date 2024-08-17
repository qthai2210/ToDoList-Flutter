import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/models/category_model.dart';
import 'package:todo_list_app/ui/category/category_list_page.dart';
import 'package:todo_list_app/ui/task_priority/task_priority_list_page.dart';
import 'package:todo_list_app/utils/enum/color_extension.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  CategoryModel? _categoryModelSelected;
  DateTime? _taskTime;
  int? _prioritySelected;

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
          if (_taskTime != null) _buildTaskDateTime(),
          if (_categoryModelSelected != null) _buildTaskCategory(),
          if (_prioritySelected != null) _buildTaskPriority(),
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
                  onPressed: () {
                    _selectTaskTime();
                  },
                  icon: Image.asset(
                    'assets/images/timer.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDialogChooseCategory();
                  },
                  icon: Image.asset(
                    'assets/images/tag.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDialogChoosePriority();
                  },
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

  Widget _buildGridCategoryItem(CategoryModel category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: category.backgroundColorHex != null
                ? HexColor(category.backgroundColorHex!)
                : const Color(0xFF363636),
            borderRadius: BorderRadius.circular(8),
          ),
          child: category.iconCodePoint != null
              ? Icon(
                  IconData(
                    category.iconCodePoint!,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: category.iconColorHex != null
                      ? HexColor(category.iconColorHex!)
                      : Colors.white,
                  size: 36,
                )
              : null,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            category.name,
            style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCategory() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "task_category_label".tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffafafaf),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _buildGridCategoryItem(_categoryModelSelected!),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskPriority() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "task_priority_label".tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xffafafaf),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff8687e7),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/flag.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    _prioritySelected.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffafafaf),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDateTime() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "task_time_label".tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffafafaf),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              _taskTime != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(_taskTime!)
                  : "task_time_place".tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffafafaf),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return const CategoryListPage();
      },
    );
    if (result != null && result is Map<String, dynamic>) {
      // parse result
      final categoryId = result['categoryId'];
      if (categoryId != null) {
        final categoryName = result['categoryName'];
        final categoryIconCodePoint = result['categoryIconCodePoint'];
        final categoryBackgroundColorHex = result['categoryBackgroundColorHex'];
        final categoryIconColorHex = result['categoryIconColorHex'];

        final categoryModel = CategoryModel(
          id: categoryId,
          name: categoryName,
          iconCodePoint: categoryIconCodePoint,
          backgroundColorHex: categoryBackgroundColorHex,
          iconColorHex: categoryIconColorHex,
        );
        setState(() {
          _categoryModelSelected = categoryModel;
        });
      } else {
        return;
      }
    } else {
      // do nothing
    }
  }

  void _showDialogChoosePriority() async {
    final result = await showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return const TaskPriorityListPage();
      },
    );
    if (result != null && result is Map<String, dynamic>) {
      // parse result
      final priority = result['priority'];
      if (priority != null) {
        setState(
          () {
            _prioritySelected = priority;
          },
        );
      } else {
        return;
      }
    }
  }

  void _selectTaskTime() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF8687E7),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (data != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8687E7),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        ),
      );
      if (time != null) {
        _taskTime = DateTime(
          data.year,
          data.month,
          data.day,
          time.hour,
          time.minute,
        );
        if (_taskTime != null) {
          setState(() {});
        }
      }
    }
  }
}

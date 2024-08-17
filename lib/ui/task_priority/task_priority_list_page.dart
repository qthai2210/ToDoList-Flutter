import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/models/category_model.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/utils/enum/color_extension.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  List<int> priorityListDataSource = [];
  final bool _isEditMode = false;
  int? _selectPriorityIndex;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        priorityListDataSource = List.generate(10, (index) => index + 1);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: _buildBodyPage());
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF363636),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChoosePriorityTitle(),
            _buildGridListPriorityItem(),
            _buildCreatePriorityButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      children: [
        Text(
          "category_list_page_title",
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
        const Divider(
          color: Color(0xFF979797),
        ),
      ],
    );
  }

  Widget _buildGridListPriorityItem() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: priorityListDataSource.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        // final isLastItem = index == priorityListDataSource.length;
        // if (isLastItem) {
        //   return _buildGridCategoryItemCreateNew();
        // }

        return _buildGridPriorityItem(priorityListDataSource[index]);
      },
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = _selectPriorityIndex == priority;
    return GestureDetector(
      onTap: () {
        setState(
          () {
            _selectPriorityIndex = priority;
          },
        );
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff8687E7) : const Color(0xFF272727),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/flag.png",
              width: 28,
              height: 28,
              fit: BoxFit.fill,
            ),
            Text(
              priority.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("common_cancel".tr(),
                style: const TextStyle(
                    color: Colors.white38, fontSize: 16, fontFamily: 'Lato')),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                "priority": _selectPriorityIndex,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              "common_save".tr(),
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Lato'),
            ),
          ),
        ],
      ),
    );
    // return SizedBox(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //     onPressed: () {},
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: const Color(0xFF8875FF),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //     ),
    //     child: Text(
    //       "add_category_create_button".tr(),
    //       style: const TextStyle(
    //         color: Colors.white,
    //         fontSize: 16,
    //       ),
    //     ),
    //   ),
    // );
  }
}

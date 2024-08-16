import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/utils/enum/color_extension.dart';

class CreateOrEditCategory extends StatefulWidget {
  const CreateOrEditCategory({super.key});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  final List<Color> _colorDataSource = [];
  Color _colorSelected = const Color(0xFFC9CC41);
  Color _iconTextColorSelected = const Color(0xFF41CCA7);
  IconData? _iconSelected;
  @override
  void initState() {
    super.initState();

    _colorDataSource.addAll([
      const Color(0xFFC9CC41),
      const Color(0xFF66CC41),
      const Color(0xFF41CCA7),
      const Color(0xFF4181CC),
      const Color(0xFF41A2CC),
      const Color(0xFFCC8441),
      const Color(0xFF9741CC),
      const Color(0xFFCC4173),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text(
          "create_category_page_title".tr(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF121212),
      body: _buildBodyBodyPageScreen(),
    );
  }

  Widget _buildBodyBodyPageScreen() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCategoryNameField(),
                _buildCategoryChooseIconField(),
                _buildCategoryChooseBackgroundColorField(),
                _buildCategoryChooseIconAndTextColorField(),
                _buildCategoryPreview(),
              ],
            ),
          ),
          _buildCancelAndCreateOrEditCategoryButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_name_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              // style của text khi nhập
              controller: _nameCategoryTextController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "create_category_form_category_name_placeholder".tr(),
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

  Widget _buildCategoryChooseIconField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_icon_label".tr()),
          GestureDetector(
            onTap: () {
              _chooseIcon();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFffffff).withOpacity(0.21),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _iconSelected != null
                    ? Icon(
                        _iconSelected,
                        color: Colors.white,
                        size: 24,
                      )
                    : Text(
                        "create_category_form_category_icon_placeholder".tr(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundColorField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,

        children: [
          _buildFieldTitle("create_category_form_category_color_label".tr()),
          GestureDetector(
            onTap: _onChooseCategoryBackgroundColor,
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: _colorSelected ?? Colors.white,
                    shape: BoxShape.circle)),
          ),
          // Container(
          //   margin: const EdgeInsets.only(right: 12),
          //   width: double.infinity,
          //   height: 36,
          //   // sử dụng listview phải cần có chiều dài và chiều rộng
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       final color = _colorDataSource.elementAt(index);
          //       final isSelected = color == _colorSelected;
          //       return GestureDetector(
          //         onTap: () {
          //           print("Choose color $color");
          //           setState(
          //             () {
          //               _colorSelected = color;
          //             },
          //           );
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.only(right: 10),
          //           width: 36,
          //           height: 36,
          //           decoration:
          //               BoxDecoration(color: color, shape: BoxShape.circle),
          //           child: isSelected
          //               ? const Icon(
          //                   Icons.check,
          //                   color: Colors.white,
          //                   size: 20,
          //                 )
          //               : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorDataSource.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconAndTextColorField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,

        children: [
          _buildFieldTitle(
              "create_category_form_category_icon_text_color_label".tr()),
          GestureDetector(
            onTap: _onChooseCategoryIconTextColor,
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: _iconTextColorSelected ?? Colors.white,
                    shape: BoxShape.circle)),
          ),
          // Container(
          //   margin: const EdgeInsets.only(right: 12),
          //   width: double.infinity,
          //   height: 36,
          //   // sử dụng listview phải cần có chiều dài và chiều rộng
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       final color = _colorDataSource.elementAt(index);
          //       final isSelected = color == _colorSelected;
          //       return GestureDetector(
          //         onTap: () {
          //           print("Choose color $color");
          //           setState(
          //             () {
          //               _colorSelected = color;
          //             },
          //           );
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.only(right: 10),
          //           width: 36,
          //           height: 36,
          //           decoration:
          //               BoxDecoration(color: color, shape: BoxShape.circle),
          //           child: isSelected
          //               ? const Icon(
          //                   Icons.check,
          //                   color: Colors.white,
          //                   size: 20,
          //                 )
          //               : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorDataSource.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFieldTitle(String titleName) {
    return Text(
      titleName,
      style: TextStyle(color: Colors.white.withOpacity(0.87), fontSize: 16),
    );
  }

  Widget _buildCancelAndCreateOrEditCategoryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 20, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Text('common_cancel'.tr(),
                style: const TextStyle(
                    color: Colors.white38, fontSize: 16, fontFamily: 'Lato')),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              _onHandleCreateCategory();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              "create_category_create_button".tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onHandleCreateCategory() async {
    try {
      final name = _nameCategoryTextController.text;
      if (name.isEmpty || _iconSelected == null) {
        _showAlert("Error", "Please fill all fields");
        return;
      }
      final backgroundColorHex = _colorSelected.toHex();
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);
      var category = CategoryRealmEntity(
        ObjectId(),
        name,
        backgroundColorHex: backgroundColorHex,
        iconCodePoint: _iconSelected?.codePoint,
        iconColorHex: _iconTextColorSelected.toHex(),
      );

      await realm.writeAsync(() {
        realm.add(category);
      });
      // save data into local storage
      // refresh data

      _showAlert("Success", "Create category successfully");
      _nameCategoryTextController.clear();
      setState(() {
        _iconSelected = null;
        _colorSelected = const Color(0xFFC9CC41);
        _iconTextColorSelected = const Color(0xFF41CCA7);
      });
    } catch (e) {
      print(e);
      _showAlert("Error", "Create category failed");
    }
  }

  Future<void> _chooseIcon() async {
    IconData? icon =
        await showIconPicker(context, iconPackModes: [IconPack.material]);
    setState(() {
      _iconSelected = icon;
    });
  }

  void _onChooseCategoryBackgroundColor() async {
    // ngoài ra còn có thể sw dụng material color picker
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorSelected,
              onColorChanged: (Color newColor) {
                setState(
                  () {
                    _colorSelected = newColor;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onChooseCategoryIconTextColor() async {
    // ngoài ra còn có thể sw dụng material color picker
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _iconTextColorSelected,
              enableLabel: true,
              onColorChanged: (Color newColor) {
                setState(
                  () {
                    _iconTextColorSelected = newColor;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_preview_label".tr()),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _colorSelected,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _iconSelected,
              color: _iconTextColorSelected,
              size: 36,
            ),
          ),
          Text(
            _nameCategoryTextController.text,
            style: TextStyle(
              color: _iconTextColorSelected,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

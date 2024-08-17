import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_list_app/entities/category_realm_entity.dart';
import 'package:todo_list_app/models/category_model.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/utils/enum/color_extension.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final List<CategoryModel> categoryListDataSource = [];
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _getCategoryList();
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
            _buildChooseCategoryTitle(),
            _buildListCategoryItem(),
            _buildCreateCategoryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
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

  Widget _buildListCategoryItem() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoryListDataSource.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final isLastItem = index == categoryListDataSource.length;
        if (isLastItem) {
          return _buildGridCategoryItemCreateNew();
        }
        final category = categoryListDataSource.elementAt(index);
        return _buildGridCategoryItem(category);
      },
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandlerCategoryItem(category);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: category.backgroundColorHex != null
                  ? HexColor(category.backgroundColorHex!)
                  : const Color(0xFF363636),
              //borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isEditMode ? Colors.amber : Colors.transparent,
                width: _isEditMode ? 2 : 0,
              ),
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
              category.name ?? "",
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _goToCreateCategoryPage();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF80ff01),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xff00a369),
              size: 36,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              "Create New",
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 107),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Text("common_cancel".tr(),
                style: const TextStyle(
                    color: Colors.white38, fontSize: 16, fontFamily: 'Lato')),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              _isEditMode = !_isEditMode;
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              _isEditMode == false
                  ? "category_list_edit_category_button".tr()
                  : "common_done".tr(),
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

  Future<void> _getCategoryList() async {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);
    final categories = realm.all<CategoryRealmEntity>();
    List<CategoryModel> categoryModels = categories.map(
      (e) {
        return CategoryModel(
            id: e.id.hexString,
            name: e.name,
            iconCodePoint: e.iconCodePoint,
            backgroundColorHex: e.backgroundColorHex,
            iconColorHex: e.iconColorHex);
      },
    ).toList();
    setState(
      () {
        categoryListDataSource.clear();
        categoryListDataSource.addAll(categoryModels);
      },
    );
  }

  void _goToCreateCategoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateOrEditCategory();
        },
      ),
    );
  }

  void _onHandlerCategoryItem(CategoryModel category) {
    if (_isEditMode) {
      // go to edit category page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateOrEditCategory(
              categoryId: category.id,
            );
          },
        ),
      );
    } else {
      Navigator.pop(
        context,
        {
          "categoryId": category.id,
          "categoryName": category.name,
          "categoryIconCodePoint": category.iconCodePoint,
          "categoryBackgroundColorHex": category.backgroundColorHex,
          "categoryIconColorHex": category.iconColorHex,
        },
      );
    }
  }
}

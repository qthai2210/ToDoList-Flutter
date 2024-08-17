// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String id;
  String name;
  int? iconCodePoint;
  String? backgroundColorHex;
  String? iconColorHex;
  CategoryModel({
    required this.id,
    required this.name,
    this.iconCodePoint,
    this.backgroundColorHex,
    this.iconColorHex,
  });
}

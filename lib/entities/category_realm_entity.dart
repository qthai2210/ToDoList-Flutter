import 'package:realm/realm.dart';

part 'category_realm_entity.realm.dart';

@RealmModel()
class $CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint; // luu icon trong flutter
  late String? backgroundColorHex;
  late String? iconColorHex;
}

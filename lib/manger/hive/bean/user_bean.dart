

import 'package:hive/hive.dart';
part 'user_bean.g.dart';//一定要注意，跟实体名称一致
@HiveType(typeId: 0)
class UserBean extends HiveObject{

  //flutter packages pub run build_runner build --delete-conflicting-outputs

  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? age;
  @HiveField(3)
  int? gender;




}

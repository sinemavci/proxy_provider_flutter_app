import 'package:hive/hive.dart';

part "member_model.g.dart";

@HiveType(typeId: 0)
class MemberModel extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  bool? marked;

  MemberModel({
    required this.email,
    required this.username,
    this.marked,
  });
}

import 'package:hive/hive.dart';

part "filter_model.g.dart";

enum FilterTypes { all, marked, unmarked }

@HiveType(typeId: 1)
class FilterModel extends HiveObject {
  @HiveField(0)
  int type;

  FilterModel({required this.type});
}

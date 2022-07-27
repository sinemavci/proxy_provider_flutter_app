import 'package:flutter/cupertino.dart';

class FilterProvider with ChangeNotifier {
  int selectedFilter = 0;

  FilterProvider();

  void selectFilter(Object? value) {
    selectedFilter = int.parse(value.toString());

    notifyListeners();
  }
}

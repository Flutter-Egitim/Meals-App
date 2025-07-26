import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;

  void setGlutenFree(bool value) {
    isGlutenFree = value;
    notifyListeners();
  }

  void setVegan(bool value) {
    isVegan = value;
    notifyListeners();
  }

  void setVegetarian(bool value) {
    isVegetarian = value;
    notifyListeners();
  }

  void setLactoseFree(bool value) {
    isLactoseFree = value;
    notifyListeners();
  }
}

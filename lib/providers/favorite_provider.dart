import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal.dart';

class FavoriteProvider with ChangeNotifier {
  static String sharedFavorite = "sharedFavorite";

  final List<Meal> _favoriteMeals = [];

  List<Meal> get favorites => List.unmodifiable(_favoriteMeals);

  void toggleFavorite(Meal meal) {
    final isExist = _favoriteMeals.any((m) => m.id == meal.id);
    if (isExist) {
      _favoriteMeals.removeWhere((m) => m.id == meal.id);
    } else {
      _favoriteMeals.add(meal);
    }
    _saveList();
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favoriteMeals.any((m) => m.id == meal.id);
  }

  Future<void> _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIdList = [];
    favorites.forEach((item) => favoriteIdList.add(item.id.toString()));
    await prefs.setStringList(sharedFavorite, favoriteIdList);
  }

  
}
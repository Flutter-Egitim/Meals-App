import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:provider/provider.dart';
import 'package:meals_app/providers/filter_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filters = Provider.of<FilterProvider>(context, listen: false);
    final filteredMeals = dummyMeals.where((meal) {
      if (!meal.categories.contains(category.id)) return false;
      if (filters.isGlutenFree && !meal.isGlutenFree) return false;
      if (filters.isVegan && !meal.isVegan) return false;
      if (filters.isVegetarian && !meal.isVegetarian) return false;
      if (filters.isLactoseFree && !meal.isLactoseFree) return false;
      return true;
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(title: category.title, meals: filteredMeals);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (var category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context, category),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

enum TabNames { filters, favorites, meals }

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  List<Map<String, dynamic>> pages = [
    {"title": "Select Category", "widget": CategoryScreen()},
    {"title": "Favorites", "widget": MealsScreen(meals: [])},
  ];

  void _setScreen(TabNames tabName) {
    switch (tabName) {
      case TabNames.filters:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => FiltersScreen()));
        break;
      case TabNames.meals:
        Navigator.of(context).pop();
        break;
      default:
    }
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex]["widget"],
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(pages[_selectedIndex]["title"]),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SettingsScreen();
                },
              ),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Meals"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}

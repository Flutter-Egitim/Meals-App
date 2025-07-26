import 'package:flutter/material.dart';
import 'package:meals_app/widget_tree.dart';

class MainDrawer extends StatelessWidget {
  final void Function(TabNames screenName) onSelectScreen;
  const MainDrawer({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(255),
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
                ],
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.fastfood),
                Text(
                  "Meals App",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen(TabNames.meals);
            },
            title: Text(
              "Meals",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            leading: Icon(
              Icons.restaurant,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen(TabNames.filters);
            },
            title: Text(
              "Filters",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            leading: Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

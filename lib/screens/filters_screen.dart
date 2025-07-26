import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meals_app/providers/filter_provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final List<_FilterOption> _filters = [
    _FilterOption('Gluten Free', 'Only include gluten-free meals.'),
    _FilterOption('Vegan', 'Only include vegan meals.'),
    _FilterOption('Vegetarian', 'Only include vegetarian meals.'),
    _FilterOption('Lactose Free', 'Only include lactose-free meals.'),
  ];

  final List<bool> _values = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filters")),
      body: ListView(
        children: List.generate(_filters.length, (index) {
          return SwitchListTile(
            title: Text(_filters[index].title),
            subtitle: Text(_filters[index].subtitle),
            value: _values[index],
            onChanged: (val) {
              setState(() {
                _values[index] = val;
              });
              final filterProvider = Provider.of<FilterProvider>(
                context,
                listen: false,
              );
              switch (index) {
                case 0:
                  filterProvider.setGlutenFree(val);
                  break;
                case 1:
                  filterProvider.setVegan(val);
                  break;
                case 2:
                  filterProvider.setVegetarian(val);
                  break;
                case 3:
                  filterProvider.setLactoseFree(val);
                  break;
              }
            },
          );
        }),
      ),
    );
  }
}

class _FilterOption {
  final String title;
  final String subtitle;
  const _FilterOption(this.title, this.subtitle);
}

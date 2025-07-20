import 'package:flutter/material.dart';

class MealItemMeatadata extends StatelessWidget {
  final String label;
  final IconData icon;

  const MealItemMeatadata({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

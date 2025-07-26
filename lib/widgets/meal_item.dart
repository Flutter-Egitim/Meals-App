import 'package:flutter/material.dart';
import 'package:meals_app/data/notifiers.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item_meatadata.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatefulWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  String get affordabilityText {
    return widget.meal.affordability.name[0].toUpperCase() +
        widget.meal.affordability.name.substring(1).toLowerCase();
  }

  String get complexityText {
    return widget.meal.complexity.name[0].toUpperCase() +
        widget.meal.complexity.name.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MealDetailsScreen(meal: widget.meal);
              },
            ),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: widget.meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(widget.meal.imageUrl),
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: favoriteListNotifier,
              builder: (context, favorites, child) {
                final isFavorite = favorites.contains(widget.meal);
                return Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      final currentFavoriteList = List<Meal>.from(
                        favoriteListNotifier.value,
                      );

                      if (isFavorite) {
                        currentFavoriteList.remove(widget.meal);
                      } else {
                        currentFavoriteList.add(widget.meal);
                      }

                      favoriteListNotifier.value = currentFavoriteList;
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorite ? Colors.pink : Colors.white,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                color: Colors.black54,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        widget.meal.title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis, // uzun bir yazı...
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMeatadata(
                          label: "${widget.meal.duration} min",
                          icon: Icons.schedule,
                        ),
                        SizedBox(width: 4),
                        MealItemMeatadata(
                          label: affordabilityText,
                          icon: Icons.attach_money,
                        ),
                        SizedBox(width: 4),
                        MealItemMeatadata(
                          label: complexityText,
                          icon: Icons.bar_chart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  String get complexityText {
    // getter to get the complexity text with the first letter capitalized
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30), // Set the border radius to make the card rounded
      ),
      clipBehavior: Clip
          .hardEdge, // Clips any content of the childe widgets that goes out of the card
      elevation: 2, // Add some elevation to give a shadow effect
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          // Stack is used to place the text on top of the image
          // we start from the bottom and go up
          children: [
            // background image
            FadeInImage(
              // FadeInImage is used to show a placeholder while the image is loading
              placeholder: MemoryImage(
                  kTransparentImage), //image provider class that takes a transparent image
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit
                  .cover, // the image is never stretched but instead cutoff and zoomed in to fit the container
              width: double.infinity, // Take the full width of the container
              height: 200, // Reduce the height of the image
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0, // how many pixels from the left it should end
              child: Container(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        softWrap: true, // wrap the text in a good looking way
                        overflow:
                            TextOverflow.fade, // how the text should overflow
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration} min'),
                          const SizedBox(width: 10),
                          MealItemTrait(
                              icon: Icons.timeline_sharp,
                              label: complexityText),
                          const SizedBox(width: 10),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityText),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

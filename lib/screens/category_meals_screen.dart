import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  const CategoryMealsScreen({super.key, this.title, required this.meals, required this.onToggleFavorite});

  final String? title; // Make the title optional
  final List<Meal> meals; // List of meals for the category
  final void Function(Meal meal) onToggleFavorite; //to forward the favorite toggle

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'No meals found for this category.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              // return ListTile(
              //   leading: CircleAvatar(
              //     backgroundImage: NetworkImage(meals[index].imageUrl),
              //   ),
              //   title: Text(meals[index].title),
              //   subtitle: Text('${meals[index].duration} minutes'),
              //   trailing:
              //       Text(meals[index].complexity.toString().split('.').last),
              // );
              return MealItem(meal: meals[index], onSelectMeal: onSelectMeal);
            },
            itemCount: meals.length,
          );

    return title != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(title!), // Meals category title
            ),
            body: content,
          )
        : content;
  }
}

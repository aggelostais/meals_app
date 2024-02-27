import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

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
              return MealItem(meal: meals[index]);
            },
            itemCount: meals.length,
          );

    return Scaffold(
      //for every screen widget it is recommended to use scaffold as the base widget
      appBar: AppBar(
        title: Text(title), // Meals category title
      ),
      body: content,
    );
  }
}

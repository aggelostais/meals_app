import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(ctx, route); // alternative syntax to the below
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryMealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    ); //pushes the new screen on top of the current screen
  }

  @override
  Widget build(BuildContext context) {
    return GridView( // for multi-screen apps use scaffold as base widget
        padding: const EdgeInsets.all(15),
        //.builder to create a grid of categories dynamically if the list is long
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // controls the layout of the grid
          // SliverGridDelegateWithMaxCrossAxisExtent is to set the number of columns
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, //spacing between columns
          mainAxisSpacing: 20, //spacing between rows
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
          for (final category in availableCategories)
            CategoryGridItem(
                category: category, onSelectCategory: _selectCategory),
        ],
    );
  }
}

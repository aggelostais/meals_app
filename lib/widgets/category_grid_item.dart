import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function(BuildContext, Category) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //makes the container clickable, adding listeners and getting visual feedback on tap
      // GestureDetector is another option with no visual feedback
      onTap: () {
        onSelectCategory(context, category);
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        //gives a lot of backgound color options
        padding: const EdgeInsets.all(15), //padding of 15 on all sides
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
        //titleLarge! tells dart that it will be defined
      ),
    );
  }
}

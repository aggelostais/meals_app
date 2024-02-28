import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: ListView(
        children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final maxHeight = 200.0;
                      final ingredientCount = meal.ingredients.length;
                      final columnCount = (ingredientCount / 2).ceil();
                      final columnHeight = constraints.maxHeight / columnCount;
        
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ingredients',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            if (columnHeight >= maxHeight)
                              Column(
                                children: [
                                  for (var i = 0; i < columnCount; i++)
                                    Row(
                                      children: [
                                        for (var j = i * 2; j < (i * 2) + 2; j++)
                                          if (j < ingredientCount)
                                            Expanded(
                                              child: Text(
                                                '\u2022 ${meal.ingredients[j]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onBackground,
                                                    ),
                                              ),
                                            ),
                                      ],
                                    ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  for (var ingredient in meal.ingredients)
                                    Text(
                                      '\u2022 $ingredient',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Card(
                child: ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(meal.steps[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

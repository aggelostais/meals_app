import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              onToggleFavorite(meal);
            },
          ),
        ],
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    for (var index = 0; index < meal.steps.length; index++)
                      Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(meal.steps[index]),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

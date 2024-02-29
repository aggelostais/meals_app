import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavoriteMeals(Meal meal) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == meal.id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
        _showInfoMessage(context, 'Removed from favorites!');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage(context, 'Added to favorites!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> pages = [
      {
        'page': CategoriesScreen(onToggleFavorite: _toggleFavoriteMeals),
        'title': 'Categories',
      },
      {
        'page': MealsScreen(
            meals: _favoriteMeals, onToggleFavorite: _toggleFavoriteMeals),
        'title': 'Your Favorites',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['title'] as String),
      ),
      body: pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex:
            _selectedPageIndex, //controls which tab will be highlighted
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

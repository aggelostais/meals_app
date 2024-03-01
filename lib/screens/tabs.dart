import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); //closes the drawer
    if (identifier == 'filters') {
      // pushReplacement: Replaces the current screen with the new screen
      // push is a generic method that takes a route and returns a Future that completes when the pushed screen is popped.
      // We define which kind of value is returned by the popped screen.
      // This will be the type of data the future will resolve in the end.
      // It is a map with Filter as the key and bool as the value.
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen( 
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        //null is not an allowed value. ?? checks if the result is null and if it is, it returns the value after.
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only the filtered meals should be passed to the CategoriesScreen to be shown.
    final availableMeals = dummyMeals.where((meal) {
      //_selectedFilters values will never be null, so we can use ! to avoid null safety checks.
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true; // the meal is returned if it passes all the checks.
    }).toList(); //toList() is used to convert the iterable to a list.

    final List<Map<String, Object>> pages = [
      {
        'page': CategoriesScreen(
          availableMeals: availableMeals,
          onToggleFavorite: _toggleFavoriteMeals,
        ),
        'title': 'Categories',
      },
      {
        'page': CategoryMealsScreen(
          meals: _favoriteMeals,
          onToggleFavorite: _toggleFavoriteMeals,
        ),
        'title': 'Your Favorites',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['title'] as String),
      ),
      body: pages[_selectedPageIndex]['page'] as Widget,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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

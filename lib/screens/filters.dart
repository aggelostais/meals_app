import 'package:flutter/material.dart';

enum Filter { //enum is a special 'class' that represents a group of constants (unchangeable variables, like final variables).
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}


class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _vegetarianFilter = false;
  bool _veganFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // as it is a new screen
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop(); //closes the drawer
      //   if (identifier == 'meals') {
      //     // Replaces the current screen with the new screen
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => const TabsScreen()));
      //   }
      // }),
      
      // To get access to the data returned from the screen, we use the onPopInvoked callback.
      // We technically disable the default behavior of the back button with canPop false.
      // By restricting the navigation the didPop value that indicates the value of navigation is false.
      // The Navigator.of(context).pop() method is executed passing the value values of the filters.
      // This time the didPop value is true.
      body: PopScope( 
        canPop: false, // disables the default behavior of popping the screen
        onPopInvoked: (bool didPop) { // if the user presses the back button, this callback will be called.
          if (didPop) return; // if the user presses the back button, we don't want to close the screen.
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilter, 
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegetarian: _vegetarianFilter,
            Filter.vegan: _veganFilter,
          });
        },
        child: Column(
          children: [
            // optimazied for being presented in a list of switches.
            SwitchListTile(
              value: _glutenFreeFilter,
              onChanged: (bool isChecked) {
                setState(() {
                  _glutenFreeFilter = isChecked;
                });
              },
              title: Text('Gluten-free',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _lactoseFreeFilter,
              onChanged: (bool isChecked) {
                setState(() {
                  _lactoseFreeFilter = isChecked;
                });
              },
              title: Text('Lactose-free',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (bool isChecked) {
                setState(() {
                  _vegetarianFilter = isChecked;
                });
              },
              title: Text('Vegetarian',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _veganFilter,
              onChanged: (bool isChecked) {
                setState(() {
                  _veganFilter = isChecked;
                });
              },
              title: Text('Vegan',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}

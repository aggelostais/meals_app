import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 40,
                  color: Color.fromARGB(186, 255, 255, 255),
                ),
                const SizedBox(width: 18),
                Text('Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: const Color.fromARGB(186, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
              ],
            ),
          ),
          ListTile(
            //outputting list context
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Meals'),
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          ListTile(
            //outputting list context
            leading: const Icon(Icons.filter_list_outlined),
            title: const Text('Filters'),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     onSelectScreen('settings');
          //     Navigator.of(context).pushReplacementNamed('/settings');
          //   },
          // ),
        ],
      ),
    );
  }
}

import 'package:course/screens/home_screens.dart';
import 'package:course/screens/notescreens.dart';
import 'package:course/screens/settings_screen.dart';
import 'package:course/widgets/tasks_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeModeChanged;
  const CustomDrawer({super.key, required this.onThemeModeChanged});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Menu"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return Homescreen(onThemeModeChanged: onThemeModeChanged);
                  },
                ),
              );
            },
            leading: const Icon(Icons.home),
            title: const Text("Home Page"),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsScreen(onThemeModeChanged: onThemeModeChanged);
                  },
                ),
              );
            },
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ContactsScreen();
                  },
                ),
              );
            },
            leading: const Icon(Icons.tour_outlined),
            title: const Text("Todo"),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return NoteScreen();
                  },
                ),
              );
            },
            leading: const Icon(Icons.note),
            title: const Text("Note"),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}

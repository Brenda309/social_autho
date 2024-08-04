import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 // Import the main.dart file to access MyApp
import '../main.dart';
import 'main_scaffold.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = value;
      prefs.setBool('isDarkMode', isDarkMode);
    });
    MyApp.of(context)?.setTheme(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (bool value) {
              _toggleTheme(value);
            },
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
    );
  }
}

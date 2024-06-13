import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveThemeMode(bool isDarkMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', isDarkMode);
}
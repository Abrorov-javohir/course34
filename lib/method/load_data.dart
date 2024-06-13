import 'package:shared_preferences/shared_preferences.dart';

Future<bool> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false;
}

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isProvider() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_type') == 'provider';
}

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? id;
  String? username;
  String? name;
  String? email;
  String? phone;

  late SharedPreferences _prefs;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSession(int val, String id, String username, String name, String email, String phone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await _initPrefs();
    await pref.setInt("value", val);
    await pref.setString("id", id);
    await pref.setString("username", username);
    await pref.setString("name", name);
    await pref.setString("email", email);
    await pref.setString("phone", phone);

  }

  Future<bool> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await _initPrefs();
    value = pref.getInt("value");
    id = pref.getString("id");
    username = pref.getString("username");
    name = pref.getString("name");
    email = pref.getString("email");
    phone = pref.getString("phone");

    return username != null;
  }

  Future<void> clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await _initPrefs();
    await _prefs.clear();

  }
}

SessionManager sessionManager = SessionManager();
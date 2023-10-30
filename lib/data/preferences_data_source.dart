import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey {
  isLaunch
}

final preferencesProvider =
    Provider<PreferencesDataSource>((ref) => PreferencesDataSource());

class PreferencesDataSource {
  PreferencesDataSource();

  Future<void> setInt(String key, int value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  Future<void> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}

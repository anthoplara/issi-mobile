import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  final _keySystem = 'isSystemMode';

  //ThemeMode get theme => _loadThemeUseSystem() ? ThemeMode.system : (_loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light);
  ThemeMode get theme => ThemeMode.light;

  bool loadThemeUseSystem() => _box.read(_keySystem) ?? false;
  bool loadThemeFromBox() => _box.read(_key) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme(String type) {
    _box.write(_keySystem, type == 'system' ? true : false);
    ThemeMode theme = type == 'dark' ? ThemeMode.dark : (type == 'light' ? ThemeMode.light : ThemeMode.system);
    _saveThemeToBox(Get.isDarkMode ? false : true);
    Get.changeThemeMode(theme);
  }
}

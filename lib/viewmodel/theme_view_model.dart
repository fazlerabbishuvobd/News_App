import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends GetxController{
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString('themeMode');

    if (savedThemeMode != null) {
      themeMode.value = ThemeMode.values.firstWhere((e) => e.toString() == savedThemeMode);
    }
  }

  void _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode.value.toString());
  }

  void changeTheme(ThemeMode newThemeMode) {
    themeMode.value = newThemeMode;
    _saveThemeMode();
  }
}
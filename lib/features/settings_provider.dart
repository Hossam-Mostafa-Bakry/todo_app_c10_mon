import 'package:flutter/material.dart';
import 'package:todo_app_c10_mon/features/settings/pages/settings_view.dart';
import 'package:todo_app_c10_mon/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {

  List<Widget> screens = [
    TaskView(),
    SettingsView(),
  ];

  int currentIndex = 0;
  ThemeMode currentTheme = ThemeMode.light;


  changeTheme(ThemeMode newTheme) {
    if(currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }
}
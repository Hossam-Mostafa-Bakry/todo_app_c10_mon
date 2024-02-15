import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/config/constants/application_theme_manager.dart';
import 'package:todo_app_c10_mon/features/layout_view.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/features/splash/pages/splash_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var vm = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: vm.currentTheme,
      theme: ApplicationThemeManager.lightTheme,
      darkTheme: ApplicationThemeManager.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LayoutView.routeName: (context) => const LayoutView(),
      },
    );
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_mon/core/services/loadin_service.dart';
import 'package:todo_app_c10_mon/features/layout_view.dart';
import 'package:todo_app_c10_mon/features/login/pages/login_view.dart';
import 'package:todo_app_c10_mon/features/register/pages/register_view.dart';
import 'package:todo_app_c10_mon/features/settings_provider.dart';
import 'package:todo_app_c10_mon/features/splash/pages/splash_view.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/config/application_theme_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );

  configLoading();
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
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}

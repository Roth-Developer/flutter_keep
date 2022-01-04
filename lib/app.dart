import 'package:flutter/material.dart';
import 'package:flutter_keep_google/core/enum/transaction_action_enum.dart';
import 'package:flutter_keep_google/presentation/screen/note.dart';

import 'package:flutter_keep_google/presentation/screen/home_screen.dart';
import 'package:get/get.dart';

import 'core/constant/app_route.dart';
import 'core/di/main_binding.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.red(),
      // locale: AppLocalization.locale,
      // fallbackLocale: AppLocalization.fallbackLocale,
      // translations: AppLocalization(),
      initialBinding: MainBinding(),
      // initialRoute: AppConfig.welcomeScreenStartUp == true
      //     ? RouteName.language
      //     : RouteName.home,
      initialRoute: AppRoute.home,
      getPages: [
        GetPage(
          name: AppRoute.home,
          page: () => const HomeScreen(),
        ),
      ],
    );
  }
}

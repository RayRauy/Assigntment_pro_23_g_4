import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/binding/initial_binding.dart';
import 'package:pro_23/router/app_page.dart';
import 'package:pro_23/translation/app_translation.dart';

import 'core/value/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      translations: AppTranslation(),

      locale: const Locale('en', 'US'),

      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitialBinding(),
      getPages: AppPage.pages,
      initialRoute: '/',
    );
  }
}

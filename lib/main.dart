import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/binding/initial_binding.dart';
import 'package:pro_23/router/app_page.dart';
import 'package:pro_23/service/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/translation/app_translation.dart';
import 'core/value/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final StorageService storageService = StorageService();

  final token = await storageService.getString('token');
  final language = await storageService.getString('language');

  Locale initialLocale;
  if (language == 'km_KH') {
    initialLocale = const Locale('km', 'KH');
  } else {
    initialLocale = const Locale('en', 'US');
  }

  runApp(
    MyApp(
      isLoggedIn: token != null && token.isNotEmpty,
      initialLocale: initialLocale,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final Locale initialLocale;
  const MyApp({super.key, required this.isLoggedIn, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        fontFamily: 'NotoSansKhmer',
      ),

      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslation(),

      initialBinding: InitialBinding(),
      getPages: AppPage.pages,
      initialRoute: isLoggedIn ? '/' : '/login',
    );
  }
}

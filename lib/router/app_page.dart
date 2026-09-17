import 'package:get/get.dart';
import 'package:pro_23/binding/post_binding.dart';
import 'package:pro_23/binding/user_binding.dart';
import 'package:pro_23/router/app_route.dart';
import 'package:pro_23/screen/auth/login_screen.dart';
import 'package:pro_23/screen/main_screen.dart';
import 'package:pro_23/screen/post/post_form_screen.dart';
import 'package:pro_23/screen/user/user_edit_screen.dart';
import 'package:pro_23/screen/user/user_list_screen.dart';

import '../binding/main_binding.dart';
import '../screen/post/post_list_screen.dart';
import '../screen/user/user_form_screen.dart';

class AppPage {
  const AppPage._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<void>(
      name: AppRoute.login,
      page: LoginScreen.new,
      transition: Transition.fadeIn,
    ),

    GetPage<void>(
      name: AppRoute.main,
      page: MainScreen.new,
      binding: MainBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoute.postList,
      page: PostListScreen.new,
      binding: PostBinding(),
    ),
    GetPage<void>(
      name: AppRoute.postForm,
      page: PostFormScreen.new,
      binding: PostBinding(),
    ),
    GetPage<void>(
      name: AppRoute.userList,
      page: UserListScreen.new,
      binding: UserBinding(),
    ),
    GetPage<void>(
      name: AppRoute.userForm,
      page: UserFormScreen.new,
      binding: UserBinding(),
    ),

    GetPage<void>(
      name: AppRoute.userEdit,
      page: UserEditScreen.new,
      binding: UserBinding(),
    ),
    // GetPage(
    //   name: AppRoute.setting,
    //   page: SettingScreen.new,
    //   binding: SettingBinding()
    // )
  ];
}
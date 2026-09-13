import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/screen/home/home_screen.dart';
import 'package:pro_23/screen/post/post_list_screen.dart';
import 'package:pro_23/screen/setting/setting_screen.dart';
import 'package:pro_23/screen/user/user_list_screen.dart';
import 'package:pro_23/screen/user/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [HomeScreen(), PostListScreen(), UserListScreen(), SettingScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        labelTextStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 17
        )),
        selectedIndex: currentIndex,
        indicatorColor:Color(0xFF5FF013),
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.white,),
            label: 'home'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article, color: Colors.white,),
            label: 'post'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person, color: Colors.white,),
            label: 'users'.tr,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: Colors.white,),
            label: 'setting'.tr ,
          ),
        ],
      ),
    );
  }
}

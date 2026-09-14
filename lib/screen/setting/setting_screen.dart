import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/value/app_color.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'setting'.tr,
          style: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 20,
            // fontWeight: FontWeight.bold,
            fontFamily: 'NotoSansKhmer',
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // Signed In Card
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Color(0xCD39A800),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent,
                      ),
                      child: Center(
                        child: Text(
                          'AD',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 24),

                    // User information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'signed_in_as'.tr,
                            style: TextStyle(
                              color: Color(0xFFF3FFFC),
                              fontSize: 17,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'admin@example.com',
                            style: TextStyle(
                              color: Color(0xFFB8E8E3),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              // =========================
              // YOUR ACCOUNT
              // =========================
              Text(
                'your_account'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 24),

              // Edit Profile
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 32,
                      color: Color(0xFF718096),
                    ),
                  ),

                  SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'edit_profile'.tr,
                          style: TextStyle(
                            color: Color(0xFF202938),
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'update_name_photo'.tr,
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: Color(0xFF94A3B8),
                  ),
                ],
              ),

              SizedBox(height: 45),

              // =========================
              // PREFERENCES
              // =========================
              Text(
                'preferences'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 25),

              // =========================
              // Language
              // =========================
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                  width: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.translate_outlined,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),

                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'language'.tr,
                      style: TextStyle(
                        color: Color(0xFF202938),
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'switch_language'.tr,
                      style: TextStyle(color: Color(0xFF718096), fontSize: 16),
                    ),
                  ],
                ),

                trailing: Text(
                  Get.locale?.languageCode == 'km' ? 'ភាសាខ្មែរ' : 'English',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansKhmer-Regular',
                  ),
                ),

                onTap: () {
                  Get.defaultDialog(
                    title: 'Select Language'.tr,

                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // =========================
                        // English
                        // =========================
                        ListTile(
                          leading: Text(
                            'EN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          title: Text(
                            'English',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansKhmer',
                            ),
                          ),

                          onTap: () {
                            Get.updateLocale(Locale('en', 'US'));

                            Get.back();
                          },
                        ),

                        // =========================
                        // Khmer
                        // =========================
                        ListTile(
                          leading: Text(
                            'KH',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          title: Text(
                            'ភាសាខ្មែរ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansKhmer',
                            ),
                          ),

                          onTap: () {
                            Get.updateLocale(Locale('km', 'KH'));

                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 35),

              // =========================
              // Connection
              // =========================
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(Icons.wifi, size: 32, color: Colors.lightGreen),
                  ),

                  SizedBox(width: 18),

                  Expanded(
                    child: Text(
                      'connection'.tr,
                      style: TextStyle(
                        color: Color(0xFF202938),
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Text(
                    'online'.tr,
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 45),

              // =========================
              // ABOUT
              // =========================
              Text(
                'about'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 25),

              // =========================
              // Version
              // =========================
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.info_outline,
                      size: 32,
                      color: Color(0xFF718096),
                    ),
                  ),

                  SizedBox(width: 18),

                  Expanded(
                    child: Text(
                      'version'.tr,
                      style: TextStyle(
                        color: Color(0xFF202938),
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Text(
                    '1.0.0',
                    style: TextStyle(color: Color(0xFF718096), fontSize: 17),
                  ),
                ],
              ),

              SizedBox(height: 50),

              // =========================
              // Logout Button
              // =========================
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE92327),
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_outlined, size: 27),

                      SizedBox(width: 10),

                      Text(
                        'logout'.tr,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

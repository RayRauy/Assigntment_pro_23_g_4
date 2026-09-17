import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/service/storage_service.dart';

import '../../controller/auth_controller.dart';
import '../../core/value/app_color.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final StorageService storageService = Get.find<StorageService>();

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
                  horizontal: 18,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xCD39A800),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent,
                      ),
                      child: Center(
                        child: Text(
                          'AD',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    // User information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'signed_in_as'.tr,
                            style: TextStyle(
                              color: Color(0xFFF3FFFC),
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            'admin@example.com',
                            style: TextStyle(
                              color: Color(0xFFB8E8E3),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // =========================
              // YOUR ACCOUNT
              // =========================
              Text(
                'your_account'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              // Edit Profile
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 26,
                      color: Color(0xFF718096),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'edit_profile'.tr,
                          style: TextStyle(
                            color: Color(0xFF202938),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'update_name_photo'.tr,
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    size: 26,
                    color: Color(0xFF94A3B8),
                  ),
                ],
              ),

              SizedBox(height: 35),

              // =========================
              // PREFERENCES
              // =========================
              Text(
                'preferences'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 18),

              // =========================
              // Language
              // =========================
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                  width: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.translate_outlined,
                      size: 24,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'switch_language'.tr,
                      style: TextStyle(color: Color(0xFF718096), fontSize: 13),
                    ),
                  ],
                ),

                trailing: Text(
                  Get.locale?.languageCode == 'km' ? 'ភាសាខ្មែរ' : 'English',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansKhmer-Regular',
                  ),
                ),

                onTap: () {
                  Get.defaultDialog(
                    title: 'Select Language'.tr,
                    titleStyle: TextStyle(fontSize: 18),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          title: Text(
                            'English',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NotoSansKhmer',
                            ),
                          ),

                          onTap: () async {
                            Get.updateLocale(const Locale('en', 'US'));
                            await storageService.saveString('language', 'en_US');

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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          title: Text(
                            'ភាសាខ្មែរ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NotoSansKhmer',
                            ),
                          ),

                          onTap: () async {
                            Get.updateLocale(const Locale('km', 'KH'));
                            await storageService.saveString('language', 'km_KH');

                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // =========================
              // Connection
              // =========================
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Icon(Icons.wifi, size: 24, color: Colors.lightGreen),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      'connection'.tr,
                      style: TextStyle(
                        color: Color(0xFF202938),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Text(
                    'online'.tr,
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // =========================
              // ABOUT
              // =========================
              Text(
                'about'.tr,
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // Version
              // =========================
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Icon(
                      Icons.info_outline,
                      size: 24,
                      color: Color(0xFF718096),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      'version'.tr,
                      style: TextStyle(
                        color: Color(0xFF202938),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Text(
                    '1.0.0',
                    style: TextStyle(color: Color(0xFF718096), fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // =========================
              // Logout Button
              // =========================
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE92327),
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_outlined, size: 22),

                      SizedBox(width: 8),

                      Text(
                        'logout'.tr,
                        style: TextStyle(
                          fontSize: 16,
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

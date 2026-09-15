import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../core/value/app_color.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({super.key});

  // @override
  // State<UserFormScreen> createState() => _UserFormScreenState();

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColor.textPrimary,
          ),
        ),
        title: Builder(
          builder: (context) {
            final bool isEdit = controller.editingUser != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'edit_user'.tr : 'create_user'.tr,
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  isEdit ? 'update_user_account'.tr : 'register_user'.tr,
                  style: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // PROFILE IMAGE
              // =========================
              Text(
                'profile_image'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                      () => Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Color(0xF0CCF8B5),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Color(0xffCBD5E1)),
                      image: controller.selectedImage.value != null
                          ? DecorationImage(
                        image: FileImage(controller.selectedImage.value!),
                        fit: BoxFit.cover,
                      )
                          : controller.existingImageUrl.value.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(
                          controller.existingImageUrl.value,
                        ),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: controller.selectedImage.value == null &&
                        controller.existingImageUrl.value.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xffECFDF5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 32,
                            color: Color(0xff44b626),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'add_profile_image'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textPrimary,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'tap_to_upload_an_image'.tr,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    )
                        : Stack(
                      children: [
                        Positioned(
                          right: 8,
                          top: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                              controller.selectedImage.value = null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26),

              // =========================
              // USERNAME
              // =========================
              Text(
                'username'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              Obx(
                    () => TextField(
                  controller: controller.usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'enter_username'.tr,
                    hintStyle: TextStyle(color: Color(0xff94A3B8)),
                    errorText: controller.usernameError.value,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Color(0xff64748B),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 17,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26),

              // =========================
              // NICKNAME
              // =========================
              Text(
                'nickname'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.nickNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'enter_nickname'.tr,
                  hintStyle: TextStyle(color: Color(0xff94A3B8)),
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: Color(0xff64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26),

              // =========================
              // PASSWORD
              // =========================
              // Text(
              //   'password'.tr,
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     color: AppColor.textPrimary,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Obx(
              //       () => TextField(
              //     controller: controller.passwordController,
              //     obscureText: true,
              //     textInputAction: TextInputAction.done,
              //     decoration: InputDecoration(
              //       hintText: 'enter_password'.tr,
              //       hintStyle: TextStyle(color: Color(0xff94A3B8)),
              //       errorText: controller.passwordError.value,
              //       prefixIcon: Icon(
              //         Icons.lock_outline,
              //         color: Color(0xff64748B),
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //       contentPadding: EdgeInsets.symmetric(
              //         horizontal: 16,
              //         vertical: 17,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(14),
              //         borderSide: BorderSide(color: Color(0xffE2E8F0)),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(14),
              //         borderSide: BorderSide(color: Color(0xffE2E8F0)),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(14),
              //         borderSide: BorderSide(
              //           color: Colors.green,
              //           width: 1.5,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 26),

              // =========================
              // ENABLED STATUS
              // =========================
              Obx(
                    () => Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xffE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Color(0xffECFDF5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.verified_user_outlined,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'enable_user'.tr,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'allow_user_access_to_system'.tr,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: controller.enabled.value,
                        activeThumbColor: Colors.white,
                        activeTrackColor: Color(0xFF4DC62E),
                        onChanged: (value) {
                          controller.enabled.value = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // =========================
              // ACTION BUTTON
              // =========================
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                      () => ElevatedButton(
                    onPressed: controller.isCreating.value ||
                        controller.isUpdating.value
                        ? null
                        : controller.editingUser == null
                        ? controller.createUser
                        : controller.updateUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.createBtt,
                      disabledBackgroundColor: Color(0xff94A3B8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isCreating.value ||
                        controller.isUpdating.value
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          controller.isCreating.value
                              ? 'creating'.tr
                              : 'updating'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.editingUser == null
                              ? Icons.person_add_outlined
                              : Icons.save_outlined,
                        ),
                        SizedBox(width: 8),
                        Text(
                          controller.editingUser == null
                              ? 'create_user'.tr
                              : 'update_user'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../core/value/app_color.dart';

class UserFormScreen extends StatelessWidget {
  const UserFormScreen({super.key});

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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  isEdit ? 'update_user_account'.tr : 'register_user'.tr,
                  style: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 12,
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                      () => Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Color(0xF0CCF8B5),
                      borderRadius: BorderRadius.circular(15),
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffECFDF5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 26,
                            color: Color(0xff44b626),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'add_profile_image'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'tap_to_upload_an_image'.tr,
                          style: TextStyle(
                            fontSize: 12,
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
              SizedBox(height: 18),

              // =========================
              // USERNAME
              // =========================
              Text(
                'username'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                    () => TextField(
                  controller: controller.usernameController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'enter_username'.tr,
                    hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14),
                    errorText: controller.usernameError.value,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Color(0xff64748B),
                      size: 22,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),

              // =========================
              // NICKNAME
              // =========================
              Text(
                'nickname'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: controller.nickNameController,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'enter_nickname'.tr,
                  hintStyle: const TextStyle(color: Color(0xff94A3B8), fontSize: 14),
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: Color(0xff64748B),
                    size: 22,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),

              // =========================
              // PASSWORD
              // =========================
              Text(
                'password'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                    () => TextField(
                  controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'enter_password'.tr,
                    hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14),
                    errorText: controller.passwordError.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xff64748B),
                      size: 22,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xffE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),

              // =========================
              // ENABLED STATUS
              // =========================
              Obx(
                    () => Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xffE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(0xffECFDF5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.verified_user_outlined,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'enable_user'.tr,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'allow_user_access_to_system'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: controller.enabled.value,
                          activeThumbColor: Colors.white,
                          activeTrackColor: Color(0xFF4DC62E),
                          onChanged: (value) {
                            controller.enabled.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // =========================
              // ACTION BUTTON
              // =========================
              SizedBox(
                width: double.infinity,
                height: 48,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isCreating.value ||
                        controller.isUpdating.value
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          controller.isCreating.value
                              ? 'creating'.tr
                              : 'updating'.tr,
                          style: TextStyle(
                            fontSize: 15,
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
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          controller.editingUser == null
                              ? 'create_user'.tr
                              : 'update_user'.tr,
                          style: TextStyle(
                            fontSize: 15,
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
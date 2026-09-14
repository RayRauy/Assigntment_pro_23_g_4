import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/post_controller.dart';
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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Builder(
          builder: (context) {
            final bool isEdit = controller.editingUser != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'Edit User' : 'Create User',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isEdit ? 'Update user account' : 'Register a new user',
                  style: const TextStyle(
                    color: Colors.black,
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
              const Text(
                'Profile Image',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
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
                      color: const Color(0xF0CCF8B5),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xffCBD5E1)),
                      image: controller.selectedImage.value != null
                          ? DecorationImage(
                              image: FileImage(controller.selectedImage.value!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: controller.selectedImage.value == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECFDF5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 32,
                                  color: Color(0xff44b626),
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'Add Profile Image',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff334155),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Tap to upload image',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff94A3B8),
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
                                    icon: const Icon(
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
              const SizedBox(height: 26),

              // =========================
              // USERNAME
              // =========================
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.usernameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter username',
                  hintStyle: const TextStyle(color: Color(0xff94A3B8)),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xff64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // =========================
              // NICKNAME
              // =========================
              const Text(
                'Nickname',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.nickNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter nickname',
                  hintStyle: const TextStyle(color: Color(0xff94A3B8)),
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                    color: Color(0xff64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // =========================
              // PASSWORD
              // =========================
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: const TextStyle(color: Color(0xff94A3B8)),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xff64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // =========================
              // ENABLED STATUS
              // =========================
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xffECFDF5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Enable User',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Allow this user to access the system',
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
                        activeTrackColor: const Color(0xFF4DC62E),
                        onChanged: (value) {
                          controller.enabled.value = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

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
                      disabledBackgroundColor: const Color(0xff94A3B8),
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
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                controller.isCreating.value
                                    ? 'Creating...'
                                    : 'Updating...',
                                style: const TextStyle(
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
                              const SizedBox(width: 8),
                              Text(
                                controller.editingUser == null
                                    ? 'Create User'
                                    : 'Update User',
                                style: const TextStyle(
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

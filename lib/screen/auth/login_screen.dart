import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/screen/main_screen.dart';

import '../../controller/auth_controller.dart';
import '../../repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Color(0xFF5FF013),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Login to your account',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Email / Username
                TextField(
                  controller: controller.usernameController,
                  // keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

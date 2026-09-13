// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/auth_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthController controller = Get.find<AuthController>();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: controller.usernameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Username',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               TextField(
//                 controller: controller.passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               Obx(() {
//                 if (controller.errorMessage.value.isNotEmpty) {
//                   return Text(controller.errorMessage.value);
//                 }
//
//                 return const SizedBox();
//               }),
//
//               const SizedBox(height: 16),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: Obx(
//                   () => ElevatedButton(
//                     onPressed: controller.isLoading.value
//                         ? null
//                         : controller.login,
//                     child: controller.isLoading.value
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : const Text('Login'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/post_controller.dart';
import '../../core/value/app_color.dart';

class PostFormScreen extends StatelessWidget {
  const PostFormScreen({super.key});

  // @override
  // State<PostFormScreen> createState() => _PostFormScreenState();

  @override
  Widget build(BuildContext context) {
  final PostController controller = Get.find<PostController>();
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
            final bool isEdit = controller.editingPost != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'Edit Post' : 'Create Post',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  isEdit
                      ? 'Update your article'
                      : 'Create a new article',
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
              // COVER IMAGE
              // =========================
              Text(
                'cover_image'.tr,
                style: const TextStyle(
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
                      color: Color(0xF0CCF8B5),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Color(0xffCBD5E1)),
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
                                  color: Color(0xffECFDF5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 32,
                                  color: Color(0xff44b626),
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                'add_cover_image'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff334155),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'tap_to_upload_image'.tr,
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
              SizedBox(height: 26),

              // =========================
              // TITLE
              // =========================
              Text(
                'title'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              const SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: controller.titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'enter_post_title'.tr,
                    hintStyle: const TextStyle(color: Color(0xff94A3B8)),
                    errorText: controller.titleError.value,
                    prefixIcon: const Icon(
                      Icons.title_rounded,
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
              ),

              const SizedBox(height: 26),

              // =========================
              // CONTENT
              // =========================
              Text(
                'content'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              const SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: controller.contentController,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'write_your_post_content'.tr,
                    hintStyle: const TextStyle(color: Color(0xff94A3B8)),
                    errorText: controller.contentError.value,
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16),
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
              ),

              const SizedBox(height: 26),

              // =========================
              // PUBLISH
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
                          Icons.public,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'publish_post'.tr,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'make_this_post_visible_to_everyone'.tr,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Switch(
                        value: controller.published.value,
                        activeThumbColor: Colors.white,
                        activeTrackColor: const Color(0xFF4DC62E),
                        onChanged: (value) {
                          controller.published.value = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // CREATE BUTTON
              // =========================
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isCreating.value ||
                            controller.isUpdating.value
                        ? null
                        : controller.editingPost == null
                        ? controller.createPost
                        : controller.updatePost,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.createBtt,
                      disabledBackgroundColor: Color(0xff94A3B8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child:
                        controller.isCreating.value ||
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
                                controller.editingPost == null
                                    ? Icons.check_circle_outline
                                    : Icons.save_outlined,
                              ),

                              const SizedBox(width: 8),

                              Text(
                                controller.editingPost == null
                                    ? 'Create Post'
                                    : 'Update Post',
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

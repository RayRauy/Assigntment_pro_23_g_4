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
          icon:  Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColor.textPrimary,
          ),
        ),

        title: Builder(
          builder: (context) {
            final bool isEdit = controller.editingPost != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'edit_post'.tr : 'create_post'.tr,
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 1),

                Text(
                  isEdit
                      ? 'update_article'.tr
                      : 'create_a_new_article'.tr,
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
          padding:  EdgeInsets.fromLTRB(16, 20, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // COVER IMAGE
              // =========================
              Text(
                'cover_image'.tr,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              SizedBox(height: 8),

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
                            Icons.add_photo_alternate_outlined,
                            size: 26,
                            color: Color(0xff44b626),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'add_cover_image'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff334155),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'tap_to_upload_image'.tr,
                          style: TextStyle(
                            fontSize: 12,
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
                              icon:  Icon(
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
              // TITLE
              // =========================
              Text(
                'title'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              SizedBox(height: 8),
              Obx(
                    () => TextField(
                  controller: controller.titleController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'enter_post_title'.tr,
                    hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14),
                    errorText: controller.titleError.value,
                    prefixIcon: Icon(
                      Icons.title_rounded,
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
              // CONTENT
              // =========================
              Text(
                'content'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              SizedBox(height: 8),
              Obx(
                    () => TextField(
                  controller: controller.contentController,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'write_your_post_content'.tr,
                    hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14),
                    errorText: controller.contentError.value,
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(12),
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
              // PUBLISH
              // =========================
              Obx(
                    () => Container(
                  padding:  EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:  Color(0xffE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color:  Color(0xffECFDF5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Icon(
                          Icons.public,
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
                              'publish_post'.tr,
                              style:  TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                            ),

                            SizedBox(height: 2),

                            Text(
                              'make_this_post_visible_to_everyone'.tr,
                              style:  TextStyle(
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
                          value: controller.published.value,
                          activeThumbColor: Colors.white,
                          activeTrackColor:  Color(0xFF4DC62E),
                          onChanged: (value) {
                            controller.published.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // =========================
              // CREATE BUTTON
              // =========================
              SizedBox(
                width: double.infinity,
                height: 48,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child:
                    controller.isCreating.value ||
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
                          style:  TextStyle(
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
                          controller.editingPost == null
                              ? Icons.check_circle_outline
                              : Icons.save_outlined,
                          size: 20,
                        ),

                        SizedBox(width: 8),

                        Text(
                          controller.editingPost == null
                              ? 'create_post'.tr
                              : 'update_post'.tr,
                          style:  TextStyle(
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
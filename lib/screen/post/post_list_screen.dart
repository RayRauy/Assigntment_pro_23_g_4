import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/core/value/app_color.dart';
import 'package:pro_23/model/post/post_data_model.dart';

import '../../controller/post_controller.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('post_list'.tr, style: TextStyle(color: AppColor.textPrimary)),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Obx(() {
        // Error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        // Search + Post List
        return Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: SearchBar(
                hintText: 'search_post'.tr,
                leading: Icon(Icons.search),
                onChanged: (value) {
                  controller.loadFirstPage(
                      title: value,
                      debounce: true
                  );
                },
              ),
            ),

            // Summary Counter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${controller.total}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'Showing ${controller.posts.length} of ${controller.total}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Posts
            Expanded(
              child: controller.posts.isEmpty
                  ? Center(child: Text('No post found'))
                  : RefreshIndicator(
                onRefresh: () async {
                  await controller.loadFirstPage();
                },

                child: ListView.builder(
                  controller: controller.scrollController,
                  physics: AlwaysScrollableScrollPhysics(),

                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  itemCount:
                  controller.posts.length +
                      (controller.isLoadingMore.value ? 1 : 0),

                  itemBuilder: (context, index) {
                    // Pagination Loading
                    if (index == controller.posts.length) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final Data post = controller.posts[index];

                    // Post Card
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),

                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),

                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1.5,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: SizedBox(
                              width: 60,
                              height: 60,

                              child:
                              post.imageUrl != null &&
                                  post.imageUrl!.isNotEmpty
                                  ? Image.network(
                                post.imageUrl!,
                                fit: BoxFit.cover,

                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.teal.shade50,

                                    child: Icon(
                                      Icons.article_outlined,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                  );
                                },
                              )
                                  : Container(
                                color: Colors.teal.shade50,

                                child: Icon(
                                  Icons.article_outlined,
                                  size: 30,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          // Post Information
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                // Title
                                Text(
                                  post.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 2),

                                // Content
                                Text(
                                  post.content ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                SizedBox(height: 4),

                                // Author + Date
                                Text(
                                  'Admincode · 22 Aug 2026',

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // More Button
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.blueGrey,
                            ),

                            onSelected: (value) {
                              if (value == 'edit') {
                                controller.editPost(post);
                              }

                              if (value == 'delete') {
                                controller.confirmDeletePost(post);
                              }
                            },

                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),

                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),

      // New Post
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.startCreate();
        },

        backgroundColor: AppColor.fabBackground,

        icon: const Icon(Icons.add, color: AppColor.createBtt),

        label: Text(
          'new_post'.tr,
          style: const TextStyle(
            color: AppColor.createBtt,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
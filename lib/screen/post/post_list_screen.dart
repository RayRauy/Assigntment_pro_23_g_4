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
                            margin: EdgeInsets.only(bottom: 12),

                            padding: EdgeInsets.all(16),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),

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
                                  borderRadius: BorderRadius.circular(12),

                                  child: SizedBox(
                                    width: 80,
                                    height: 80,

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
                                                      size: 40,
                                                      color: Colors.green,
                                                    ),
                                                  );
                                                },
                                          )
                                        : Container(
                                            color: Colors.teal.shade50,

                                            child: Icon(
                                              Icons.article_outlined,
                                              size: 40,
                                              color: Colors.green,
                                            ),
                                          ),
                                  ),
                                ),

                                SizedBox(width: 16),

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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(height: 6),

                                      // Content
                                      Text(
                                        post.content ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,

                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),

                                      SizedBox(height: 8),

                                      // Author + Date
                                      Text(
                                        'Admincode · 22 Aug 2026',

                                        style: TextStyle(
                                          fontSize: 14,
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
          Get.toNamed('/posts/form');
        },

        icon: Icon(Icons.add),

        label: Text('new_post'.tr),
      ),
    );
  }
}

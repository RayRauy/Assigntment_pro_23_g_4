import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pro_23/controller/user_controller.dart';
import 'package:pro_23/model/user/user_data_model.dart';

import '../../core/value/app_color.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});


  @override
  Widget build(BuildContext context) {
  final UserController controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('user_list'.tr, style: TextStyle(color: AppColor.textPrimary)),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        // Search + User List
        return Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: SearchBar(
                hintText: 'search_user'.tr,
                leading: Icon(Icons.search),
                onChanged: (value) {
                  controller.loadFirstPage(
                    username: value,
                    debounce: true,
                  );
                },
              ),
            ),

            // User List
            Expanded(
              child: controller.users.isEmpty
                  ? Center(
                child: Text('No user found'),
              )
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
                  controller.users.length +
                      (controller.isLoadingMore.value ? 1 : 0),

                  itemBuilder: (context, index) {
                    // Pagination Loading
                    if (index == controller.users.length) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final userData user = controller.users[index];

                    // User Card
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
                          // User Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),

                            child: SizedBox(
                              width: 80,
                              height: 80,

                              child:
                              user.imageUrl != null &&
                                  user.imageUrl!.isNotEmpty
                                  ? Image.network(
                                user.imageUrl!,
                                fit: BoxFit.cover,

                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade50,
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.green,
                                    ),
                                  );
                                },
                              )
                                  : Container(
                                color: Colors.grey.shade50,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 16),

                          // User Information
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                // Username
                                Text(
                                  user.username ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 6),

                                // Nickname
                                Text(
                                  user.nickName ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                SizedBox(height: 8),

                                // Status
                                Text(
                                  user.enabled == true
                                      ? 'Active'
                                      : 'Disabled',

                                  style: TextStyle(
                                    fontSize: 14,
                                    color: user.enabled == true
                                        ? Colors.green
                                        : Colors.red,
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
                                controller.editUser(user);
                              }

                              if (value == 'delete') {
                                controller.confirmDeletePost(user);
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
            )
          ],
        );
      }),

      // New Post
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.startCreate();
        },

        icon: Icon(Icons.add),

        label: Text('new_user'.tr),
      ),
    );
  }
}

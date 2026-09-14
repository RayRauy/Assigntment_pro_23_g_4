import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post/post_data_model.dart';
import '../repository/post_repository.dart';

class PostController extends GetxController {
  PostController(this._postRepo);
  final PostRepository _postRepo;

  // Form controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // State
  final RxnString titleError = RxnString();
  final RxnString contentError = RxnString();
  final isPickingImage = false.obs;
  final RxString existingImageUrl = ''.obs;
  final selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  final isDeleting = false.obs;
  final isUpdating = false.obs;
  Data? editingPost;
  final posts = <Data>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;
  final searchTerm = ''.obs;
  final published = true.obs;
  final isCreating = false.obs;


  final int size = 10;
  Timer? _searchTimer;

  int _page = 0;
  int _totalPages = 1;
  int _total = 0;

  int get total => _total;

  bool get hasMore => _page + 1 < _totalPages;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    loadFirstPage();
    scrollController.addListener(_onScroll);

    titleController.addListener(() {
      if (titleError.value != null && titleController.text.trim().isNotEmpty) {
        titleError.value = null;
      }
    });

    contentController.addListener(() {
      if (contentError.value != null && contentController.text.trim().isNotEmpty) {
        contentError.value = null;
      }
    });
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }
  //
  // void searchPost(String value) {
  //   searchTerm.value = value;
  //   _searchTimer?.cancel();
  //   _searchTimer = Timer(const Duration(microseconds: 500), () {
  //     loadFirstPage();
  //   });
  // }

  // =========================
  // Load First Page
  // =========================

  Future<void> loadFirstPage({String? title, bool debounce = false,}) async {
    searchTerm.value = title ?? searchTerm.value;

    _searchTimer?.cancel();

    if (debounce) {
      _searchTimer = Timer(
        const Duration(milliseconds: 400),
            () {
          loadFirstPage(
            title: searchTerm.value,
            debounce: false,
          );
        },
      );

      return;
    }

    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    _page = 0;
    _totalPages = 1;
    _total = 0;

    try {
      final (PostDataModel? page, String? error) =
      await _postRepo.getPageTest(
        page: 0,
        size: size,
        title: searchTerm.value,
      );

      if (error != null) {
        errorMessage.value = error;
        posts.clear();
        return;
      }

      if (page == null) {
        errorMessage.value = 'No data';
        posts.clear();
        return;
      }

      posts.assignAll(page.data ?? []);

      _applyMeta(page);
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // Load More
  // =========================

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    isLoadingMore.value = true;

    try {
      final nextPage = _page + 1;

      final (PostDataModel? page, String? error) =
      await _postRepo.getPageTest(
        page: nextPage,
        size: size,
        title: searchTerm.value,
      );

      if (error != null) {
        errorMessage.value = error;
        return;
      }

      if (page == null) {
        errorMessage.value = 'No data';
        return;
      }

      posts.addAll(page.data ?? []);

      _applyMeta(page);
    } finally {
      isLoadingMore.value = false;
    }
  }

  // =========================
  // Pagination
  // =========================

  void _applyMeta(PostDataModel page) {
    final Pagination? pagination = page.pagination;

    if (pagination == null) {
      _total = 0;
      _totalPages = 1;
      return;
    }

    _page = pagination.page ?? 0;
    _totalPages = pagination.totalPages ?? 1;
    _total = pagination.total ?? 0;

    print(
      'Pagination: '
          'page=$_page, '
          'totalPages=$_totalPages, '
          'total=$_total',
    );
  }

  // Open Edit Post

  void editPost(Data post) {
    editingPost = post;

    titleController.text = post.title ?? '';
    contentController.text = post.content ?? '';
    published.value = post.published ?? false;

    Get.toNamed('/posts/form');
  }

  // =========================
// Update Post
// =========================

  Future<void> updatePost() async {
    if (isUpdating.value) return;

    if (editingPost == null) {
      Get.snackbar(
        'Error',
        'Post not found',
      );
      return;
    }

    final int? id = editingPost!.id;

    if (id == null) {
      Get.snackbar(
        'Error',
        'Post ID not found',
      );
      return;
    }

    final title = titleController.text.trim();
    final content = contentController.text.trim();

    titleError.value = null;
    contentError.value = null;

    bool hasError = false;
    if (title.isEmpty) {
      titleError.value = 'Title is required';
      hasError = true;
    }

    if (content.isEmpty) {
      contentError.value = 'Content is required';
      hasError = true;
    }

    if (hasError) return;

    try {
      isUpdating.value = true;

      final (Data? updatedPost, String? error) =
      await _postRepo.updatePost(
        id: id,
        title: title,
        content: content,
        published: published.value,
      );

      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      if (updatedPost == null) {
        Get.snackbar(
          'Error',
          'Failed to update post',
        );
        return;
      }

      // Find old post
      final index = posts.indexWhere(
            (post) => post.id == id,
      );

      // Replace old post with updated post
      if (index != -1) {
        posts[index] = updatedPost;
      }

      // Clear editing state
      editingPost = null;

      titleController.clear();
      contentController.clear();
      published.value = true;

      Get.back();

      Get.snackbar(
        'Success',
        'Post updated successfully',
      );
    } finally {
      isUpdating.value = false;
    }
  }

  // Create Post

  Future<void> createPost() async {
    if (isCreating.value) return;

    final title = titleController.text.trim();
    final content = contentController.text.trim();

    titleError.value = null;
    contentError.value = null;

    bool hasError = false;
    if (title.isEmpty) {
      titleError.value = 'Title is required';
      hasError = true;
    }

    if (content.isEmpty) {
      contentError.value = 'Content is required';
      hasError = true;
    }

    if (hasError) return;

    try {
      isCreating.value = true;

      // =========================
      // 1. Create Post
      // =========================

      final (Data? post, String? error) =
      await _postRepo.createPost(
        title: title,
        content: content,
        published: published.value,
      );

      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      if (post == null) {
        Get.snackbar(
          'Error',
          'Failed to create post',
        );
        return;
      }

      // =========================
      // 2. Upload Image
      // =========================

      // 2. Upload Image if exists
      if (selectedImage.value != null && post.id != null) {
        final (bool success, String? uploadError) = await _postRepo.uploadPostImage(
          postId: post.id!,
          filePath: selectedImage.value!.path,
        );

        if (!success) {
          Get.snackbar(
            'Partial Success',
            'Post created, but image upload failed: ${uploadError ?? "Unknown error"}',
            duration: const Duration(seconds: 5),
          );
        }
      }


      // =========================
      // 3. Add to local list
      // =========================

      posts.insert(0, post);

      // =========================
      // 4. Clear form
      // =========================

      titleController.clear();
      contentController.clear();
      published.value = true;

      selectedImage.value = null;
      editingPost = null;

      Get.back();

      Get.snackbar(
        'Success',
        'Post created successfully',
      );
    } finally {
      isCreating.value = false;
    }
  }

  // =========================
// Delete Post
// =========================

  Future<void> deletePost(Data post) async {
    if (isDeleting.value) return;

    final int? id = post.id;

    if (id == null) {
      Get.snackbar(
        'Error',
        'Post ID not found',
      );
      return;
    }

    try {
      isDeleting.value = true;

      final (bool success, String? error) =
      await _postRepo.deletePost(
        id: id,
      );

      if (error != null) {
        Get.snackbar(
          'Error',
          error,
        );
        return;
      }

      if (!success) {
        Get.snackbar(
          'Error',
          'Failed to delete post',
        );
        return;
      }

      // Remove post from local list
      posts.removeWhere(
            (item) => item.id == id,
      );

      Get.snackbar(
        'Success',
        'Post deleted successfully',
      );
    } finally {
      isDeleting.value = false;
    }
  }

  void confirmDeletePost(Data post) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Post'),
        content: Text(
          'Are you sure you want to delete "${post.title ?? ''}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            onPressed: () {
              Get.back();
              deletePost(post);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // =========================
// Pick Image
// =========================

  Future<void> pickImage() async {
    if (isPickingImage.value) return;

    try {
      isPickingImage.value = true;
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (e is PlatformException && e.code == 'already_active') {
        // Ignore this error as it just means the picker is already open
        return;
      }
      Get.snackbar('Error', 'Failed to pick image: $e');
    } finally {
      isPickingImage.value = false;
    }
  }

  void startCreate() {
    editingPost = null;

    titleController.clear();
    contentController.clear();

    published.value = true;

    selectedImage.value = null;
    existingImageUrl.value = '';
    Get.toNamed('/posts/form');
  }

  @override
  void onClose() {
    _searchTimer?.cancel();

    scrollController.dispose();
    titleController.dispose();
    contentController.dispose();

    super.onClose();
  }
}
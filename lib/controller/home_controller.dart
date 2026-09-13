import 'package:get/get.dart';

import '../model/post/post_model.dart';
import '../model/post/slider_model.dart';


class HomeController extends GetxController {
  final banners = <SliderModel>[].obs;

  final latestPosts = <PostModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadHome();
  }

  Future<void> loadHome() async {
    isLoading.value = true;
    try {
      // Replace old data
      banners.assignAll(_fetchBanners());
      latestPosts.assignAll(_fetchLatestPosts());
    } finally {
      isLoading.value = false;
    }
  }

  List<SliderModel> _fetchBanners() {
    return <SliderModel>[
      SliderModel(
        title: 'Welcome to GetX Basic',
        subtitle: 'Learn Flutter with GetX',
        imageUrl: 'https://picsum.photos/800/400?random=1',
      ),
      SliderModel(
        title: 'Flutter Development',
        subtitle: 'Build modern mobile applications',
        imageUrl: 'https://picsum.photos/800/400?random=2',
      ),
      SliderModel(
        title: 'GetX State Management',
        subtitle: 'Simple and powerful state management',
        imageUrl: 'https://picsum.photos/800/400?random=3',
      ),
    ];
  }

  List<PostModel> _fetchLatestPosts() {
    return <PostModel>[
      PostModel(
        title: 'Getting Started with Flutter',
        imageUrl: 'https://picsum.photos/200/200?random=10',
        author: const UserModel(displayName: 'Makara'),
      ),
      PostModel(
        title: 'Understanding GetX',
        imageUrl: 'https://picsum.photos/200/200?random=11',
        author: const UserModel(displayName: 'Dara'),
      ),
      PostModel(
        title: 'Flutter Navigation',
        imageUrl: 'https://picsum.photos/200/200?random=12',
      ),
    ];
  }
}

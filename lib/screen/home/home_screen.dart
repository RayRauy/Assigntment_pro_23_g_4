import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/value/app_color.dart';
import '../../model/post/post_model.dart';
import '../../model/post/slider_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SliderModel> banners = <SliderModel>[
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

    final List<PostModel> latestPosts = <PostModel>[
      PostModel(
        title: 'Getting Started with Flutter',
        imageUrl: 'https://picsum.photos/200/200?random=10',
      ),
      PostModel(
        title: 'Understanding GetX',
        imageUrl: 'https://picsum.photos/200/200?random=11',
      ),
      PostModel(
        title: 'Flutter Navigation',
        imageUrl: 'https://picsum.photos/200/200?random=12',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('home_screen'.tr, style: TextStyle(color: AppColor.textPrimary)),
        iconTheme: IconThemeData(color: AppColor.textPrimary),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50, bottom: 8)),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Admin",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              accountEmail: Text(
                "Admin@gmail.com",
                style: TextStyle(fontSize: 20),
              ),
              currentAccountPicture: Transform.translate(
                offset: Offset(0, -30),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/Cartoon_Style_Robot.jpg'),
                  // child: Text(
                  //   "AD",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.teal,
                  //   ),
                  // ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people_alt_outlined),
              title: Text("users".tr),
              onTap: () {
                Get.toNamed('/users-list');
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt_1_outlined),
              title: Text("new_user".tr),
              onTap: () {
                Get.toNamed('/users/form');
              },
            ),

            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.language_outlined),
                    trailing: Text(
                      "english".tr,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text('language'.tr),
                    onTap: () {
                      if(Get.locale?.languageCode=='en'){
                        Get.updateLocale(Locale('km', 'KH'));
                      }else{
                        Get.updateLocale(Locale('en', 'US'));
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.signal_cellular_alt),
                    trailing: Text(
                      "online".tr,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text("connection".tr),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('logout'.tr, style: TextStyle(color: Colors.red)),
                onTap: () {
                  Get.toNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: 20, top: 20),

          children: <Widget>[
            // =========================
            // Carousel
            // =========================
            CarouselSlider(
              items: banners.map((SliderModel banner) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.greenAccent,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // =========================
                      // Image
                      // =========================
                      Image.network(
                        banner.fullImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) {
                          return Icon(
                            Icons.image_not_supported_outlined,
                            size: 40,
                          );
                        },
                      ),

                      // =========================
                      // Dark Overlay
                      // =========================
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: <Color>[Colors.transparent, Colors.black54],
                          ),
                        ),
                      ),

                      // =========================
                      // Banner Text
                      // =========================
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              banner.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            if (banner.subtitle != null &&
                                banner.subtitle!.isNotEmpty)
                              Text(
                                banner.subtitle!,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              options: CarouselOptions(
                height: 190,
                viewportFraction: 0.88,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                enlargeCenterPage: true,
              ),
            ),

            SizedBox(height: 24),

            // =========================
            // Latest Posts Title
            // =========================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'latest_posts'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8),

            // =========================
            // Post List
            // =========================
            ...latestPosts.map((PostModel post) {
              final String url = post.fullImageUrl;

              return Card(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      // =========================
                      // Post Image
                      // =========================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) {
                              return ColoredBox(
                                color: Colors.greenAccent,
                                child: Icon(Icons.article_outlined),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      // =========================
                      // Post Information
                      // =========================
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 4),

                            Text(
                              post.author?.displayName ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

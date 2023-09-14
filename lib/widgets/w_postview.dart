import 'package:do_it/screens/s_post.dart';
import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:do_it/widgets/w_postcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsView extends GetView<PostController> {
  final ScrollController scrollController;

  PostsView({Key? key, required this.scrollController}) : super(key: key) {
    Get.put(
      PostController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        controller: scrollController,
        itemCount: controller.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => PostScreen(
                  postData: controller.posts[index],
                ),
                transition: Transition.zoom,
              );
            },
            child: PostCard(
              text: controller.posts[index].description,
              photourl: controller.posts[index].postUrl,
            ),
          );
        },
      ),
    );
  }
}

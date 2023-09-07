import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:do_it/widgets/w_postcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsView extends GetView<PostController> {
  final ScrollController scrollController;

  const PostsView({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PostController());

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
          return PostCard(
            text: controller.posts[index].description,
            views: controller.posts[index].viewcount,
            likes: controller.posts[index].likecount,
            comments: controller.posts[index].commentcount,
            photourl: controller.posts[index].postUrl,
          );
        },
      ),
    );
  }
}

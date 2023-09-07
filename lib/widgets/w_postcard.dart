import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends GetView<PostController> {
  final String text;
  final String photourl;
  final int likes;
  final int comments;
  final int views;
  const PostCard({
    super.key,
    required this.text,
    required this.photourl,
    required this.likes,
    required this.comments,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            width: Get.width,
            height: Get.width * 1.3,
            child: Image.network(
              photourl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.eye,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "$views",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Icon(
                    CupertinoIcons.arrowshape_turn_up_right_fill,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Icon(
                        CupertinoIcons.chat_bubble_fill,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "$comments",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Obx(
                          () => const Icon(
                            CupertinoIcons.heart_fill,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "$likes",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Icon(
                    CupertinoIcons.ellipsis,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends GetView<PostController> {
  final String text;
  final String photourl;

  const PostCard({
    super.key,
    required this.text,
    required this.photourl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: Get.width / 2,
            height: Get.height / 3,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

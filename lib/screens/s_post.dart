import 'package:do_it/screens/s_base.dart';
import 'package:do_it/screens/s_comments.dart';
import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends GetView<PostController> {
  final dynamic postData;

  const PostScreen({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAll(
                      () => const MainHome(),
                      transition: Transition.fade,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      CupertinoIcons.clear,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(postData.postUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        postData.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(postData.postUrl),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postData.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.eye,
                              size: 25,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${postData.viewcount}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.arrowshape_turn_up_right_fill,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => CommentsScreen(
                                      postData: postData,
                                    ),
                                  );
                                },
                                child: const Icon(
                                  CupertinoIcons.chat_bubble_fill,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${postData.commentcount}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isHeartPressed.toggle();
                                },
                                child: Obx(
                                  () => Icon(
                                    CupertinoIcons.heart_fill,
                                    size: 45,
                                    color: controller.isHeartPressed.value
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "${postData.likecount}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.ellipsis,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            //SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

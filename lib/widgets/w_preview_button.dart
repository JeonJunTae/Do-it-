import 'dart:io';

import 'package:do_it/src/binding/controller/upload_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewButton extends GetView<UploadController> {
  final String text;
  const PreviewButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: Get.width,
                      height: Get.width * 1.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(controller.imagePath.value),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
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
                          const Row(
                            children: [
                              Icon(
                                CupertinoIcons.eye,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "2,302",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_fill,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "243",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
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
                                      size: 30,
                                      color: controller.isHeartPressed.value
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "2,312",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
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
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: Get.width / 8,
        width: Get.width / 3,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "미리보기",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

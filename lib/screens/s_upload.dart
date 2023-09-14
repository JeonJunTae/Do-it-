import 'dart:io';
import 'package:do_it/screens/s_addpost.dart';
import 'package:do_it/screens/s_base.dart';
import 'package:do_it/src/binding/controller/upload_controller.dart';
import 'package:do_it/widgets/w_circleiconbutton.dart';
import 'package:do_it/widgets/w_preview_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadScreen extends GetView<UploadController> {
  final String imagePath;

  UploadScreen({Key? key, required this.imagePath}) : super(key: key) {
    Get.put(UploadController());
    controller.imagePath.value = imagePath;
  }

  // Flutter는 위젯 트리를 위에서 아래로 빌드하는데, 이 과정에서 이미 빌드가 진행 중인 위젯의 상태를 변경하려고 하면 오류발생함
  // 따라서 build메소드 외부에서
  // Get.put(UploadController());
  // controller.imagePath.value = imagePath; 수행

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(
              () => const AddpostScreen(),
              transition: Transition.fade,
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              controller.uploadPost();
              Get.to(() => const MainHome());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Do it!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Container(
                        width: Get.width,
                        height: Get.width * 1.2,
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
                      right: Get.width / 40,
                      bottom: Get.width / 40,
                      child: CircleIconButton(
                        icon: Icons.crop,
                        onPressed: () {
                          controller.cropImage();
                        },
                        size: 25,
                        backgroundcolor: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "제목 :",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 1.3,
                    child: TextField(
                      controller: controller.descriptioncontroller,
                      onChanged: (value) {
                        controller.descriptionText.value = value;
                      },
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      maxLength: 10,
                      maxLines: null,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => PreviewButton(
                  text: controller.descriptionText.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

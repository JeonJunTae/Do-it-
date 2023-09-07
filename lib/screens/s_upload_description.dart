import 'package:do_it/screens/s_base.dart';
import 'package:do_it/src/binding/controller/upload_controller.dart';
import 'package:do_it/widgets/w_preview_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
            size: 30,
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
                style: TextStyle(color: Colors.red, fontSize: 15),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SizedBox(
                  width: Get.width,
                  height: Get.width * 1.2,
                  child: Image.file(
                    controller.filteredImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "문구 :",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 1.3,
                    child: TextField(
                      controller: controller.descriptioncontroller,
                      onChanged: (value) {
                        controller.descriptionText.value = value;
                      },
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      maxLines: null,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => PreviewButton(text: controller.descriptionText.value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

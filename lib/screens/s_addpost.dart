import 'package:camera/camera.dart';
import 'package:do_it/screens/s_base.dart';
import 'package:do_it/screens/s_camera.dart';
import 'package:do_it/screens/s_upload.dart';
import 'package:do_it/widgets/w_custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(() => const MainHome());
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
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: (Get.height / 2),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "오늘의 미션",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height) / 3,
                    image: const AssetImage("assets/images/노을.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  "노을 사진을 찍어봐요!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height / 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () async {
                  final cameras = await availableCameras();
                  Get.to(
                    () => CameraScreen(cameras: cameras),
                    transition: Transition.fade,
                  );
                },
                text: "카메라",
              ),
              const SizedBox(width: 20),
              CustomButton(
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    Get.to(
                      () => UploadScreen(imagePath: pickedFile.path),
                    );
                  } else {
                    Get.offAll(
                      () => const AddpostScreen(),
                      transition: Transition.noTransition,
                    );
                  }
                },
                text: "갤러리",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

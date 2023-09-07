import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:do_it/screens/s_camera.dart';
import 'package:do_it/src/binding/controller/upload_controller.dart';
import 'package:do_it/widgets/w_circleiconbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends GetView<UploadController> {
  const AddPostScreen({
    super.key,
  });

  Widget _imagePreview() {
    var width = Get.width;
    return Obx(
      () => Container(
        width: width,
        height: width,
        color: Colors.black,
        child: SingleChildScrollView(
          child: InteractiveViewer(
            maxScale: 2.5,
            child: _photoWidget(
              controller.selectedImage.value,
              width.toInt(),
              builder: (data) {
                return Image.memory(
                  data,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Future _cropImage() async {
  //   var file = await controller.selectedImage.value.file;
  //   CroppedFile? cropped = await ImageCropper().cropImage(
  //     sourcePath: file!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           cropGridColor: Colors.black,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //     ],
  //   );
  // }



  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "사진",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "동영상",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              CircleIconButton(
                icon: Icons.crop,
                onPressed: () {
                  //_cropImage();
                },
                size: 20,
                backgroundcolor: const Color(0xff3B3B3B),
              ),
              const SizedBox(width: 15),
              CircleIconButton(
                icon: CupertinoIcons.photo,
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                },
                size: 20,
                backgroundcolor: const Color(0xff3B3B3B),
              ),
              const SizedBox(width: 15),
              CircleIconButton(
                icon: CupertinoIcons.camera,
                onPressed: () async {
                  final cameras = await availableCameras();
                  Get.to(() => TakePictureScreen(cameras: cameras));
                },
                size: 20,
                backgroundcolor: const Color(0xff3B3B3B),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 줄에 몇개가 들어갈 지
          childAspectRatio: 1, // 정사각형으로 만들기
          // 가로세로 틈
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == controller.imageList.length - 1) {
            // 마직막 아이템일 경우
            controller.loadMoreImages(); // 추가적인 이미지 불러오기 함수 호출
            return const Center(
              child: CircularProgressIndicator(),
            ); //로딩 인디케이터 표시
          }
          return _photoWidget(
            controller.imageList[index],
            200,
            builder: (data) {
              return GestureDetector(
                onTap: () {
                  controller.changeSelectedImage(controller.imageList[index]);
                },
                child: Obx(
                  () => Opacity(
                    opacity: controller.imageList[index] ==
                            controller.selectedImage.value
                        ? 0.3
                        : 1,
                    child: Image.memory(
                      data,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
      future: (asset.type == AssetType.image || asset.type == AssetType.video)
          ? asset.thumbnailDataWithSize(ThumbnailSize(size * 10, size * 10))
          : Future.value(null),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UploadController(), permanent: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
        title: const Text(
          "새 게시물",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                "다음",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _imagePreview(),
          _header(),
          Expanded(
            child: _imageSelectList(),
          ),
        ],
      ),
    );
  }
}

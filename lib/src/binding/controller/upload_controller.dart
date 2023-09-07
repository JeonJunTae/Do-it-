import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/post.dart';
import 'package:do_it/screens/s_upload_description.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:uuid/uuid.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  TextEditingController descriptioncontroller = TextEditingController();
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  late File filteredImage;
  var descriptionText = "".obs;
  var isHeartPressed = false.obs;

  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    loadPhotos();
  }

  void loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();

    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(
              minHeight: 200,
              minWidth: 200,
            ),
          ),
          orders: [
            // 최신이미지
            const OrderOption(type: OrderOptionType.createDate, asc: false)
          ],
        ),
      );
      _loadData();
    } else {}
  }

  void _loadData() async {
    await _pagePhotos();
  }

  Future<void> _pagePhotos() async {
    var photos =
        await albums.first.getAssetListPaged(page: currentPage, size: 20);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
    currentPage++;
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void loadMoreImages() async {
    await _pagePhotos();
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 1000);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          appBarColor: Colors.black,
          title: const Icon(
            CupertinoIcons.sparkles,
            color: Colors.white,
          ),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(
        () => const UploadDescription(),
      );
    }
  }

  Future<void> uploadPost() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (user != null) {
      try {
        String postid = const Uuid().v4();
        var storageRef =
            FirebaseStorage.instance.ref().child('posts').child(postid);
        var uploadTask = storageRef.putFile(filteredImage);
        var taskSnapShot = await uploadTask;
        var imageUrl = await taskSnapShot.ref.getDownloadURL();
        int likecount = 0;
        int commentcount = 0;
        int viewcount = 0;

        Post post = Post(
            description: descriptioncontroller.text,
            uid: user.uid,
            username: user.displayName!,
            postId: postid,
            createdtime: DateTime.now(),
            postUrl: imageUrl,
            likecount: likecount,
            commentcount: commentcount,
            viewcount: viewcount);

        firestore.collection('posts').doc(postid).set(post.toJson());
      } catch (e) {
        return;
      }
    } else {
      return;
    }
  }
}

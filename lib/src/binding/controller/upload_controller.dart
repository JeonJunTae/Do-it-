import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController {
  TextEditingController descriptioncontroller = TextEditingController();
  var descriptionText = "".obs;
  var isHeartPressed = false.obs;
  RxString imagePath = "".obs;

  Future<void> uploadPost() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (user != null) {
      try {
        String postid = const Uuid().v4();
        var storageRef =
            FirebaseStorage.instance.ref().child('posts').child(postid);
        var uploadTask = storageRef.putFile(File(imagePath.value));
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

        firestore
            .collection('users')
            .doc(user.uid)
            .collection('posts')
            .doc(postid)
            .set(post.toJson());
      } catch (e) {
        return;
      }
    } else {
      return;
    }
  }

  Future<void> cropImage() async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath.value,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      imagePath.value = croppedFile.path;
    }
  }
}

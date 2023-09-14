import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  RxList posts = <Post>[].obs;
  DocumentSnapshot? lastDocument;
  var isHeartPressed = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController commentcontroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    String commentid = const Uuid().v4();
    try {
      if (text.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(user!.uid)
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentid)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentid,
          'datePublished': DateTime.now(),
        });
        commentcontroller.text = " ";
      } else {}
    } catch (e) {
      return;
    }
  }

  void fetchPosts() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    // if (user != null) {
    //   try {
    //     QuerySnapshot snapshot = await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(user.uid)
    //         .collection('posts')
    //         .orderBy('createdDate', descending: true)
    //         .get();
    //     posts.value = snapshot.docs.map((doc) => Post.fromSnap(doc)).toList();
    //   } catch (e) {
    //     return;
    //   }
    // }
    QuerySnapshot snapshot;
    try {
      if (user != null) {
        if (lastDocument == null) {
          // 첫 페이지 로드
          snapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('posts')
              .orderBy('createdDate', descending: true)
              .limit(6)
              .get();
        } else {
          // 다음 페이지 로드
          snapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('posts')
              .orderBy('createdDate', descending: true)
              .startAfterDocument(lastDocument!)
              .limit(6)
              .get();
        }
        if (snapshot.docs.isNotEmpty) {
          lastDocument = snapshot.docs.last;
          posts.addAll(snapshot.docs.map((doc) => Post.fromSnap(doc)).toList());
        }
      }
    } catch (e) {
      return;
    }
  }
}

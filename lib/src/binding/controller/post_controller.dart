import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/post.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('posts').get();
      posts.value = snapshot.docs.map((doc) => Post.fromSnap(doc)).toList();
    } catch (e) {
      return;
    }
  }
}

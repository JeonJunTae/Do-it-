import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:do_it/widgets/w_postview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsHome extends StatefulWidget {
  final ScrollController scrollController;
  const FriendsHome({
    super.key,
    required this.scrollController,
  });

  @override
  State<FriendsHome> createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() async {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      Get.find<PostController>().fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12),
        child: Column(
          children: [
            Expanded(
              child: PostsView(
                scrollController: widget.scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

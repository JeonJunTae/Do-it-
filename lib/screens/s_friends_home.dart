import 'package:do_it/widgets/w_postview.dart';
import 'package:flutter/material.dart';

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

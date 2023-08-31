import 'package:do_it/screens/s_hot_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Friends",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )),
                TextButton.icon(
                  onPressed: () {
                    Get.to(const HotHome(),
                        transition: Transition.noTransition);
                  },
                  icon: const Icon(color: Colors.grey, CupertinoIcons.flame),
                  label: const Text(
                    "Hot",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                )
              ],
            ),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: 2,
                childAspectRatio: 180 / 216,
                children: List.generate(
                    11,
                    (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.greenAccent,
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

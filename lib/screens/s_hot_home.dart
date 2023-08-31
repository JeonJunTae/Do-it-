import 'package:do_it/widgets/w_mainappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_it/screens/s_friends_home.dart';

class HotHome extends StatefulWidget {
  const HotHome({super.key});

  @override
  State<HotHome> createState() => _HotHomeState();
}

class _HotHomeState extends State<HotHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const FriendsHome(),
                              transitionDuration: const Duration(seconds: 0)));
                    },
                    child: const Text(
                      "Friends",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(color: Colors.red, CupertinoIcons.flame),
                    label: const Text(
                      "Hot",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ))
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

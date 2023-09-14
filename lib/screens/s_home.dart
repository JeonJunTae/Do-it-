import 'package:do_it/icons/custom__icons1_icons.dart';
import 'package:do_it/screens/s_friends_home.dart';
import 'package:do_it/screens/s_hot_home.dart';
import 'package:do_it/screens/s_search.dart';
import 'package:do_it/src/binding/controller/post_controller.dart';
import 'package:do_it/src/binding/controller/scrollposition_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  bool changepage;
  Home({super.key, required this.changepage});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final ScrollController _friendsscrollController = ScrollController();
  final ScrollController _hotscrollController = ScrollController();
  final scrollPosCtrl = Get.put(ScrollPositionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_friendsscrollController.hasClients) {
        double friendlastPos = scrollPosCtrl.lastFriendsPosition.value;
        _friendsscrollController.jumpTo(friendlastPos);
      }
      if (_hotscrollController.hasClients) {
        double hotlastPos = scrollPosCtrl.lastHotPosition.value;
        _hotscrollController.jumpTo(hotlastPos);
      }
    });

    _friendsscrollController.addListener(() {
      scrollPosCtrl
          .saveFriendsScrollPosition(_friendsscrollController.position.pixels);
    });

    _hotscrollController.addListener(() {
      scrollPosCtrl.saveHotScrollPosition(_hotscrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    _friendsscrollController.dispose();
    _hotscrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.symmetric(horizontal: Get.width / 3),
          title: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height: (Get.height * 0.75),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: Get.width / 6,
                        height: Get.width / 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text("오늘은 은채의 생일입니다!!!!"),
                      const SizedBox(height: 50),
                      const Image(
                        image: AssetImage("assets/images/은채.jpeg"),
                      ),
                      const SizedBox(height: 100),
                      const Text("은채에게 영상편지를 써주세요."),
                    ],
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
            ),
            child: const Row(
              children: [
                Text(
                  "오늘의 Do It!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.expand_more,
                  color: Colors.black,
                  size: 15,
                )
              ],
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(() => const SearchPage(),
                transition: Transition.noTransition);
          },
          color: Colors.black,
          icon: const Icon(CustomIcons1.searchline),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      widget.changepage = true;
                    },
                  );
                },
                child: Text(
                  "Friends",
                  style: TextStyle(
                    fontSize: 15,
                    color: widget.changepage ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(
                    () {
                      widget.changepage = false;
                    },
                  );
                },
                icon: Icon(
                  color: !widget.changepage ? Colors.red : Colors.grey,
                  CupertinoIcons.flame,
                ),
                label: Text(
                  "Hot",
                  style: TextStyle(
                    fontSize: 15,
                    color: !widget.changepage ? Colors.red : Colors.grey,
                  ),
                ),
              )
            ],
          ),
          widget.changepage
              ? Expanded(
                  child: FriendsHome(
                    scrollController: _friendsscrollController,
                  ),
                )
              : Expanded(
                  child: HotHome(
                    scrollController: _hotscrollController,
                  ),
                ),
        ],
      ),
    );
  }
}

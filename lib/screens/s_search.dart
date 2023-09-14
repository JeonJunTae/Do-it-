import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/icons/custom__icons1_icons.dart';
import 'package:flutter/material.dart';
import 'package:do_it/screens/s_mission.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

Future<List<Map<String, dynamic>>> getUserData() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  final List<Map<String, dynamic>> userList = querySnapshot.docs
      .map((doc) => {
            'username': doc['username'].toString(),
            'profileImageUrl':
                doc['profilePhoto'].toString(), // profileImageUrl 필드가 있다고 가정
          })
      .toList();
  return userList;
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Map<String, dynamic>>> userList = getUserData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 13.0),
            // 왼쪽 패팅값 13 줘야함
            child: SizedBox(
              height: 35,
              child: TextField(
                textAlignVertical: const TextAlignVertical(y: 1),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CustomIcons1.searchline),
                  prefixIconColor: Colors.black,
                  hintText: "사용자, 미션 검색",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 13.0, left: 13, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "사용자",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: userList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return SizedBox(
                        height: 100,
                        child: ListView.separated(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (BuildContext context, index) =>
                                const VerticalDivider(
                                  endIndent: 20,
                                  color: Colors.grey,
                                  thickness: 0.1,
                                ),
                            itemBuilder: (BuildContext context, int index) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data![index]
                                                  ['profileImageUrl'],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                      width: 55,
                                      height: 55,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      snapshot.data![index]['username'],
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  }),
              const SizedBox(height: 5),
              const Text("미션",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.to(const MissionPage());
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("아아아아",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                Text(
                                  '2023년 12월 25일',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

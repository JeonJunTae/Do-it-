import 'package:do_it/screens/s_friends_home.dart';
import 'package:do_it/widgets/w_mainappbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: MainAppBar(),
        body: FriendsHome(),
      ),
    );
  }
}

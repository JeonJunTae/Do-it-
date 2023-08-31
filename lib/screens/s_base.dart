import 'package:do_it/widgets/w_navigatorbar.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHome();
}

class _MainHome extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigatorBar(),
    );
  }
}

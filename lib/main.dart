import 'package:animation/src/animated_rating_bar.dart';
import 'package:animation/src/circle_rotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CustomListTile(
              title: "Circular Animation", nextPage: CircularAnimation()),
          CustomListTile(
              title: "Animated Rating Bar", nextPage: AnimatedRatingBar())
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.title, required this.nextPage})
      : super(key: key);
  final String title;
  final Widget nextPage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        tileColor: Colors.red,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (_) => nextPage));
        },
      ),
    );
  }
}

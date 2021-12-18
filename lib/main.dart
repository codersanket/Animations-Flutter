import 'package:animation/src/animated_rating_bar.dart';
import 'package:animation/src/circle_rotation.dart';
import 'package:animation/src/circular_illusion.dart';
import 'package:animation/src/custom_slider.dart';
import 'package:animation/src/illusion.dart';
import 'package:animation/src/loading_animation.dart';
import 'package:animation/src/square_illustration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: const [
            CustomListTile(
                title: "Circular Animation", nextPage: CircularAnimation()),
            CustomListTile(
                title: "Animated Rating Bar", nextPage: AnimatedRatingBar()),
            CustomListTile(
                title: "3D Illustration", nextPage: SquareIllustration()),
            CustomListTile(title: "Custom Slider", nextPage: CustomSlider()),
            CustomListTile(
                title: "Circular Illusion", nextPage: CircularIllusion()),
            CustomListTile(title: "Illusion", nextPage: Illusion()),
            CustomListTile(
                title: "Loading Animation", nextPage: LoadingAnimation())
          ],
        ),
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
        leading: Icon(Icons.arrow_forward_ios),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (_) => nextPage));
        },
      ),
    );
  }
}

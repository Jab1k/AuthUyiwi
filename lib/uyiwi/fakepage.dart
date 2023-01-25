import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Fakepage extends StatelessWidget {
  final String image;
  final String name;
  final num price;
  final String desc;
  const Fakepage(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(tag: 'image_1', child: Image.network(image)),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

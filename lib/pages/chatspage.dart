import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  String? name;
  String? phone;

  addpage() async {
    await ref.set({
      "123/age": 19,
      "123/address/line1": "1 Mountain View",
    });
  }

  getinfo() {
    ref.onValue.listen((event) {
      name = (event.snapshot.value as Map)['name'];
      phone = (event.snapshot.value as Map)['phone'];
      print(event.snapshot.value);
      setState(() {});
    });
  }

  @override
  void initState() {
    getinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('name: ${name}'),
          Text('name: ${phone}'),
        ],
      ),
    );
  }
}

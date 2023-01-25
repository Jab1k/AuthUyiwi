import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18/controller/controller.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSign extends StatefulWidget {
  const GoogleSign({super.key});

  @override
  State<GoogleSign> createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  String? name;
  String? email;
  String? ava;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: (() async {
            GoogleSignIn _googleSignIn = GoogleSignIn();
            var data = await _googleSignIn.signIn();
            print(data?.id);
            print(data?.email);
            print(data?.photoUrl);
            print(data?.displayName);
            ava = data?.photoUrl;
            name = data?.displayName;
            email = data?.email;
            context.read<Controller >().addUserInfo(name!, email, ava);
            // setState(() {});
            _googleSignIn.signOut();
          }),
          child: Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/goog.png',
                    height: 30,
                    width: 30,
                  )
                ],
              ))),
    );
  }
}

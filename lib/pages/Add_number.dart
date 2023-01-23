import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addnumber extends StatefulWidget {
  const Addnumber({Key? key}) : super(key: key);

  @override
  State<Addnumber> createState() => _AddnumberState();
}

class _AddnumberState extends State<Addnumber> {
  TextEditingController cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: TextFormField(
            controller: cont,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: cont.text,
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {},
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

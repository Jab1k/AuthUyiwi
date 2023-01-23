import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController phoneNum = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: phoneNum,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffFAFAFA),
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff06C149)),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff06C149)),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: (() async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phoneNum.text,
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {
                    print(e.toString());
                  },
                  codeSent: (String verificationId, int? resendToken) {},
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: ((context) => Verification())));
              }),
              child: Icon(Icons.next_plan_outlined))
        ],
      ),
    );
  }
}

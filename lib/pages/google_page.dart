import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

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
              child: Icon(Icons.next_plan_outlined)),
          ElevatedButton(
              onPressed: () async {
                final fb = FacebookLogin();

                final res = await fb.logIn(permissions: [
                  FacebookPermission.publicProfile,
                  FacebookPermission.email,
                ]);

                switch (res.status) {
                  case FacebookLoginStatus.success:
                    // Logged in

                    // Send access token to server for validation and auth
                    final FacebookAccessToken? accessToken = res.accessToken;
                    print('Access token: ${accessToken?.token}');

                    // Get profile data
                    final profile = await fb.getUserProfile();
                    print('Hello, ${profile!.name}! You ID: ${profile.userId}');

                    // Get user profile image url
                    final imageUrl = await fb.getProfileImageUrl(width: 100);
                    print('Your profile image: $imageUrl');

                    // Get email (since we request email permission)
                    final email = await fb.getUserEmail();
                    // But user can decline permission
                    if (email != null) print('And your email is $email');

                    break;
                  case FacebookLoginStatus.cancel:
                    break;
                  case FacebookLoginStatus.error:
                    print('Error while log in: ${res.error}');
                    break;
                }
              },
              child: Icon(Icons.add))
        ],
      ),
    );
  }
}

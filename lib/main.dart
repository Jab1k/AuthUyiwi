import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/pages/Add_number.dart';
import 'package:flutter_application_18/pages/dynamiclink.dart';
import 'package:flutter_application_18/pages/firebase.dart';
import 'package:flutter_application_18/pages/homepage.dart';
import 'package:flutter_application_18/uyiwi/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Controller()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DynamicLinkPage(),
      ),
    );
  }
}

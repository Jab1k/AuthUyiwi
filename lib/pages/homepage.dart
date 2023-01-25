import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18/controller/controller.dart';
import 'package:flutter_application_18/model/model.dart';
import 'package:flutter_application_18/pages/Add_number.dart';
import 'package:flutter_application_18/pages/facebook.dart';
import 'package:flutter_application_18/pages/firebase.dart';
import 'package:flutter_application_18/pages/googlesign.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';

import 'addpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Addnumber(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.call,
                    size: 100,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GoogleSign(),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                    width: 100,
                    height: 150,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final fb = FacebookLogin();

                      final res = await fb.logIn(permissions: [
                        FacebookPermission.publicProfile,
                        FacebookPermission.email,
                      ]);

                      switch (res.status) {
                        case FacebookLoginStatus.success:

                          final FacebookAccessToken? accessToken =
                              res.accessToken;
                          final profile = await fb.getUserProfile();
                          final imageUrl =
                              await fb.getProfileImageUrl(width: 100);
                          final email = await fb.getUserEmail();
                          context.read<Controller>().changeUserdata(AppModel(
                              name: profile?.name,
                              image: imageUrl,
                              email: email,
                              lastname: profile?.lastName));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FacebookPage(),
                          ));
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
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GetProductPage(),
                  ),
                );
              },
              child: Icon(Icons.fire_extinguisher)),
        ],
      ),
    );
  }
}

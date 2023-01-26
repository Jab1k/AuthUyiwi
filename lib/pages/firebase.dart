import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/uyiwi/modeldata.dart';

import 'addpage.dart';

class GetProductPage extends StatefulWidget {
  const GetProductPage({Key? key}) : super(key: key);

  @override
  State<GetProductPage> createState() => _GetProductPageState();
}

class _GetProductPageState extends State<GetProductPage> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<GameModel> list = [];
  QuerySnapshot? data;
  bool isLoading = true;

  Future<void> getInfo({String? text}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcm: $fcmToken");
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
    });
    print(fcmToken);
    isLoading = true;
    setState(() {});
    if (text == null) {
      data = await fireStore.collection("Games").get();
    } else {
      data = await fireStore.collection("Games").orderBy("name").startAt(
          [text.toLowerCase()]).endAt(["${text.toLowerCase()}\uf8ff"]).get();
    }
    print(data?.docs.length);
    list.clear();
    for (var element in data?.docs ?? []) {
      list.add(GameModel.fromJson(element));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Search"),
              onChanged: (s) {
                getInfo(text: s);
              },
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            children: [
                              Image.network(list[index].image),
                              Text(
                                  "${list[index].name.substring(0, 1).toUpperCase()}${list[index].name.substring(1)}"),
                              Text(list[index].desc),
                              Text(list[index].price.toString()),
                              IconButton(
                                  onPressed: (() {
                                    fireStore
                                        .collection("Games")
                                        .doc(data?.docs[index].id ?? "")
                                        .delete()
                                        .then(
                                          (doc) => print("Document deleted"),
                                          onError: (e) => print(
                                              "Error updating document $e"),
                                        );
                                    list.removeAt(index);
                                    data?.docs.removeAt(index);
                                    print(data?.docs.length);
                                    print(list.length);
                                    setState(() {});
                                  }),
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        );
                      }),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

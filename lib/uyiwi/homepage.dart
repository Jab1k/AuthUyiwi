import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/pages/addpage.dart';
import 'package:flutter_application_18/uyiwi/addpage.dart';
import 'package:flutter_application_18/uyiwi/fakepage.dart';
import 'package:flutter_application_18/uyiwi/getimage.dart';
import 'package:flutter_application_18/uyiwi/modeldata.dart';

import '../model/model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<GameModel> list = [];
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fireStore.collection("Games").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            list.clear();
            snapshot.data?.docs.forEach((element) {
              list.add(GameModel.fromJson(element));
            });
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Fakepage(
                            image: getimage(list[index].name),
                            name: list[index].name,
                            price: list[index].price,
                            desc: list[index].desc),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 12),
                      height: list[index].desc.length < 100 ? 80 : 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: [
                          Hero(
                              tag: 'image_1',
                              child: Image.network(getimage(list[index].name))),
                          SizedBox(
                            width: 15,
                          ),
                          Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                list[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                list[index].price.toString(),
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddgamePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/pages/addpage.dart';
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
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        Text(list[index].name),
                        Text(list[index].desc),
                        Text(list[index].price.toString()),
                        Text(list[index].uynalgan.toString()),
                      ],
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
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

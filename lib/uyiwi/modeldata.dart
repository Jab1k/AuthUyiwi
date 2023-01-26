import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String name;
  final String desc;
  final num price;
  final String uynalgan;
  final String image;
  GameModel(
      {required this.uynalgan,
      required this.image,
      required this.name,
      required this.price,
      required this.desc});

  factory GameModel.fromJson(QueryDocumentSnapshot data) {
    return GameModel(
        name: data['name'],
        price: data['price'],
        desc: data['desc'],
        uynalgan: data['uynalgan'],
        image: data['image']);
  }

  toJson() {
    return {"name": name, "desc": desc, "price": price, 'uynalgan': uynalgan,'image': image};
  }
}

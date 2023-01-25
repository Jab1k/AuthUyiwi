import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  String? name;
  String? image;
  String? email;
  String? lastname;
  AppModel({this.email, this.image, this.name, this.lastname});
}

class ProductModel {
  final String name;
  final String desc;
  final num price;
  ProductModel({required this.name, required this.price, required this.desc});

  factory ProductModel.fromJson(QueryDocumentSnapshot data) {
    return ProductModel(
      name: data['name'],
      price: data['price'],
      desc: data['desc'],
    );
  }

  toJson() {
    return {"name": name, "desc": desc, "price": price};
  }
}

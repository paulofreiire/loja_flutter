import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id, title, description, category;
  double price;
  List images, sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    images = snapshot.data["images"];
    price = snapshot.data["price"] + 0.0;
    sizes = snapshot.data["sizes"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "description": description, "price": price};
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartProduct {
  String idCart, category, idProduct, size;
  int quantity;
  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot){
    idCart = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    idProduct = documentSnapshot.data["idProduct"];
    size = documentSnapshot.data["size"];
  }
  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "idProduct": idProduct,
      "quantity": quantity,
      "size": size,
      //"product": productData.toResumeMap()
    };
  }
}
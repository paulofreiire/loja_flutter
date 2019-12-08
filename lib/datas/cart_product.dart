import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartProduct {
  String cartId, category, productId, size;
  int quantity;
  ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document){
    cartId = document.documentID;
    category = document.data["category"];
    productId = document.data["productId"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  CartProduct();

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "productId": productId,
      "size": size,
      "quantity": quantity
      //"product": productData.toResumedMap()
    };
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];
  bool isLoading = false;
  String coupon;
  int discountPercentage = 0;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(context) => ScopedModel.of<CartModel>(context);


  void updatePrices(){
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercent){
    this.coupon = couponCode;
    this.discountPercentage = discountPercent;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct product in products){
      if(product.productData != null)
        price += product.quantity * product.productData.price;
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * (discountPercentage / 100);
  }

  double getShipPrice(){
    return 9.99;
  }

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.idCart = doc.documentID;

      notifyListeners();
    });
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();


    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }


}

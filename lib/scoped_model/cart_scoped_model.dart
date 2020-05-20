import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_app/model/cart_model.dart';
import 'package:loja_app/model/product_model.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScopedModel extends Model{

  List<CartModel> products = [];
  UserScopedModel user;
  bool isLoading = false;

  String couponCode;
  int discountPercentage = 0;
  double shipPrice = 9.99;

  static CartScopedModel of(BuildContext context) => ScopedModel.of<CartScopedModel>(context);

  CartScopedModel(this.user){
    if (user.isLoggedIn()) {
      _loadCartItem();
    }
  }

  void addCartItem(CartModel cartModel) async{
    products.add(cartModel);
    isLoading = true;
    notifyListeners();
    await Firestore.instance.collection("users").document(user.user.uid).collection("cart").add(cartModel.toMap()).then((doc) => cartModel.cid = doc.documentID);
    isLoading = false;
    notifyListeners();
  }

  void removeCartItem(CartModel cartModel){
    products.add(cartModel);

    Firestore.instance.collection("users").document(user.user.uid).collection("cart").document(cartModel.cid).delete();
    products.remove(cartModel);

    notifyListeners();
  }

  void decProduct(CartModel cartModel){
    cartModel.quantity--;
    Firestore.instance.collection("users").document(user.user.uid).collection("cart").document(cartModel.cid).updateData(cartModel.toMap());
    notifyListeners();
  }

  
  void incProduct(CartModel cartModel){
    cartModel.quantity++;
    Firestore.instance.collection("users").document(user.user.uid).collection("cart").document(cartModel.cid).updateData(cartModel.toMap());
    notifyListeners();
  }


  void _loadCartItem()async{
    QuerySnapshot query= await Firestore.instance.collection("users").document(user.user.uid).collection("cart").getDocuments();

     products = query.documents.map((e) => CartModel.fromDocument(e)).toList();
    notifyListeners();
  }


  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice(){
    double price = 1;
    
    for (var p in products) {
      print("aqui");
      price = p.productData.price == null ? 1: p.productData.price * p.quantity; 
    }
    return price;
}
  
  int getDiscountPrice() => discountPercentage;
  double getShipPrice() => shipPrice;
    
  void updatePrices(){
    notifyListeners();
  }

  Future<String> finishOrder() async{
    
    if (products.length == 0)return null;
      
    isLoading = true;
    notifyListeners();

    double price = getProductsPrice();
    int discount = getDiscountPrice();
    double ship = getShipPrice();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
      {
        "clientId" : user.user.uid,
        "products" : products.map((e) => e.toMap()).toList(),
        "shipPrice" : ship,
        "productsPrice" : price,
        "discountPrice" : discount,
        "totalPrice" : price + ship - discount,
        "status" : 1

      }
    );

    await Firestore.instance.collection("users").document(user.user.uid).collection("orders").document(refOrder.documentID).setData(
      {
        "orderId" : refOrder.documentID,
      }
    );

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.user.uid).collection("cart").getDocuments();

    for (var doc in query.documents) {
      doc.reference.delete();
    }

  products.clear();
  couponCode = null;
  discountPercentage = 0;
  isLoading = false;
  notifyListeners();

  return refOrder.documentID.toString();
  }
  

}
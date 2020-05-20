import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_app/model/product_model.dart';

class CartModel{

  String cid;
  String category;
  String pid;
  int quantity;
  String size;
  ProductModel productData;

  CartModel();

  CartModel.fromDocument(DocumentSnapshot document){
cid = document.documentID;
category = document.data["category"];
pid = document.data["pid"];
quantity = document.data["quantity"];
size = document.data["size"];
}

  Map<String, dynamic> toMap(){
    return{
      "category" : category,
      "pid" : pid,
      "quantity" : quantity,
      "size" : size,
      "product" : productData.toResumedMap()
    };

  }



}
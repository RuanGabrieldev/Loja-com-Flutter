import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/model/cart_model.dart';
import 'package:loja_app/model/product_model.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';

class CardTile extends StatelessWidget {
  
  final CartModel cartModel;

  CardTile(this.cartModel);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartModel.productData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("products").document(cartModel.category).collection("items").document(cartModel.pid).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            cartModel.productData = ProductModel.fromDocument(snapshot.data);
            return _buildContent(context);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        },
      ):_buildContent(context),
    );
  }

  Container _buildContent(BuildContext context) {
    CartScopedModel.of(context).updatePrices();
    return Container(
      child: Row(
        children: <Widget>[
          Image.network(cartModel.productData.images[0], height: 150,width: 120,),

          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cartModel.productData.title, style: TextStyle(fontSize: 20),),
                Text("Tamanho: " + cartModel.size),
                Text("R\$" + cartModel.productData.price.toString(), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.remove,) 
                    , onPressed: cartModel.quantity == 1 ? null: (){
                      CartScopedModel.of(context).decProduct(cartModel);
                    }),
                    Text(cartModel.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add, color: Theme.of(context).primaryColor,) 
                    , onPressed: (){
                      CartScopedModel.of(context).incProduct(cartModel);
                    }),
                    FlatButton(
                      onPressed: cartModel.quantity <= 1 ? null: (){
                        CartScopedModel.of(context).removeCartItem(cartModel);
                      } 
                    , child: Text("Remover"))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    
  }


  


}
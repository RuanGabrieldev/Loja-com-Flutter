

import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/login_screen.dart';
import 'package:loja_app/screens/order_screen.dart';
import 'package:loja_app/tiles/card_tile.dart';
import 'package:loja_app/widgets/cart_price.dart';
import 'package:loja_app/widgets/discount_card.dart';
import 'package:loja_app/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 10),
            child: ScopedModelDescendant<CartScopedModel>(
                builder: (context, snapshot, model) {
              int products = model.products.length;
              if(UserScopedModel.of(context).isLoggedIn()){
                return Text(
                "${products ?? 0}  ${products == 1 ? "Item" : "Itens"}",
                style: TextStyle(fontSize: 15),
              );
              }else{
                return Container();
              }
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartScopedModel>(
        builder: (context, snapshot, model) {
      
        if (model.isLoading && UserScopedModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserScopedModel.of(context).isLoggedIn()) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.remove_shopping_cart,
                        size: 120,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Divider(),
                    Text(
                      "Faça o login para adicionar produtos!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Divider(),
                    SizedBox(
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ]),
            );
          } else if(model.products.isEmpty || model.products == null){
            return Center(
              child: Text("Nenhum produto no carrinho!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            );
          }else{
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((product) =>
                   Container(
                     child: CardTile(product),
                   ))
                   .toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(()async{
                  String orderId = await model.finishOrder();
                  if (orderId != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderScreen(orderId)));
                  }
                  }),



              ],
            );
          }
        },
      ),
    );
  }

  

}

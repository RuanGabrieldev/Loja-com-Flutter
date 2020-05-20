import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: ExpansionTile(
        title: Text("Cupom de desconto"),
        children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite se cupom"
                ),
                initialValue: CartScopedModel.of(context).couponCode ?? "",
                onFieldSubmitted: (text){
                  if(text.isNotEmpty){
                    Firestore.instance.collection("coupons").document(text).get().then((docSnap) {
                      if(docSnap.data != null){
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Desconto de ${docSnap.data["percent"]}% aplicado!"),
                            backgroundColor: Theme.of(context).primaryColor,
                            ));
                         CartScopedModel.of(context).setCoupon(text, docSnap.data["percent"]);   
                      }else{
                        CartScopedModel.of(context).setCoupon(null, 0);   
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Cupom de desconto inválido!"),
                            backgroundColor: Colors.red,
                            ));
                      }
                    });
                  }
                },
              ),
              )
        ],
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        ),
    );
  }
}
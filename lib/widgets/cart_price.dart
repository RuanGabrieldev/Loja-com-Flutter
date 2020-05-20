import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartScopedModel>(
          builder: (context, snapshot, model){
            if(model.products[0].productData.price == null){
              print("passou aqui");
              return CircularProgressIndicator();
            } 

            print("passou aqui");
          double price = model.getProductsPrice();
          int discount = model.getDiscountPrice();
          double ship = model.getShipPrice();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Resumo do pedido", textAlign: TextAlign.start, style:TextStyle(fontWeight: FontWeight.w500)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text(price != null ? "R\$ ${price.toStringAsFixed(2)}": "R\$0,00"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text("R\$ ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Frete"),
                    Text("R\$ ${ship.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    Text(price != null ? "R\$ ${(price + ship - discount).toStringAsFixed(2)}" : "R\$0,00", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
                  ],
                ),
                 SizedBox(height: 10,),
                 RaisedButton(
                  onPressed: buy,
                  child: Text("Finalizar Pedido"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  )
              ],
              
            );

          }),
      ),
    );
  }
}
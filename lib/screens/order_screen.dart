import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido realizado"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, size: 80, color: Theme.of(context).primaryColor,),
            Text("Pedido realizado com sucesso!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            Text("Código do pedido: ${orderId}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),),
            

          ],
        ),
      ),
    );
  }
}
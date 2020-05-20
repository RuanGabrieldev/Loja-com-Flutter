import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String uid;

  OrderTile(this.uid);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("orders").document(uid).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }else{
              var status = snapshot.data["status"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Código do pedido: ${uid}", style: TextStyle(fontWeight: FontWeight.w500),),
                  Divider(),
                  Text("Descrição", style: TextStyle(),),
                  Text(_buidProductsText(snapshot.data)),
                  Divider(),
                  Text("Status do pedido", style: TextStyle(fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildCircle('1', "Preparação", status, 1),
                      _line(),
                      _buildCircle('2', "Transporte", status, 2),
                      _line(),
                      _buildCircle('3', "Entrega", status, 3),
                    ],
                  )
                ],
              );
            }

          },
        ),
      )
    );
  }

  Container _line() => Container(
    height: 1,
    width: 30,
    color: Colors.grey[500],
  );
    



  Widget _buildCircle(String title, String subTitle, int status, int thisStatus){

    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),
      );
    }else if (status == thisStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    }else{
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );

  }



  String _buidProductsText(DocumentSnapshot dataa) {
      String text = "";

      for (LinkedHashMap item in dataa.data["products"]) {
          text += "${item["quantity"]} x ${item["product"]["title"]} (R\$${item["product"]["price"].toStringAsFixed(2)})\n";
      }
      text += 'Total: R\$ ${dataa.data["totalPrice"].toStringAsFixed(2)}';
      return text;
  }
}
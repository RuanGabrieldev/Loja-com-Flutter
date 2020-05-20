import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: ExpansionTile(
        title: Text("Calcular frete"),
        children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite se CEP"
                ),                
              ),
              )
        ],
        leading: Icon(Icons.location_on),
        trailing: Icon(Icons.add),
        ),
    );
  }
}
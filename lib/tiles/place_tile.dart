import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height:140, child: Image.network(snapshot.data["image"], fit: BoxFit.fill,)),

          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data["title"], style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
                Text(snapshot.data["address"], style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),),
                Divider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]},${snapshot.data["long"]}");
                      },
                      child: Text("Ver no mapa")),

                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        launch("tel:${snapshot.data["phone"]}");
                      },
                      child: Text("Ligar")),  
                    
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
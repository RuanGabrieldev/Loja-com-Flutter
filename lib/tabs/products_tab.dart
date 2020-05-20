import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }else{

          var dividerTiles = ListTile.divideTiles(tiles:snapshot.data.documents.map((doc) => CategoryTile(doc)).toList(), color: Colors.black38);

          return ListView.separated(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => CategoryTile(snapshot.data.documents[index]),
            separatorBuilder: (context, index) => Divider(color: Colors.black, height: 3,) ,
            ); 
        }

      },
    );
  }
}
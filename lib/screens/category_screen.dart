import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/model/product_model.dart';
import 'package:loja_app/tiles/products_tile.dart';

class CategoryScreen extends StatelessWidget {
final DocumentSnapshot snapshot;

CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(  
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("products").document(snapshot.documentID).collection("items").getDocuments(),
          builder: (context, snapshot) =>
             !snapshot.hasData ? CircularProgressIndicator():
             TabBarView(
               children: [
                 GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 3, crossAxisSpacing: 3,childAspectRatio: .65), 
                   itemCount: snapshot.data.documents.length,
                   itemBuilder: (context, index){
                    ProductModel productData = ProductModel.fromDocument(snapshot.data.documents[index]);
                    productData.category = this.snapshot.documentID;
                     return ProductTile("grid", productData);
                   }),
                    ListView.builder(       
                   itemCount: snapshot.data.documents.length,
                   itemBuilder: (context, index){
                     return ProductTile("list", ProductModel.fromDocument(snapshot.data.documents[index]));
                   })
               ]
               )
          
          
          
          
          )
        ),

      );
  }
}
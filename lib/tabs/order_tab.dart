import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/login_screen.dart';
import 'package:loja_app/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(UserScopedModel.of(context).isLoggedIn()){
        String uid = UserScopedModel.of(context).user.uid;

        return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
          builder: (context, snapshot){
             if(!snapshot.hasData){
               return Center(child: CircularProgressIndicator(),);
             } else{
               return ListView(
                 children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
               );
             }

          },);

    }else{
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.view_list,
                        size: 120,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Divider(),
                    Text(
                      "Faça o login para ver seus pedidos!",
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

    }
    
    
    
  }
}
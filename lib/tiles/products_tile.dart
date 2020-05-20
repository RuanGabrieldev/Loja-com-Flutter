import 'package:flutter/material.dart';
import 'package:loja_app/model/product_model.dart';
import 'package:loja_app/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductModel model;

  ProductTile(this.type, this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(model)));
      },
      child: Card(
        elevation: 5,
        child: type == "grid" ? 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(model.images[0], fit: BoxFit.cover,),
              ),
              Expanded(child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(model.title, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("R\$${model.price.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                ),
              ),
          ],
        ): 
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child:Image.network(model.images[0], fit: BoxFit.cover, height: 250,) 
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.title, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("R\$${model.price.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20),),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
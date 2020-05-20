import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/model/cart_model.dart';
import 'package:loja_app/model/product_model.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/cart_screen.dart';
import 'package:loja_app/screens/login_screen.dart';
import 'package:loja_app/widgets/cart_btn.dart';

class ProductScreen extends StatefulWidget {

  final ProductModel productModel;
  ProductScreen(this.productModel);


  @override
  _ProductScreenState createState() => _ProductScreenState(productModel);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductModel productModel;
  String size;

  _ProductScreenState(this.productModel);

  @override
  Widget build(BuildContext context) {
      final Color colorPrimary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.title)
        ),
      floatingActionButton: CartBtn(),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: .90,
            child: Carousel(
              images: productModel.images.map((img) => Image.network(img, height: 200,)).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: colorPrimary,
              autoplay: false,
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(productModel.title, 
                style: TextStyle(
                  fontSize: 25
                ),),

                Text("R\$${productModel.price.toStringAsFixed(2)}", 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: colorPrimary
                ),),    

                Divider(),
                const Text("Tamanho",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5
                    ),
                     
                    children: productModel.sizes.map((sizes) => InkWell(
                      onTap: (){
                        setState(() {
                          size = sizes;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: size == sizes ? colorPrimary : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.black) 
                        ),
                        child: Text(sizes, 
                        textAlign: TextAlign.center, 
                        style: TextStyle(
                          color: size == sizes ? Colors.white : Colors.black
                        ),),
                      ),
                    )).toList(),
                  )
                ),
                
                Divider(),

                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: colorPrimary,
                    child: Text(UserScopedModel.of(context).isLoggedIn() ? "Adicionar ao carrinho": "Entre para comprar!",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    onPressed: size == null ? null : () {
                      if(UserScopedModel.of(context).isLoggedIn()){
                        CartModel cartModel = CartModel();
                        cartModel.category = productModel.category;
                        cartModel.size = size;
                        cartModel.quantity = 1;
                        cartModel.pid = productModel.id;
                        cartModel.productData = productModel;


                       CartScopedModel.of(context).addCartItem(cartModel);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CartScreen()));
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      }

                    }  
                    ),
                ),

                Divider(),

                const Text("Descrição",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(productModel.description,
                style: TextStyle(
                    fontSize: 15,
                  ),
                ),



              ],
            ),
          )
        ],
      
      ),
      );
  }
}
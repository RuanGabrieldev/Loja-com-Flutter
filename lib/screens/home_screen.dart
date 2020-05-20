import 'package:flutter/material.dart';
import 'package:loja_app/tabs/home_tab.dart';
import 'package:loja_app/tabs/order_tab.dart';
import 'package:loja_app/tabs/places_tab.dart';
import 'package:loja_app/tabs/products_tab.dart';
import 'package:loja_app/widgets/cart_btn.dart';
import 'package:loja_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(pageController),
          floatingActionButton: CartBtn(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          body: ProductsTab(),
          drawer: CustomDrawer(pageController),
          floatingActionButton: CartBtn(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(pageController),
          floatingActionButton: CartBtn(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(pageController),
          floatingActionButton: CartBtn(),
        ),

      ],
    );
  }
}
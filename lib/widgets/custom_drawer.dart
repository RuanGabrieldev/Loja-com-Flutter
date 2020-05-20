import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/login_screen.dart';
import 'package:loja_app/tiles/drawer_tiles.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ScopedModelDescendant<UserScopedModel>(
            
            builder: (context, snapshot, model) {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.perm_identity,
                      size: 150,
                    ),
                  ),
                 
                    Container(
                        child: Text(!model.isLoggedIn() ?
                        "Olá, visitante!": "Olá, ${model.userData["name"]}",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(!model.isLoggedIn() ?
                        "Entre ou Cadastre-se!" : "Sair da conta.",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),  
                    onTap: () => !model.isLoggedIn() ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())): 
                      model.signOut(),



                  ),
                  DrawerTile(Icons.home, "Início", pageController, 0),
                  DrawerTile(Icons.list, "Produtos", pageController, 1),
                  DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                  DrawerTile(
                      Icons.playlist_add_check, "Meus pedidos", pageController, 3),
                ],
              );
            }
          )
        ],
      ),
    );
  }

  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 203, 236, 241),
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      );
}

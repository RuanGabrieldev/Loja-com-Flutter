import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_app/scoped_model/cart_scoped_model.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserScopedModel>(
      model: UserScopedModel(),
      child: ScopedModelDescendant<UserScopedModel>(
          builder: (context, snapshot, model) {
        return ScopedModel<CartScopedModel>(
          model: CartScopedModel(model),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
              title: 'Flutter Cloathings',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 4, 125, 141),
              ),
              home: HomeScreen()),
        );
      }),
    );
  }
}

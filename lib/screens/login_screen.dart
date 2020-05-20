import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserScopedModel>(
        builder: (context, snapshot, model) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Entrar"),
            centerTitle: true,
          ),
          body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "Nome inválido!";
                    },
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(labelText: "Senha",),
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida!";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        onPressed: () {

                          if(_emailController.text.isEmpty){
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Insira seu email no campo para a recuperação."),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                          }else{
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Verifique em seu email as etapas para mudar sua senha."),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                          }
                          
                        },
                        child: Text("Esqueci minha senha"),
                        padding: EdgeInsets.zero),
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: onSuccess,
                              onFail: onFail);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text("Não tem uma conta? Cadastre-se agora!"),
                        padding: EdgeInsets.zero),
                  ),
                ],
              )));
    });
  }

  void onSuccess() {
    Navigator.of(context).pop();
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao fazer login."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}

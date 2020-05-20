import 'package:flutter/material.dart';
import 'package:loja_app/scoped_model/user_scoped_model.dart';
import 'package:loja_app/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final  _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
      ),

      body: ScopedModelDescendant<UserScopedModel>(

        builder: (context, snapshot, model){
          if(model.isLoading) return  Center(child: CircularProgressIndicator(),);          
          return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
        
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nome completo"
                ),
                keyboardType: TextInputType.text,
                validator: (text) {
                  if(text.isEmpty) return "Email inválido!";
                },
              ),
              SizedBox(height: 10,),
              
               TextFormField(
                 controller: _addressController,
                decoration: InputDecoration(
                  labelText: "Endereço"
                ),
                keyboardType: TextInputType.text,
                validator: (text) {
                  if(text.isEmpty) return "Endereço inválido!";
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if(text.isEmpty || !text.contains("@")) return "Email inválido!";
                },
              ),
              SizedBox(height: 10,),
               TextFormField(
                 controller: _passController,
                decoration: InputDecoration(
                  labelText: "Senha"
                ),
                keyboardType: TextInputType.text,
                validator: (text) {
                  if(text.isEmpty || text.length < 6) return "Senha inválida!";
                },
              ),
              SizedBox(height: 20,),

              

              SizedBox(
                height: 40,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Cadastrar", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      

                      Map<String, dynamic> userData = {
                        "name" : _nameController.text,
                        "email" : _emailController.text,
                        "address" : _addressController.text,
                      };
                      print(userData["email"]);
                      
                      model.signUp(
                      userData: userData,
                      pass: _passController.text,
                      onSuccess: onSuccess, 
                      onFail: onFail
                      );

                    } 
                  }, ),
              ),

              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Já tem uma conta? Entre agora!"),
                  padding: EdgeInsets.zero
                  ),
              ),


            ],
        )
        );}
      ),

    );
  }

  void onSuccess(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso."),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
      ));

    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.of(context).pop());

  }

  void onFail(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      ));

    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.of(context).pop());

  }
}
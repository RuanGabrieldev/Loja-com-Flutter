import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';


class UserScopedModel extends Model{

  static UserScopedModel of(BuildContext context) => ScopedModel.of<UserScopedModel>(context);

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Map<String, dynamic> userData = Map();

  @override
  void addListener(VoidCallback listener){
    super.addListener(listener);

    _loadCurrentUser();

  }
  
  bool isLoading = false;

  void signUp( {@required Map<String, dynamic> userData,@required String pass, @required VoidCallback onSuccess,@required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

  _auth.createUserWithEmailAndPassword(
    email: userData["email"],
     password: pass)
     .then((user) async{
       this.user = user;
       onSuccess();
       await _saveUserData(userData);
       isLoading = false;
       notifyListeners();
     })
     .catchError((e){
      onFail();
      print(e);
       isLoading = false;
       notifyListeners();
     });
  }

  void signIn({@required String email,@required String pass,@required VoidCallback onSuccess, @required VoidCallback onFail }) {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{

      this.user = user;
      onSuccess();
      isLoading = false;
      notifyListeners();
      await _loadCurrentUser();
    }).catchError((e){
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

 
  Future<void> _saveUserData(Map<String, dynamic> userData) async {
      this.userData = userData;

      await Firestore.instance.collection("users").document(user.uid).setData(userData);
      print("criou a coleção");
  }

  bool isLoggedIn() => user != null;
    
  void signOut() async{

    await _auth.signOut();
    userData = Map();
    user = null;
    notifyListeners();
  }
  
  Future<void> _loadCurrentUser() async{
    if(user == null){
      user = await _auth.currentUser();
    }

    if(user != null){
      if(userData["name"] == null){
        DocumentSnapshot _userData = await Firestore.instance.collection("users").document(user.uid).get();
        userData = _userData.data; 
      }
      
    }
    notifyListeners();
  }


}
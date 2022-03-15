import 'package:firebase_auth/firebase_auth.dart';
import 'package:pavalrank/src/models/user_model.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebase(User user){
    return user != null ? UserModel(uid:user.uid) : null;
  }

  // change user stream
  Stream<UserModel> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }
  // sign in anon
  Future signInAnon() async {
    try{
      UserCredential userCredential =  await _auth.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    } catch(e){
      print('error sign in Anon');
      print(e.toString());
      return null;
    }
  }
  //sign in with email & password

  //register with email & password

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print('error sign Out');
      print(e.toString());
      return null;
    }
  }
}
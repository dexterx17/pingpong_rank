import 'package:firebase_auth/firebase_auth.dart';
import 'package:pavalrank/src/models/user_model.dart';
import 'package:pavalrank/src/services/database.dart';

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
  Future loginWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    }  on FirebaseAuthException catch(e){
      print('error logeando usuario');
      print(e.toString());
      return e.code;
    }
  }



  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // create a new document for the user with the uid
      await DatabaseService(uid: userCredential.user.uid).updateUserData('0','new crew member',100);

      return _userFromFirebase(userCredential.user);
    }  on FirebaseAuthException catch(e){
      print('error registrando usuario');
      print(e);
      print(e.toString());
      return e.code;
    }
  }

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
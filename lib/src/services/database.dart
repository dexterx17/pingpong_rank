import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavalrank/src/models/player_model.dart';
import 'package:pavalrank/src/models/user_data.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference playersCollection = FirebaseFirestore.instance.collection('players');

  Future updateUserData(String name, String nacionalidad, String sexo, int edad) async{
    return await playersCollection.doc(uid).set({
      'nombre' : name,
      'nacionalidad'  : nacionalidad,
      'sexo'  : sexo,
      'edad'  : edad
    });
  }

  List<PlayerModel> _playersListFromSnapshot(QuerySnapshot snapshot){
    try{
      return snapshot.docs.map((doc) {
         print('doc');
         print(doc.data());
        print(doc.get('name'));
        print(doc.get('nacionalidad'));
        print(doc.get('edad'));
        return PlayerModel(
          nombre: doc.get('name') ?? '',
            sexo: doc.get('sexo') ?? '',
          edad: int.parse(doc.get('edad')) ?? 0
        );
      }).toList();

    }catch(e){
      print('error mapeando');
      print(e);
    }
  }

  UserData _userDataFromSnapshot(DocumentSnapshot doc){
    print('mappaing doc');
    print(doc);
    try{
      return UserData(
        uid: uid,
        nombre: doc.get('name'),
        sexo: doc.get('sexo'),
        edad: doc.get('edad'),
      );
    }catch(e){
      print('fallamos mapeando');
      print(e);
    }
  }

  Stream<List<PlayerModel>> get players {
    return playersCollection.snapshots()
          .map(_playersListFromSnapshot);
  }

  Stream<UserData> get userData {
    return playersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}
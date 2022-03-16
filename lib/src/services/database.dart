import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavalrank/src/models/player_model.dart';
import 'package:pavalrank/src/models/user_data.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference playersCollection = FirebaseFirestore.instance.collection('players');

  Future updateUserData(String sugars, String name, int stregth) async{
    return await playersCollection.doc(uid).set({
      'sugar' : sugars,
      'name'  : name,
      'strength'  : stregth
    });
  }

  List<PlayerModel> _playersListFromSnapshot(QuerySnapshot snapshot){
    try{
      return snapshot.docs.map((doc) {
         print('doc');
         print(doc.data());
        print(doc.get('name'));
        print(doc.get('strength'));
        print(doc.get('sugar'));
        return PlayerModel(
          nombre: doc.get('name') ?? '',
          apellido: doc.get('name') ?? '',
          edad: int.parse(doc.get('sugar')) ?? 0
        );
      }).toList();

    }catch(e){
      print('error mapeando');
      print(e);
    }
  }

  UserData _userDataFromSnapshot(DocumentSnapshot doc){
    return UserData(
      uid: uid,
      nombres: doc.get('name'),
   //   apellido: doc.get('name'),
      edad: doc.get('sugar'),
    );
  }

  Stream<List<PlayerModel>> get players {
    return playersCollection.snapshots()
          .map(_playersListFromSnapshot);
  }

  Stream<UserData> get userData {
    return playersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}
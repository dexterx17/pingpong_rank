import 'package:flutter/material.dart';
import 'package:pavalrank/src/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pavalrank/src/models/player_model.dart';

class PlayersList extends StatefulWidget {
  @override
  _PlayersListState createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {

  @override
  Widget build(BuildContext context) {

    final players = Provider.of<List<PlayerModel>>(context);

    print('players');
    print(players);

    if(players != null){
      players.forEach((player) {
        print('player');
        print(player);
        print('nombre: '+player.nombre);
        print('apellido: '+player.apellido.toString());
        print('edad: '+player.edad.toString());
      });
    }

    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return ContactListItem(players[index]);
      },
    );

    return Container();
  }
}

class ContactListItem extends StatelessWidget {
  final PlayerModel _playerModal;

  ContactListItem(this._playerModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: new CircleAvatar(child: new Text(_playerModal.nombre[0])),
        title: new Text(_playerModal.nombre),
        subtitle: new Text(_playerModal.edad.toString()));
  }
}
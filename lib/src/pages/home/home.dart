import 'package:flutter/material.dart';
import 'package:pavalrank/src/services/auth.dart';
import 'package:pavalrank/src/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pavalrank/src/models/player_model.dart';
import 'package:pavalrank/src/pages/home/settings_form.dart';


import 'package:pavalrank/src/pages/players/players_list.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      },);
    }

    return  StreamProvider<List<PlayerModel>>.value(
      value: DatabaseService().players,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Ping Pong Rank'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: PlayersList(),
        )
      );
  }
}

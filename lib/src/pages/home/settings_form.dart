import 'package:flutter/material.dart';
import 'package:pavalrank/src/models/user_data.dart';
import 'package:pavalrank/src/models/user_model.dart';
import 'package:pavalrank/src/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _name;
  String _apellido;
  int _edad;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your settings ',
                      style: TextStyle(fontSize: 18.0)
                  ),

                  SizedBox(height: 20.0,),

                  TextFormField(
                    initialValue: userData.nombre,
                    validator: (value) => value.isEmpty ? 'Ingrese un nombre' : null,
                    onChanged: (value) => setState(() => _name = value),
                  ),
                  SizedBox(height:20.0),

                  DropdownButtonFormField(
                    value: _apellido ?? userData.nombre,
                    items: sugars.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text('$e year')
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _apellido = value),
                  ),

                  SizedBox(height:20.0),

                  Slider(
                    value: (_edad ?? userData.edad).toDouble(),
                    activeColor: Colors.brown[_edad ?? 100],
                    inactiveColor: Colors.brown[_edad ?? 100],
                    min:0.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (value) => setState(() => _edad = value.round()),
                  ),

                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Update',style: TextStyle(color:Colors.white),),
                    onPressed: () async {
                      print(_name);
                      print(_apellido);
                      print(_edad);


                    },
                  )


                ],
              )
          );

        }

      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pavalrank/src/pages/authenticate/LoginActivity.dart';
import 'package:pavalrank/src/pages/authenticate/RecoveryEmailActivity.dart';
import 'package:pavalrank/src/pages/authenticate/EmailRegisterActivity.dart';
import 'package:pavalrank/src/pages/profile/Profile2.dart';

import 'package:pavalrank/src/pages/home/home.dart';
import 'package:pavalrank/src/helper/ColorsRes.dart';
import 'package:pavalrank/src/helper/DesignConfig.dart';
import 'package:pavalrank/src/helper/StringsRes.dart';
import 'package:pavalrank/src/services/auth.dart';
import 'package:pavalrank/src/shared/loading.dart';

class EmailLoginActivity extends StatefulWidget {
  EmailLoginActivity({Key key}) : super(key: key);

  @override
  _EmailLoginActivityState createState() => _EmailLoginActivityState();
}

class _EmailLoginActivityState extends State<EmailLoginActivity> {
  bool _conobscureText = true;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: ColorsRes.backgroundColor,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child:Form(
                  key:_formKey,
                  child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            StringsRes.yourAccountText,
                            style: TextStyle(color: ColorsRes.gradientTwo, fontWeight: FontWeight.normal, fontSize: 50),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          StringsRes.emailLoginDescriptionText,textAlign: TextAlign.center,
                          style: TextStyle(color: ColorsRes.darkColor, fontWeight: FontWeight.bold, fontSize: 20,),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            StringsRes.usernameText,textAlign: TextAlign.left,
                            style: TextStyle(color: ColorsRes.gradientTwo, fontWeight: FontWeight.bold, fontSize: 20,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration:
                        DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
                        child: Container(
                          height: 61,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            validator: (value) => value.isEmpty ? 'Ingrese un email válido' : null,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            style: TextStyle(color: ColorsRes.darkColor, fontSize: 20, fontWeight: FontWeight.bold),
                            cursorColor: ColorsRes.darkColor,
                            decoration: InputDecoration(
                              hintText: StringsRes.enterUsernameText,
                              hintStyle: Theme.of(context).textTheme.subtitle2.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: ColorsRes.darkColor)),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            StringsRes.passwordText,textAlign: TextAlign.left,
                            style: TextStyle(color: ColorsRes.gradientTwo, fontWeight: FontWeight.bold, fontSize: 20,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration:
                        DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
                        child: Container(
                          height: 61,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            validator: (value) => value.isEmpty ? 'Ingrese un email válido' : null,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            obscureText: _conobscureText,
                            obscuringCharacter: "*",
                            style: TextStyle(color: ColorsRes.darkColor, fontSize: 20, fontWeight: FontWeight.bold),
                            cursorColor: ColorsRes.gradientTwo,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              hintText: StringsRes.enterPasswordText,
                              hintStyle: Theme.of(context).textTheme.subtitle2.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: ColorsRes.darkColor)),
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _conobscureText = !_conobscureText;
                                  });
                                },
                                child: Padding(padding: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                                      child:Icon(_conobscureText?Icons.visibility : Icons.visibility_off, color: ColorsRes.gradientTwo)),
                                    )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecoveryEmailActivity(),
                            ),
                          );
                        },
                        child: Align(alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              StringsRes.forgetPasswordText,textAlign: TextAlign.end,
                              style: TextStyle(color: ColorsRes.gradientTwo, fontWeight: FontWeight.bold, fontSize: 20,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(error,style: TextStyle(color:Colors.red, fontSize: 14.0),),
                      loading ? Loading() :
                      GestureDetector(
                        onTap: () async{

                          if(_formKey.currentState.validate()){
                            setState(() => loading = true );
                            dynamic result = await _auth.loginWithEmailAndPassword(email, password);
                            if(result.runtimeType == String){

                              print('error ingresando');
                              setState(() {
                                if (result  == 'user-not-found') {
                                  error = StringsRes.userNotFound;
                                } else if (result  == 'wrong-password') {
                                  error = StringsRes.wrongPassword;
                                }else{
                                  error = 'Verifique si el usuario o contraseña son válidos';
                                }
                                loading = false;
                              });
                            }else{

                              print('logeado');
                              print(result);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            }
                          }
                          // print('logeame');
                          // print(email);
                          // print(password);
                          //
                          // print('anonymous login');
                          // dynamic result = await _auth.signInAnon();
                          //
                          // if(result == null){
                          //   print('error ingresando');
                          // }else{
                          //   print('logeado');
                          //   print(result.uid);
                          // }

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RegistrationSuccessfullActivity(),
                          //   ),
                          // );

                        },
                        child: Container(decoration: DesignConfig.boxDecorationButton(ColorsRes.gradientOne,ColorsRes.gradientTwo),
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            alignment: Alignment.center,
                            child: Text(StringsRes.doneText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ColorsRes.white,
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Aún no tienes cuenta'),
                          FlatButton.icon(
                            icon: Icon(Icons.person),
                            label: Text('Registrate'),
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailRegisterActivity(),
                                ),
                              );
                            },
                          )
                        ],
                      )

                    ],
                  ),
                ),
                ),
              ),
            ),
          ],
        ),

    );
  }


  Future<void> navigationPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginActivity(),
      ),
    );
  }
}

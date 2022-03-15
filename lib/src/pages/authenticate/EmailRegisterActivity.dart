import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavalrank/src/pages/authenticate/LoginActivity.dart';
import 'package:pavalrank/src/pages/authenticate/ProfilePictureActivity.dart';
import 'package:pavalrank/src/pages/authenticate/RecoveryEmailActivity.dart';
import 'package:pavalrank/src/pages/authenticate/RegistrationSuccessfullActivity.dart';
import 'package:pavalrank/src/helper/ColorsRes.dart';
import 'package:pavalrank/src/helper/DesignConfig.dart';
import 'package:pavalrank/src/helper/StringsRes.dart';
import 'package:pavalrank/src/services/auth.dart';
import 'package:pavalrank/src/shared/loading.dart';

class EmailRegisterActivity extends StatefulWidget {
  EmailRegisterActivity({Key key}) : super(key: key);

  @override
  _EmailRegisterActivityState createState() => _EmailRegisterActivityState();
}

class _EmailRegisterActivityState extends State<EmailRegisterActivity> {
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
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginActivity(),
          ),
        );
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: ColorsRes.backgroundColor,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              StringsRes.newAccountText,
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
                            StringsRes.emailRegisterDescriptionText,textAlign: TextAlign.center,
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
                              validator: (value) => value.isEmpty ? 'Ingrese un email' : null,
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
                              validator: (value) => value.length < 6 ? 'Ingrese una contraseña de al menos 6 caracteres' : null,
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
                        SizedBox(
                          height: 25.0,
                        ),

                        Text(error,style: TextStyle(color:Colors.red, fontSize: 14.0),),

                        SizedBox(
                          height: 25.0,
                        ),

                        loading ? Loading() :
                        GestureDetector(
                          onTap: () async{
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);

                                dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                                Type tipo = result.runtimeType;

                                if(tipo == String){

                                  setState(()  {
                                    if (result == 'weak-password') {
                                      error = StringsRes.passwordTooWeak;
                                    } else if (result == 'email-already-in-use') {
                                      error = StringsRes.emailAreadyInUse;
                                    }else{
                                      error = result;
                                    }
                                    loading = false;
                                  });
                                }else{
                                  print('logeado');
                                  print(result);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePictureActivity(),
                                    ),
                                  );
                                }
                            }else{
                              print('error en validar form');
                              setState(() =>  error = 'revisar formulario' );
                            }

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
                      ],
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
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

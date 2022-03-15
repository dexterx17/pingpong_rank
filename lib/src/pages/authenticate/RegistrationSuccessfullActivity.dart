import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pavalrank/src/pages/authenticate/LoginActivity.dart';
import 'package:pavalrank/src/helper/ColorsRes.dart';
import 'package:pavalrank/src/helper/DesignConfig.dart';
import 'package:pavalrank/src/helper/StringsRes.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RegistrationSuccessfullActivity extends StatefulWidget {
  RegistrationSuccessfullActivity({Key key}) : super(key: key);

  @override
  _RegistrationSuccessfullActivityState createState() => _RegistrationSuccessfullActivityState();
}

class _RegistrationSuccessfullActivityState extends State<RegistrationSuccessfullActivity> {
  String countrycode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(decoration: DesignConfig.boxDecorationBackground(),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/datingapp/logo_white.svg',
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            StringsRes.congratulationMessageText,
                            style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.normal, fontSize: 22),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => InterestedActivity(),
                          //   ),
                          // );
                        },
                        child: Container(decoration: DesignConfig.boxDecorationButton(ColorsRes.white,ColorsRes.white),
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            alignment: Alignment.center,
                            child: Text(StringsRes.continueText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ColorsRes.gradientTwo,
                                ))),
                      ),
                    ],
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

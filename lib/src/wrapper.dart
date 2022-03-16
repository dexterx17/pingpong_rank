import 'package:flutter/material.dart';
import 'package:pavalrank/src/models/user_model.dart';
import 'package:pavalrank/src/pages/authenticate/WRLogin1.dart';
import 'package:pavalrank/src/pages/authenticate/authenticate.dart';
import 'package:pavalrank/src/pages/home/home.dart';
import 'package:pavalrank/src/pages/onboarding/OnboardingScreen1.dart';
import 'package:pavalrank/src/pages/onboarding/OnboardingScreen2.dart';
import 'package:pavalrank/src/pages/onboarding/OnboardingScreen3.dart';
import 'package:pavalrank/src/pages/profile/Profile1.dart';
import 'package:pavalrank/src/pages/profile/Profile2.dart';
import 'package:pavalrank/src/pages/onboarding/PingPongAppSplash.dart';
import 'package:pavalrank/src/pages/profile/Profile3.dart';
import 'package:pavalrank/src/pages/authenticate/LoginActivity.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //*********Login***************
    //return WRLogin1();

    //*********OnBoarding***************
    //return WrOnboardingScreen1();
    //return WrOnboardingScreen2();
    //return Walkthrough();

    final user = Provider.of<UserModel>(context);
    print('user');
    print(user);
    if(user == null){
      return LoginActivity();
    }else{
      //return profile1();
      return Home();
      //return profile3();
    }
  }
}

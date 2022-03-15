import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pavalrank/src/models/user_model.dart';

import 'package:pavalrank/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pavalrank/src/pages/onboarding/PingPongAppSplash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PingPongAppSplash(),
        )
      );

  }
}
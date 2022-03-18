import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pavalrank/src/pages/authenticate//LoginActivity.dart';
import 'package:pavalrank/src/pages/authenticate//MobileNumbeInputActivity.dart';
import 'package:pavalrank/src/pages/authenticate//PersonalDetailActivity.dart';
import 'package:pavalrank/src/helper/ColorsRes.dart';
import 'package:pavalrank/src/helper/DesignConfig.dart';
import 'package:pavalrank/src/helper/StringsRes.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfilePictureActivity extends StatefulWidget {
  ProfilePictureActivity({Key key}) : super(key: key);

  @override
  _ProfilePictureActivityState createState() => _ProfilePictureActivityState();
}

class _ProfilePictureActivityState extends State<ProfilePictureActivity> {

  var storage = FirebaseStorage.instance;
  bool isLoading = false;
  PickedFile imageFile=null;

  @override
  void initState() {
    super.initState();
  }


  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: ColorsRes.backgroundColor,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(alignment: Alignment.center,
                        child: FittedBox(
                          child: Padding(padding: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                                onTap: (){
                                  _showChoiceDialog(context);

                                },
                                child: CircleAvatar(backgroundColor: ColorsRes.white,radius: 50,child:Container(child: ClipOval(child: SvgPicture.asset("assets/datingapp/default_profile.svg", width: 135, height: 135, fit: BoxFit.fill,))))
                            ),
                          ),),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          StringsRes.profilePictureText,
                          style: TextStyle(color: ColorsRes.gradientTwo, fontWeight: FontWeight.normal, fontSize: 50),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          StringsRes.profilePictureDescriptionText,
                          style: TextStyle(color: ColorsRes.darkColor, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: Container(decoration: DesignConfig.boxDecorationButton(ColorsRes.gradientOne,ColorsRes.gradientTwo),
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            alignment: Alignment.center,
                            child: Text(StringsRes.addPhotoText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ColorsRes.white,
                                ))),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalDetailActivity(),
                            ),
                          );
                        },
                        child: Container(decoration: DesignConfig.boxDecorationButton(ColorsRes.white,ColorsRes.white),
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            alignment: Alignment.center,
                            child: Text(StringsRes.skipText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ColorsRes.grayColor,
                                ))),
                      ),
                      SizedBox(
                        height: 50.0,
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

  Future uploadImageToFirebase(BuildContext context) async {

    // String fileName = basename(imageFile.path);
    // StorageReference firebaseStorageRef =
    // FirebaseStorage.instance.ref().child('uploads/$fileName');
    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    // );
    //
    // final Directory systemTempDir = Directory.systemTemp;
    // final byteData = await rootBundle.load(img);
    //
    // final file =
    // File('${systemTempDir.path}/$imageName.jpeg');
    // await file.writeAsBytes(byteData.buffer.asUint8List(
    //     byteData.offsetInBytes, byteData.lengthInBytes));

    var file = File(imageFile.path);

    TaskSnapshot snapshot = await storage
        .ref()
        .child("images/profile")
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl =
      await snapshot.ref.getDownloadURL();
      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .add({"url": downloadUrl, "name": imageName});
      print('downloadUrl');
      print(downloadUrl);
      setState(() {
        isLoading = false;
      });
      final snackBar =
      SnackBar(content: Text('Yay! Success'+downloadUrl));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print(
          'Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }


    // Reference ref = FirebaseStorage.instance.ref();
    // TaskSnapshot addImg =
    // await ref.child("image/img").putFile(imageFile);
    // if (addImg.state == TaskState.success) {
    //   setState(() {
    //     this.isLoading = false;
    //   });
    //   print("added to Firebase Storage");
    // }

  }


  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile;
      uploadImageToFirebase(context);
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile;
      uploadImageToFirebase(context);
    });
    Navigator.pop(context);
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

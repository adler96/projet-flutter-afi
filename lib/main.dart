import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:afi/menu_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifierLaConnexion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image/splash_img.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Container(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }

  //Verification de la connexion internet
  verifierLaConnexion() async{
    var connexion = await Connectivity().checkConnectivity();
    if(connexion == ConnectivityResult.none){
      return  AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.ERROR,
        body: const Center(child: Text(
          'Vous n\'êtes pas connecté à internet, merci de verifier votre connexion.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),),
        title: 'Pas de connexion!!!',
        btnOkOnPress: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            SystemNavigator.pop();
          }
        },
      )..show();
    } else{
      Timer(
          Duration(seconds: 5),
              ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>MenuPage()))
      );
    }
  }
}

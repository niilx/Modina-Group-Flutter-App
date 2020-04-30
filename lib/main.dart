import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:modina_group_flutter_app_demo/UI/dashboard.dart';
import 'package:modina_group_flutter_app_demo/UI/userLogin.dart';
import 'package:modina_group_flutter_app_demo/Utils/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool loggedIn = false;
  String userId;
  @override
  void initState() {
    SharedPref.contain("user").then((isCheck){
      if(isCheck){
        SharedPref.read("user").then((user){
          print("User :$user");
          setState(() {
            loggedIn = true;
            userId = user;
          });
         // userData=UserProfile(user);


        });

      }



    });

    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Madina App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: loggedIn?DashboardPage(userId.toString()): UserLoginPage(),
    );
  }
}


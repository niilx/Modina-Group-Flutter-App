import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:modina_group_flutter_app_demo/UI/dashboard.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {


  TextEditingController userID = TextEditingController();
  TextEditingController userPass = TextEditingController();

  var ListofUsers = [
    "demo@demo.com", "assigned@demo.com", "auditor@demo.com", "issuer@demo.com"
  ];

  login() async {

    if(userID.text.isNotEmpty && userPass.text.isNotEmpty){
      if(ListofUsers.contains(userID.text.toString()) && userPass.text.toString() =="123456"){
        await new Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DashboardPage(userID.text.toString());
        }));
        //                                      showDialog(
        //                                          context: context,
        //                                          builder: (BuildContext context) {
        //                                            return Center(
        //                                              child:
        //                                              //CircularProgressIndicator can be used without any package
        //                                              SpinKitCircle(
        //                                                color: Color(0xffff3a5a),
        //                                                size: 80.0,
        //                                              ),
        //                                            );
        //                                          });
        //await _login();
      }else{
        _showAlert('Invalid User/Password, Try Again Please');
        await new Future.delayed(const Duration(seconds: 1));
      }
    }else{
      _showAlert( 'Failed, Please input user/password');
      await new Future.delayed(const Duration(seconds: 1));
    }
  }

  _showAlert(String t) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text("Status"),
            content: Text(t),
            actions: <Widget>[
              RaisedButton(
                child: Text("OK"),
                color: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  getLoginView(){
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height:MediaQuery. of(context). size. height*0.13,
              ),
              Card(
                elevation: 4,
                child: Container(
                  width: MediaQuery. of(context). size. width*0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery. of(context). size. height*0.1, ),
                        alignment: Alignment.center,
                        height: MediaQuery. of(context). size. height*0.2, color: ProjectResource.appBarColor,
                        child: Text("Sign in to MG-WPR",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500),),
                      ),
                      SizedBox(
                        height:MediaQuery. of(context). size. height*0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0,8,15,8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Email/Mobile No.", style: TextStyle(color: Colors.black54, fontSize: 16),),
                            SizedBox(height: 12,),
                            Material(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              child: TextField(
                                controller: userID,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  print("value typed $value");
                                },
                                cursorColor: Colors.black54,
                                decoration: InputDecoration(
                                    hintText: "Email/Phone no.",
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54)),
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12, vertical: 13)),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("Password", style: TextStyle(color: Colors.black54, fontSize: 16),),
                            SizedBox(height: 12,),
                            Material(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              child: TextField(
                                controller: userPass,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                onChanged: (value) {
                                  print("value typed $value");
                                },
                                cursorColor: Colors.black54,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.black54)),
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12, vertical: 13)),
                              ),
                            ),
                            SizedBox(height: 12,),
                            InkWell(
                              onTap: (){
                                print("Forget Password...");
                              },
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text("Forget Password?",textAlign: TextAlign.end,)),
                            ),
                            SizedBox(height: 12,),
                           Center(
                             child: Container(
                                    height: 35,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: Color(0xff58D68D)),
                                    child: FlatButton(
                                      child: Text(
                                        "LOG IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child:
                                                //CircularProgressIndicator can be used without any package
                                                CircularProgressIndicator()
                                              );
                                            });
                                        await login();
                                      }
                                    ),
                                  ),
                           ),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),




                    ],
                  ),
                ) ,),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery. of(context). size. height*0.05,
          left: MediaQuery. of(context). size. width*0.35,
          child: CircleAvatar(
            radius: 65,
            backgroundColor: Color(0xFFD4AC0D),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/logomadina.png'),
            ),
          )
        ),
      ],
    );
  }


  getVersion(){
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Text("Version 1.19.7.1"),
          SizedBox(height: 10,),
          Text("Powered By",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15),),

          SizedBox(height: 10,),
          Text("Dream71",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15, color: Colors.greenAccent),),
          SizedBox(height: 50,),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              getLoginView(),
              getVersion()
            ],
          ),
        ),
      ) ,
    );
  }
}



import 'package:flutter/material.dart';
import 'package:modina_group_flutter_app_demo/UI/CreateNewIssue.dart';
import 'package:modina_group_flutter_app_demo/UI/dashboard.dart';

class ProjectResource {

  static Color appBarColor = Color(0xFF9C640C);
  static BuildContext currentContext;
  static var pageState;

  static userDrawer(var context, var state){
    currentContext = context;
    pageState = state;
   return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              color: ProjectResource.appBarColor
          ),
          accountName: Text("Md. Touhidul Islam"),
          accountEmail: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Employee"),
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: InkWell(
                  child: Text("LOG OUT"),
                  onTap: (){
                    print("Logout");
                  },
                ),
              )
            ],
          ),
          currentAccountPicture: CircleAvatar(
              backgroundColor:
              Theme.of(currentContext).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Color(0xFFD4AC0D),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/logomadina.png'),
                ),)
          ),

        ),
        ListTile(
          title: Text("Assigned Issue List"),
          leading: Icon(Icons.assignment),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DashboardPage();
            }));
          },
        ),
        ListTile(
          title: Text("Total Issue List"),
          leading: Icon(Icons.assignment_ind),
        ),
        ListTile(
          title: Text("Urgent Issue List"),
          leading: Icon(Icons.important_devices),
        ),
        ListTile(
          title: Text("Associate Issue List"),
          leading: Icon(Icons.new_releases),
        ),
        ListTile(
          title: Text("Completed Issue List"),
          leading: Icon(Icons.done_outline),
        ),
        ListTile(
          title: Text("In Progress Issue List"),
          leading: Icon(Icons.directions_run),
        ),
        ListTile(
          title: Text("Rejected Issue List"),
          leading: Icon(Icons.cancel),
        ),
        ListTile(
          title: Text("Pending Issue List"),
          leading: Icon(Icons.watch),
        ),
        ListTile(
          title: Text("Create New Issue"),
          leading: Icon(Icons.add),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateNewIssuePage();
            }));
          },
        ),
        ListTile(
          title: Text("My Issue List"),
          leading: Icon(Icons.person),
        ),
        ListTile(
          title: Text("Chat"),
          leading: Icon(Icons.chat),
        ),
        ListTile(
          title: Text("Notifications"),
          leading: Icon(Icons.notifications),
        ),
        ListTile(
          title: Text("Settings"),
          leading: Icon(Icons.settings),
        ),


      ],
    );
  }

}
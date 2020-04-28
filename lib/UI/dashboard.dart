import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ProjectResource.appBarColor
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ProjectResource.appBarColor,
        title: Text("Assigned Issue List", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
          ),
        ],

      ),

      drawer: Drawer(
        child: ProjectResource.userDrawer(context,this),

      ),

    );
  }
}

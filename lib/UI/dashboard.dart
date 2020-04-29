import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/Models/issues.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:modina_group_flutter_app_demo/Utils/DatabaseHelper.dart';


class DashboardPage extends StatefulWidget {
  String user;
  DashboardPage(this.user);
  @override
  _DashboardPageState createState() => _DashboardPageState(this.user);
}

class _DashboardPageState extends State<DashboardPage> {
  String user;
  _DashboardPageState(this.user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProjectResource.userID = this.user;
    print(ProjectResource.userID);
    users();

  }

  var issues;
  users() async {

     var db = DatabaseHelper();

     issues = await db.getAllIssues();
     print(issues);
     //print(Issues.fromMap(issues[0]["issue_code"]));
     for (int i = 0; i < issues.length; i++) {
       Issues issue = Issues.fromMap(issues[i]);
       print("User $i : ${issue.issue}\n${issue.issueAssignedTo}\n ${issue.issueCreatedBy}\n");
     }

   }

  var margins= SizedBox(height: 15,);
  var marginsSmall= SizedBox(height: 5,);

  Future<List<Map>> fetchUsersFromDatabase() async {
    var db = DatabaseHelper();
    return db.getAllIssues();
  }

  getAssignedIssues(){
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<Map>>(
        future: fetchUsersFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start
                        ,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                height: 30, width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.grey[300]
                                ),
                                child: Text((index+1).toString()),
                              ),
                              SizedBox(width: 10,),
                              Text(snapshot.data[index]["issue_code"], style: TextStyle(fontSize:15, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          margins,

                          Text(snapshot.data[index]["issue"], style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                          margins,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Status", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                              Text("Priority", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                            ],),
                          marginsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]["issue_status"]),
                              Text(snapshot.data[index]["issue_priority"])
                            ],),
                          margins,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Start Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                              Text("End Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                            ],),
                          marginsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]["start_date"]),
                              Text(snapshot.data[index]["end_date"])
                            ],),
                          margins,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Unit", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                              Text("Department", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                            ],),
                          marginsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]["unit"]),
                              Text(snapshot.data[index]["dept"])
                            ],),

                          margins,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Created By", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                              Text("Assigned To", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                            ],),
                          marginsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]["created_by"]),
                              Text(snapshot.data[index]["assigned_to"])
                            ],),
                          margins,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Created Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                              Text("")
                            ],),
                          marginsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]["created_date"]),
                              Text("")
                            ],),
                          margins,
                          LinearProgressIndicator(
                            backgroundColor: Colors.green, value: 100,
                          ),
                          margins

                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          return new Container(
            alignment: AlignmentDirectional.center,
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  getIssuerIssues(){
    return Container(
      child: Center(child: Text("No Issues"),),
    );
  }

  getAssignedIssuesDemo(){
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:18,
                  itemBuilder: (context,index){
                    return  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start
                          ,
                          children: <Widget>[

                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 30, width: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.grey[300]
                                  ),
                                  child: Text((index+1).toString()),
                                ),
                                SizedBox(width: 10,),
                                Text("DL-AD-584", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            margins,

                            Text("Land Wanted", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                            margins,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Status", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                                Text("Priority", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                              ],),
                            marginsSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Opened"),
                                Text("Normal")
                              ],),
                            margins,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Start Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                                Text("End Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                              ],),
                            marginsSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("2020-04-15"),
                                Text("2020-04-30")
                              ],),
                            margins,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Unit", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                                Text("Department", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                              ],),
                            marginsSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Gaston Battery"),
                                Text("HR Department")
                              ],),

                            margins,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Created By", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),
                                Text("Assigned To", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                              ],),
                            marginsSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Jessika_dream71"),
                                Text("Labony_dream71")
                              ],),
                            margins,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Created Date", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),

                                Text("")
                              ],),
                            marginsSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("2020-04-12 12:24 PM"),
                                Text("")
                              ],),
                            margins,
                            LinearProgressIndicator(
                              backgroundColor: Colors.green, value: 100,
                            ),
                            margins

                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        )
    );
  }
  
  
  
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
      body: SafeArea(
        child: ProjectResource.userID == "demo@demo.com"?getAssignedIssuesDemo():
        ProjectResource.userID == "issuer@demo.com"?getIssuerIssues():
        getAssignedIssues(),
      ),

      drawer: Drawer(
        child: ProjectResource.userDrawer(context,this),

      ),

    );
  }
}

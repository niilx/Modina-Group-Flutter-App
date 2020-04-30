import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/Models/issues.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:modina_group_flutter_app_demo/Utils/DatabaseHelper.dart';
import 'package:simple_progress_bar/progress_bar.dart';
import 'package:pie_chart/pie_chart.dart';



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

    //For Pie Chart
    dataMap.putIfAbsent("Completed", () => 6);
    dataMap.putIfAbsent("In Progress", () => 24);
    dataMap.putIfAbsent("Pending", () => 9);
    dataMap.putIfAbsent("Rejected", () => 3);

  }

  double screenWidth;
  var issues;

  Map<String, double> dataMap = new Map();
  List<Color> colorList = [
  Colors.green,Colors.red,
    Colors.blue,
    Colors.deepPurple,
  ];


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
                          ProgressBar(
                              padding: 5,
                              barColor: Colors.green,
                              barHeight: 7,
                              backgroundColor: Colors.grey[300],
                              barWidth: screenWidth*0.9,
                              numerator: 3,
                              denominator: 10,
                              title: '',
                              showRemainder: false,
                              dialogTextStyle: new TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              titleStyle: new TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.transparent)
                          ),

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

                            ProgressBar(
                              padding: 5,
                              barColor: Colors.green,
                              barHeight: 7,
                              backgroundColor: Colors.grey[300],
                              barWidth: screenWidth*0.9,
                              numerator: 3,
                              denominator: 10,
                              title: '',
                              showRemainder: false,
                                dialogTextStyle: new TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                titleStyle: new TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.transparent)
                            ),


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


  getAuditorDashboard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          //Issues Overall
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                child: Container(
                  width: screenWidth*0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.09,
                        height: 40,
                        color: Colors.blue,
                      child: Icon(Icons.assignment,color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Total Issues",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("42",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: screenWidth*0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.09,
                        height: 40,
                        color: Colors.green,
                        child: Icon(Icons.done_all,color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Completed Issues",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("6",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                child: Container(
                  width: screenWidth*0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.09,
                        height: 40,
                        color: Colors.orange,
                        child: Icon(Icons.directions_run,color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("In Progress",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("24",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: screenWidth*0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.09,
                        height: 40,
                        color: Colors.red,
                        child: Icon(Icons.remove_shopping_cart,color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Rejected Issues",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                child: Container(
                  width: screenWidth*0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth*0.09,
                        height: 40,
                        color: Colors.orange,
                        child: Icon(Icons.pause_circle_outline,color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("Pending Issues",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            Text("9",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container()
            ],
          ),
          margins,
          Divider(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              margins,
              Text("Total Issues",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              margins,
              marginsSmall,
              margins,
              PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.5,
                showChartValuesInPercentage: false,
                showChartValues: true,
                showChartValuesOutside: true,
                chartValueBackgroundColor: Colors.transparent,
                colorList: colorList,
                showLegends: true,
                legendPosition: LegendPosition.right,
                decimalPlaces: 0,
                showChartValueLabel: true,
                initialAngle: 0,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
                chartType: ChartType.ring,
              ),
              margins,
              margins,
              margins,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(width: screenWidth,
                    padding: EdgeInsets.all(8),
                    color: Colors.grey[300],
                      height: 30,
                      child: Text("UNIT",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                  ),
                  margins,
                  marginsSmall,
                  Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth*0.4,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.local_printshop),
                              Text("Gaston Battery")
                            ],
                          ),
                          SizedBox(height: 5,),
                          Divider(color: Colors.black,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Issues",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("42",style: TextStyle(fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Completed",style: TextStyle(color: Colors.green),),
                              Text("6",style: TextStyle(fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Pending Issues",style: TextStyle(color: Colors.orange),),
                              Text("9",style: TextStyle(fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Rejected Issues",style: TextStyle(color: Colors.red),),
                              Text("3",style: TextStyle(fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("In Progress",style: TextStyle(color: Colors.blue ),),
                              Text("24",style: TextStyle(fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          SizedBox(height: 5,),


                        ],
                      ),
                    ),
                  ),
                ],
              )

            ],
          )



        ],
      ),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ProjectResource.appBarColor
    ));

   screenWidth = MediaQuery. of(context). size. width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: ProjectResource.userID == "auditor@demo.com"?false: true,
        backgroundColor: ProjectResource.appBarColor,
        title: ProjectResource.userID == "auditor@demo.com"?
        Text("Dashboard", style: TextStyle(color: Colors.white),):
        Text("Assigned Issue List", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
          ),
        ],

      ),
      body: SafeArea(
        child: ProjectResource.userID == "demo@demo.com"?getAssignedIssuesDemo():
        ProjectResource.userID == "issuer@demo.com"?getIssuerIssues():
        ProjectResource.userID == "auditor@demo.com"?getAuditorDashboard():
        getAssignedIssues(),
      ),

      drawer: Drawer(
        child: ProjectResource.userDrawer(context,this),

      ),

    );
  }
}

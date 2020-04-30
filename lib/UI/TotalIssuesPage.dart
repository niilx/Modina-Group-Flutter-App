import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:simple_progress_bar/progress_bar.dart';

class TotalIssues extends StatefulWidget {
  String appBarText;
  TotalIssues({this.appBarText});
  @override
  _TotalIssuesState createState() => _TotalIssuesState(this.appBarText);
}

class _TotalIssuesState extends State<TotalIssues> {
  String appBarText;

  _TotalIssuesState(this.appBarText);

  double screenWidth;

  var margins= SizedBox(height: 15,);
  var marginsSmall= SizedBox(height: 5,);

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


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ProjectResource.appBarColor
    ));

     screenWidth = MediaQuery. of(context). size. width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ProjectResource.appBarColor,
        title: Text(appBarText, style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
          ),
        ],

      ),
      body: SafeArea(
        child: getAssignedIssuesDemo()
      ),

      drawer: Drawer(
        child: ProjectResource.userDrawer(context,this),

      ),

    );
  }
}

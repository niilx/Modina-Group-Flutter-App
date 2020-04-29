import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modina_group_flutter_app_demo/Models/issues.dart';
import 'package:modina_group_flutter_app_demo/ProjectResource.dart';
import 'package:file_picker/file_picker.dart';
import 'package:modina_group_flutter_app_demo/Utils/DatabaseHelper.dart';


class CreateNewIssuePage extends StatefulWidget {
  String user;
  CreateNewIssuePage(this.user);
  @override
  _CreateNewIssuePageState createState() => _CreateNewIssuePageState(this.user);
}

class _CreateNewIssuePageState extends State<CreateNewIssuePage> {
  String user;
  _CreateNewIssuePageState(this.user);

//  ProjectResource.userID = this.user;
  DatabaseHelper helper = DatabaseHelper();

  Issues issue=Issues("","","","","","","","","","","",);

  TextEditingController issueTitle = TextEditingController();
  TextEditingController priority = TextEditingController();
  TextEditingController discussionPoint = TextEditingController();
  TextEditingController issueProcedure = TextEditingController();
  TextEditingController conclusions = TextEditingController();
  String priorityL;
  String unitSelects;
  String deptSelects;
  String asigneeSelects;
  String associateSelects;
  String startDate="";
  String endDate="";

  List<String> units = [
    "Cement Industries Ltd",
    "Maritime Ltd",
    "Filling Service",
    "Madina Polymer Industries Ltd",
    "Polyfiber Ltd",
    "Fruits Limited",
    "Development Ltd",
    "Fruits Ltd",
    "Hiring Ltd",

  ];

  bool showDepts = false;
  List<String> depts = [
    "Accounts & Finance",
    "HR",
    "Sales Admin",
    "Supply Chain",
    "Brand",
    "Sales & Account",
    "Operation",
    "Logistics",
    "Sales and Marketing",

  ];


  bool showAssignees = false;
  List<String> assignees = [
    "Touhidul Islam",
    "Saiful Islam",
    "Abdur Rahman",
    "Sarmin Akter",
  ];

  bool showAssociates = false;
  List<String> associates = [
    "Md Abu Shaid",
    "Din Mohammed",
    "Akif Raihan",
    "Abdullah Al Oany",
    "Alamgir Hossain",
    "Md Hasan",
    "Md. Rakibul Islam",
    "Shadia Zaman Orin",
    "Md. Mostafa Kamal",
    "Kamrun Nahar",
    "Md. Joynal Abedin",
    "Swakat Ali"
  ];



  void _showAlert(String t) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Status"),
      content: Text(t),
      actions: <Widget>[
        RaisedButton(
          child: Text("OK"),
          color: Colors.greenAccent,
          onPressed: () {
            Navigator.of(context);
          },
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void insertIssue(Issues issue) async {
    int result;
    result = await helper.insertIssue(issue);
    if (result != 0) {
      _showAlert("Issue inserted Successfully");
      print("Success");
    } else {
      _showAlert("Issue insertion Failed");
      print("Failed");
    }
  }


  showPicker(){
    return showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(new Duration(days: 1)),
      initialDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }


  String _docx="No file selected";

  void getAttatchFile() async {
    String filePath;
    filePath = await FilePicker.getFilePath(
        type: FileType.custom);
    print(filePath);
    setState(() {
      _docx = filePath + " selected.";
    });
    _reads(filePath);
  }

  Future<String> _reads(String path) async {
    String text;
    try {
      final file = File(path);
      text = await file.readAsString();
    } catch (e) {}
  }


  createIssueBox(){
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[

          Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: TextField(
              controller: issueTitle,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print("value typed $value");
                issue.issues = issueTitle.text.toString();
              },
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  hintText: "Issue Title",
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black54)),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 13)),
            ),
          ),

          SizedBox(height: 15,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.black54, style: BorderStyle.solid, width: 1),
            ),
            child: DropdownButton<String>(
              hint: Text("Select Priority"),
              icon: Icon(Icons.keyboard_arrow_down,),
              value: priorityL,
              iconSize: 24,
              isExpanded: true,
              elevation: 6,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              underline: Container(
                height: 0,
                color: Color(0xffe7e7e7),
              ),
              onChanged: (String newValue) {
                setState(() {
                  priorityL = newValue;
                  issue.issuePrioritys = priorityL;
                });
                print(newValue);
              },
//              hint: Text('Number of Package', style: TextStyle(color: Colors.black),),
              items: <String>['Normal','Urgent','Major']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.center),
                );
              }).toList(),
            ),
          ),


          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text("Unit"),
          ),
          SizedBox(height: 15,),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.black54, width: 1),
            ),
            child: DropdownButton<String>(
              hint: Text("Select One"),
              icon: Icon(Icons.keyboard_arrow_down,),
              value: unitSelects,
              iconSize: 24,
              isExpanded: true,
              elevation: 6,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              underline: Container(
                height: 0,
                color: Color(0xffe7e7e7),
              ),
              onChanged: (String newValue) {
                setState(() {
                  unitSelects = newValue;
                  issue.issueUnits = unitSelects;
                  showDepts = true;
                });
                print(newValue);
              },
//              hint: Text('Number of Package', style: TextStyle(color: Colors.black),),
              items: units
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.center),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 15,),


         showDepts?Column(
           mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Text("Department"),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.black54, width: 1),
                ),
                child: DropdownButton<String>(
                  hint: Text("Select One"),
                  icon: Icon(Icons.keyboard_arrow_down,),
                  value: deptSelects,
                  iconSize: 24,
                  isExpanded: true,
                  elevation: 6,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  underline: Container(
                    height: 0,
                    color: Color(0xffe7e7e7),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      deptSelects = newValue;
                      issue.issueDepts = deptSelects;
                      showAssignees = true;
                    });
                    print(newValue);
                  },
//              hint: Text('Number of Package', style: TextStyle(color: Colors.black),),
                  items: depts
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textAlign: TextAlign.center),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15,),
            ],
          ):Container(),



         showAssignees? Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(left:5.0),
               child: Text("Assignee"),
             ),
             SizedBox(height: 15,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 10.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5.0),
                 border: Border.all(
                     color: Colors.black54, width: 1),
               ),
               child: DropdownButton<String>(
                 hint: Text("Select One"),
                 icon: Icon(Icons.keyboard_arrow_down,),
                 value: asigneeSelects,
                 iconSize: 24,
                 isExpanded: true,
                 elevation: 6,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 18,
                 ),
                 underline: Container(
                   height: 0,
                   color: Color(0xffe7e7e7),
                 ),
                 onChanged: (String newValue) {
                   setState(() {
                     asigneeSelects = newValue;
                     issue.issueAssignedTos = asigneeSelects;
                     showAssociates = true;
                   });
                   print(newValue);
                 },
//              hint: Text('Number of Package', style: TextStyle(color: Colors.black),),
                 items: assignees
                     .map<DropdownMenuItem<String>>((String value) {
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value, textAlign: TextAlign.center),
                   );
                 }).toList(),
               ),
             ),
             SizedBox(height: 15,),
           ],
         ): Container(),


         showAssociates?Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(left:5.0),
               child: Text("Associates"),
             ),
             SizedBox(height: 15,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 10.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5.0),
                 border: Border.all(
                     color: Colors.black54, width: 1),
               ),
               child: DropdownButton<String>(
                 hint: Text("Select One"),
                 icon: Icon(Icons.keyboard_arrow_down,),
                 value: associateSelects,
                 iconSize: 24,
                 isExpanded: true,
                 elevation: 6,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 18,
                 ),
                 underline: Container(
                   height: 0,
                   color: Color(0xffe7e7e7),
                 ),
                 onChanged: (String newValue) {
                   setState(() {
                     associateSelects = newValue;
                   });
                   print(newValue);
                 },
//              hint: Text('Number of Package', style: TextStyle(color: Colors.black),),
                 items: associates
                     .map<DropdownMenuItem<String>>((String value) {
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value, textAlign: TextAlign.center),
                   );
                 }).toList(),
               ),
             ),
             SizedBox(height: 15,)
           ],
         ):Container(),



          //Start and End Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () async {
                DateTime dateTime = await showPicker();
                if(dateTime != null) {
                String date = dateTime.toString().split(" ")[0] ;
                print(date);
                setState(() {
                  startDate = date;
                  issue.issueStartDates = startDate;
                });
                } },
                child: Container(

                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: startDate==""? Text("SELECT START DATE"):Text("START: "+startDate),
                ),
              ),

              InkWell(
                onTap: () async {
                  DateTime dateTime = await showPicker();
                  if(dateTime != null) {
                    String date = dateTime.toString().split(" ")[0] ;
                    print(date);
                    setState(() {
                      endDate = date;
                      issue.issueEndDates = endDate;
                    });
                  } },
                child: Container(

                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: endDate==""? Text("SELECT END DATE"): Text("END: "+endDate),
                ),
              ),
            ],
          ),

          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text("Discussion Point"),
          ),
          SizedBox(height: 15,),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: TextField(
              maxLines: 2,
              controller: discussionPoint,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print("value typed $value");
              },
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  hintText: "Discussion ",
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black54)),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 13)),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text("Procedure"),
          ),
          SizedBox(height: 15,),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: TextField(
              maxLines: 2,
              controller: issueProcedure,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print("value typed $value");
              },
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  hintText: "Issue Procedure ",
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black54)),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 13)),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text("Conclusion"),
          ),
          SizedBox(height: 15,),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: TextField(
              maxLines: 2,
              controller: discussionPoint,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print("value typed $value");
              },
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  hintText: "Conclusion ",
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black54)),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 13)),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text("Attatchment"),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_docx),
              _docx == "No file selected"?Container():IconButton(
                icon: Icon(Icons.clear),
                onPressed: (){
                  setState(() {
                    _docx = "No file selected";
                  });

                },
              )
            ],
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
              width:200,
              child: RaisedButton(

                child: Row(
                  children: <Widget>[
                    Icon(Icons.attach_file),SizedBox(width: 10,),
                    Text("ATTATCH FILE"),
                  ],
                ),
                onPressed: () async{
//                await FilePicker.getFile();
                  //print(filePath);
                  setState(() {
                    getAttatchFile();
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 15,),
          Center(
            child: Container(
              height: 35,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xff58D68D)),
              child: FlatButton(
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                onPressed: () async {
                  setState(() {
                    String createdDate = DateTime.now().toLocal().toString();
                    String createdBy = "Touhidul Islam";
                    issue.issueCreatedDates = createdDate;
                    issue.issueCreatedBys = createdBy;
                    issue.issueStatuss = "Start";
                    issue.issueCodes = "BD-912-1";

                    if(
                    issueTitle.text.isNotEmpty && asigneeSelects.isNotEmpty && unitSelects.isNotEmpty && deptSelects.isNotEmpty
                    ) {
                      insertIssue(issue);
                    }
                      print("Save this");
                  });


//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return DashboardPage();
//                  }));
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
                  //  await _login();
                },
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),

        ],
      ),
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
        title: Text("Create New Issue", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
          ),
        ],

      ),

      drawer: Drawer(
        child: ProjectResource.userDrawer(context,this),

      ),
      body: SafeArea(
        child: createIssueBox()
      ),
    );
  }
}

class Issues{
  int id;
  String issue;
  String issueCode;
  String issueStatus;
  String issuePriority;
  String issueStartDate;
  String issueEndDate;
  String issueUnit;
  String issueDept;
  String issueCreatedBy;
  String issueAssignedTo;
  String issueCreatedDate;


  Issues(this.issue,
      this.issueCode, this.issueStatus,this.issuePriority, this.issueStartDate,this.issueEndDate,
      this.issueUnit, this.issueDept, this.issueCreatedBy, this.issueAssignedTo,this.issueCreatedDate
      );

  int get ids => id;
  String get issueCodes => issueCode;
  String get issues => issue;
  String get issueStatuss => issueStatus;
  String get issuePrioritys => issuePriority;
  String get issueStartDates => issueStartDate;
  String get issueEndDates => issueEndDate;
  String get issueUnits => issueUnit;
  String get issueDepts => issueDept;
  String get issueCreatedBys => issueCreatedBy;
  String get issueAssignedTos => issueAssignedTo;
  String get issueCreatedDates => issueCreatedDate;


  set issueCodes(String issueCodes) {
    this.issueCode= issueCodes;
  }

  set issues(String issues) {
    this.issue= issues;
  }

  set issueStatuss(String issueStatuss) {
    this.issueStatus= issueStatuss;
  }


  set issuePrioritys(String issuePrioritys) {
    this.issuePriority= issuePrioritys;
  }

  set issueStartDates(String issueStartDates) {
    this.issueStartDate= issueStartDates;
  }

  set issueEndDates(String issueEndDates) {
    this.issueEndDate= issueEndDates;
  }

  set issueUnits(String issueUnits) {
    this.issueUnit= issueUnits;
  }

  set issueDepts(String issueDepts) {
    this.issueDept= issueDepts;
  }

  set issueCreatedBys(String issueCreatedBys) {
    this.issueCreatedBy= issueCreatedBys;
  }

  set issueAssignedTos(String issueAssignedTos) {
    this.issueAssignedTo= issueAssignedTos;
  }

  set issueCreatedDates(String issueCreatedDates) {
    this.issueCreatedDate= issueCreatedDates;
  }


  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] =id;
    map['issue'] =issue;
    map['issue_code'] = issueCode;
    map['issue_status'] = issueStatus;
    map['issue_priority'] = issuePriority;
    map['start_date'] = issueStartDate;
    map['end_date'] = issueEndDate;
    map['unit'] = issueUnit;
    map['dept'] = issueDept;
    map['created_by'] = issueCreatedBy;
    map['assigned_to'] = issueAssignedTo;
    map['created_date'] = issueCreatedDate;
    return map;
  }

  Issues.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.issue = map['issue'];
    this.issueCode = map['issue_code'];
    this.issueStatus = map['issue_status'];
    this.issuePriority = map['issue_priority'];
    this.issueStartDate = map['start_date'];
    this.issueEndDate = map['end_date'];
    this.issueUnit = map['unit'];
    this.issueDept = map['dept'];
    this.issueCreatedBy = map['created_by'];
    this.issueAssignedTo = map['assigned_to'];
    this.issueCreatedDate =  map['created_date'];


  }



}

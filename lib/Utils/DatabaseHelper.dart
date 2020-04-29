import 'dart:io';
import 'package:modina_group_flutter_app_demo/Models/issues.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;


  String issueTable ='issue_table';
  String colIssueID = 'id';
  String colIssue = 'issue';
  String colIssueCode = 'issue_code';
  String colIssueStatus = 'issue_status';
  String colIssuePriority = 'issue_priority';
  String colStartDate = 'start_date';
  String colEndDate = 'end_date';
  String colUnit = 'unit';
  String colDept = 'dept';
  String colCreatedBy = 'created_by';
  String colAssignedTo = 'assigned_to';
  String colCreatedDate = 'created_date';




  DatabaseHelper.createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'madinagroup.db';

    var regDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return regDatabase;
  }


  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $issueTable($colIssueID INTEGER AUTOINCREMENT, $colIssueCode TEXT, $colIssueStatus TEXT,$colIssue TEXT, $colIssuePriority TEXT,$colStartDate TEXT, $colEndDate TEXT , $colUnit TEXT, $colDept TEXT, $colCreatedBy TEXT,$colAssignedTo TEXT,$colCreatedDate TEXT)');

  }



  Future<List<Map>> getAllIssues() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $issueTable ORDER BY $colCreatedDate DESC");

    return result;
  }



//
//
//  Future<List<Map>> getUserBank(users_update user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $banksTable WHERE $colphone = '${user.phone}' ");
//
//    return result;
//    //getbank
//  }
//
//  Future<List<Map>> getPayee(users_update user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT $colPaUser,$colPBank,$colPAmount, $colPDate FROM $PayerTable WHERE $colPrUser='${user.phone}' UNION SELECT $colRPhone, $colMemo, $colAmount,$colRDate FROM $RecTable WHERE $colPid = '${user.id}' ORDER BY $colRDate DESC");
//    return result;
//  }
//
//  Future<List<Map>> getPayers() async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $PayerTable ORDER BY $colPDate DESC");
//    return result;
//  }
//
//  Future<List<Map>> getPayerChecks(users_update user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $PayerTable WHERE $colPused = 1 ORDER BY $colPDate DESC");
//    return result;
//  }

  Future<int> insertIssue(Issues issue) async {
    Database db = await this.database;
    var result = db.insert(issueTable, issue.toMap());
    return result;
  }



//  Future<int> updateNote(note note) async {
//    Database db = await this.database;
//    var result = db.update(regTable, note.toMap(),
//        where: '$colID=?', whereArgs: [note.id]);
//
//    return result;
//  }
//
//  Future<int> updateNote1(note note) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        'UPDATE $regTable SET $colSelected =0 WHERE $colUsername = ${note.username}');
//
//    return result;
//  }
//
//  Future<int> updatePrevAcc(double amount, note user) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regTable SET $colTotalAmount ='$amount' WHERE $colUsername = '${user.username}'");
//
//    return result;
//  }
//
//  Future<int> updateTotalAmount(String phone, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $colTotalAmount ='$amount' WHERE $colUsername = '$phone'");
//
//    return result;
//  }
//
//  Future<int> updateTotalChecks(String phone, int checks) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $colCheckPages ='$checks' WHERE $colphone = '$phone'");
//    return result;
//  }
//
//
//  Future<int> updateTotalbalance(String phone, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $coltotalBalance ='$amount' WHERE $colphone = '$phone'");
//    return result;
//  }
//
//  Future<int> updateBankbalance(String phone, String bankname, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $banksTable SET $colBankBalance ='$amount' WHERE $colphone = '$phone' AND $colBankName ='$bankname'");
//    return result;
//  }
//
//  Future<int> updateoutstandingbalance(String phone, String bankname, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $coloutstandingbalance ='$amount' WHERE $colphone = '$phone'");
//    return result;
//  }
//  Future<int> updateoutstandingbalanceSub(String phone, String bankname, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $coloutstandingbalance ='$amount' WHERE $colphone = '$phone'");
//    return result;
//  }
//  Future<int> updateTotalbalanceAndCheck(String phone, double amount, int checkpages) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $coltotalBalance ='$amount' , $colCheckPages=$checkpages WHERE $colphone = '$phone'");
//    return result;
//  }
//
//  Future<int> updatePayerChecks(String checks, int a) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $PayerTable SET $colPused =0 WHERE $colPCheckCode = '$checks' ");
//    return result;
//  }
//
//
//
//  Future<int> updateSelectedBank(String user, double amount) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regTable SET $colBalance ='$amount' WHERE $colUsername = '$user' AND $colSelected =1 ");
//
//    return result;
//  }
//
//  Future<int> updatePin(String pin, users_update user, String signbase64) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $banksTable SET $colTPin ='$pin' , $colTsign ='$signbase64' WHERE $colphone = '${user.phone}'");
//
//    return result;
//  }
//
//
//  Future<int> updatePass(String pass, users_update user) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $colPass ='$pass' WHERE $colphone = '${user.phone}'");
//
//    return result;
//  }
//
//  Future<int> updateInfo(String name, users_update user) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $regiTable SET $colName ='$name' WHERE $colphone = '${user.phone}'");
//    return result;
//  }
//
//  Future<int> SelectBank(users_update user, String bank, String branch) async {
//    Database db = await this.database;
//    var result = db.rawUpdate(
//        "UPDATE $banksTable SET $colBankSelected = 0 WHERE $colphone = '${user.phone}'");
//    result = db.rawUpdate("UPDATE $banksTable SET $colBankSelected =1 WHERE $colphone = '${user.phone}' AND $colBankName ='$bank' AND $colBranch='$branch'");
//
//    return result;
//  }
//
//  Future<int> updateReceiver(Receiver receiver) async {
//    Database db = await this.database;
//    var result = db.update(RecTable, receiver.toMap(),
//        where: '$colRid=?', whereArgs: [receiver.Rid]);
//
//    return result;
//  }
//
//  Future<note> getUser(String user, String pass) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $regTable WHERE $colUsername='$user' AND $colPassword= '$pass' AND $colSelected =1 ");
//    if (result.length == 0) return null;
//    return note.fromMap(result.first);
//  }
//
//
//  Future<users_update> refreshUsers(String phone) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $regiTable WHERE $colphone='$phone'");
//    if (result.length == 0) return null;
//    return users_update.fromMap(result.first);
//  }
//  Future<users_banks> refreshbanks(users_update user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $banksTable WHERE $colphone='${user.phone}' AND $colBankSelected =1 ");
//    if (result.length == 0) return null;
//    return users_banks.fromMap(result.first);
//  }
//
//
//  Future<users_update> getUsers(String phone, String pass) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $regiTable WHERE $colphone='$phone' AND $colPass= '$pass'");
//    if (result.length == 0) return null;
//    return users_update.fromMap(result.first);
//  }
//
//  Future<users_update> phoneChecks(String phone) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $regiTable WHERE $colphone='$phone' ");
//    if (result.length == 0) return null;
//    return users_update.fromMap(result.first);
//  }
//
//  Future<users_banks> getUsersbanks(users_update user, String bankname) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $banksTable WHERE $colphone='${user.phone}' AND $colBankName= '$bankname'");
//    if (result.length == 0) return null;
//    return users_banks.fromMap(result.first);
//  }
//  Future<users_banks> getbanks(users_update user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $banksTable WHERE $colphone='${user.phone}' AND $colBankSelected =1 ");
//    if (result.length == 0) return null;
//    return users_banks.fromMap(result.first);
//  }
//
//  Future<users_banks> getTsign(users_banks user) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT $colTsign FROM $banksTable WHERE $colphone='${user.phone}' AND $colBankName='${user.bankname}' ");
//    if (result.length == 0) return null;
//    return users_banks.fromMap(result.first);
//  }
//
//  Future<user_keys> getKeys(user_keys keys, int id) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $keysTable WHERE $colKPhone='${keys.phone}' AND $colKId =$id");
//    if (result.length == 0) return null;
//    return user_keys.fromMap(result.first);
//  }
//  Future<user_keys> getPrivateKeys(int keyId) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $keysTable WHERE $colKId=$keyId");
//    if (result.length == 0) return null;
//    return user_keys.fromMap(result.first);
//  }
//
//  Future<Payers> getValidityofCheck(String checkcode) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $PayerTable WHERE $colCheckCode='$checkcode'");
//    if (result.length == 0) {return null; }
//    else{
//      return Payers.fromMap(result.first);
//    }
//
//  }
//
//  Future<Payers> getPayerinfoofCheck() async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $PayerTable");
//    return Payers.fromMap(result.first);
//
//  }
//
//  Future<note> getUserInfo(String user, String bank) async {
//    Database db = await this.database;
//    var result = await db.rawQuery(
//        "SELECT * FROM $regTable WHERE $colUsername='$user' AND $colBank= '$bank'");
//    if (result.length == 0) return null;
//    return note.fromMap(result.first);
//  }
//
//  Future<Receiver> getReceiver(String rphone) async {
//    Database db = await this.database;
//    var result =
//    await db.rawQuery("SELECT * FROM $RecTable WHERE $colRPhone='$rphone'");
//    if (result.length == 0) return null;
//    return Receiver.fromMap(result.first);
//  }
//
//  Future<int> deleteNote(int id) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $regTable WHERE $colID=$id");
//
//    return result;
//  }
//
//  Future<int> deleteUser(String user) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $regTable WHERE $colUsername='$user'");
//
//    return result;
//  }
//
//  Future<int> deleteUserBank(String bankphone, String bank) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $banksTable WHERE $colBankPhone='$bankphone' AND $colBankName = '$bank'");
//    return result;
//  }
//
//  Future<int> EditUserBank(String bankphone, String bank) async {
//    Database db = await this.database;
//    var result = db.rawDelete("UPDATE $banksTable SET $colBankName = '$bank' WHERE $colBankPhone='$bankphone'");
//    return result;
//  }
//
//  Future<int> deletePayee(int pid, String rphone, String bank) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $RecTable WHERE $colRPhone='$rphone'");
//    return result;
//  }
//
//  Future<int> deletePayer(String pauser,String acc_no, String bank) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $PayerTable WHERE $colPAccNo='$acc_no'");
//    return result;
//  }
//
//  Future<int> deleteAll() async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $regiTable");
//    result = db.rawDelete("DELETE FROM $RecTable");
//    result =db.rawDelete("DELETE FROM $PayerTable");
//    result =db.rawDelete("DELETE FROM $banksTable");
//    return result;
//  }
//
//  Future<int> deleteAcc(users_update user, users_banks bank) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $regiTable WHERE $colphone='${user.phone}'");
//    result = db.rawDelete("DELETE FROM $RecTable WHERE $colRPhone='${user.phone}' ");
//    result =db.rawDelete("DELETE FROM $PayerTable WHERE $colPrUser ='${user.phone}' ");
//    result =db.rawDelete("DELETE FROM $banksTable WHERE $colphone='${user.phone}'");
//    //  result = db.rawDelete("DELETE FROM $PayerTable WHERE $colPrUser='${user.phone}'");
//    return result;
//  }
//
//  Future<int> deleteAccs(users_update user) async {
//    Database db = await this.database;
//    var result = db.rawDelete("DELETE FROM $regiTable WHERE $colphone='${user.phone}'");
//    return result;
//  }
//
//  Future<int> getCount() async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT COUNT($colphone) FROM $regiTable ");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//  Future<int> getCountCheck(users_update user) async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT COUNT($colPCheckCode) FROM $PayerTable WHERE $colPused=1 AND $colPrUser ='${user.phone}' ");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//  Future<int> checkAdd(users_update user) async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT SUM($colPAmount) as Total FROM [$PayerTable] WHERE $colPused=1");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//  Future<int> getCountBank(users_banks bank,users_update user) async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT COUNT (*) FROM $banksTable WHERE $colphone = '${user.phone}'");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//  Future<int> getOutstandingBalance(users_update user) async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT SUM ($colPAmount) FROM $PayerTable WHERE $colPrUser = '${user.phone}' AND $colPused =1 ");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//  Future<int> getOutstandingCheck(users_update user) async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//    await db.rawQuery("SELECT COUNT ($colPused) FROM $PayerTable WHERE $colPrUser = '${user.phone}' AND $colPused =1 ");
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//
//
//  Future<List<note>> getNoteList() async {
//    var noteMapList = await getNoteMapList();
//    int count = noteMapList.length;
//    List<note> noteList = List<note>();
//    for (int i = 0; i < count; i++) {
//      noteList.add(note.fromMap(noteMapList[i]));
//    }
//    return noteList;
//  }
//
//  Future<List> calculateTotalReceive() async {
//    Database db = await this.database;
//    var result = await db.rawQuery("SELECT * FROM $RecTable");
//    return result.toList();
//  }
//
//  Future<List> calculateTotalPayment() async {
//    Database db = await this.database;
//    var result = await db.rawQuery("SELECT * FROM $PayerTable");
//    return result.toList();
//  }
//
//
//  Future<List> calculateTotalReceiveToday(String date) async {
//    Database db = await this.database;
//    var result = await db.rawQuery("SELECT * FROM $RecTable WHERE $colRDate='$date' ");
//    return result.toList();
//
//  }
//  Future<List> calculateTotalPaymentToday(String date) async {
//    Database db = await this.database;
//    var result = await db.rawQuery("SELECT * FROM $PayerTable WHERE $colPDate='$date' ");
//
//    return result.toList();
//  }


}
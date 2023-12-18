// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:student_recard/Screen/list_s_record.dart';
//import 'package:student_recard/Screen/add_s_record.dart';
//import 'package:student_recard/Screen/list_s_record.dart';

import '../Model/student_model.dart';

import '../ShowToast/show_toast.dart';

MyDb mydb = MyDb();

signUpStudent(
  String username,
  String mobile_no,
  String email,
  String password,
) async {
  try {
    var list = await mydb.db
        .rawQuery("SELECT email FROM students WHERE email='$email'");

    if (list.length == 0) {
      mydb.db.rawInsert(
          "INSERT INTO students (username, mobile_no, email , password ) VALUES (?, ?, ? , ? );",
          [username, mobile_no, email, password]);
      showToast("Save data successfully");
      Get.back();
    } else {
      showToast("Email Allready exists");
    }
  } catch (e) {
    showToast("Error $e");
  }
}

List<Map> slist = [];
getdata(email, password) {
  Future.delayed(Duration(milliseconds: 500), () async {
    try {
      slist = await mydb.db.rawQuery(
          "SELECT * FROM students WHERE email='$email' AND password='$password'");
      if (slist.length > 0) {
        //var data = slist.first;
        //  print(data["username"]);
        //  print(data["password"]);
        Get.offAll(() => const ListSRecord());
      } else {
        showToast("user no valid email or password");
      }
    } catch (e) {
      showToast("Error $e");
    }
  });
}


//   getrecord() {
//     Future.delayed(Duration(milliseconds: 500), () async {
//       //use delay min 500 ms, because database takes time to initilize.
//       slist = await mydb.dbcon.rawQuery('SELECT * FROM s_record ');

//       setState(() {}); //refresh UI after getting data from table.
//     });
//   }
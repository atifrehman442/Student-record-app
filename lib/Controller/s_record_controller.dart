// // ignore_for_file: unnecessary_null_comparison


import 'package:student_recard/Model/student_model.dart';

import '../ShowToast/show_toast.dart';

MyDb mydb = MyDb();

addstudentrecord(String name, String rollno, String address) async {
  try {
    // mydb.record();
    // var list = await mydb.db
    //     .rawQuery("SELECT roll_no FROM s_record WHERE roll_no='$rollno'");

    // if (list.length == 0) {
    await mydb.db.rawInsert(
        "INSERT INTO s_record (name, roll_no, address ) VALUES (?, ?, ? )",
        [name, rollno, address]);
    showToast("Save data successfully");
    //Get.back();
    // } else {
    //   showToast("RollNumber Allready exists");
    // }
  } catch (e) {
    showToast("Error $e");
  }
}

editstudentrecord(int id, String name, String rollno, String address) async {
  try {
    await mydb.db.rawInsert(
        "UPDATE s_record SET name = '$name', roll_no = '$rollno', address = '$address' WHERE id = '$id'");
    showToast("Save data successfully");
  } catch (e) {
    showToast("Error $e");
  }
}


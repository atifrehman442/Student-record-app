// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_recard/Screen/add_s_record.dart';
import 'package:student_recard/Screen/login.dart';

import '../Allcolors/allcolor.dart';
import '../Model/student_model.dart';
import 'edit_s_record.dart';

class ListSRecord extends StatefulWidget {
  const ListSRecord({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListSRecord();
  }
}

class _ListSRecord extends State<ListSRecord> {
  MyDb mydb = MyDb();

  List<Map> slist = [];

  @override
  void initState() {
    mydb.open();
    getrecord();
    super.initState();
  }

  // getrecord()async {
  //     slist = await mydb.dbcon.rawQuery('SELECT * FROM s_record ');
  //     // setState(() {});
  //   }
  getrecord() {
    Future.delayed(Duration(milliseconds: 500), () async {
      //use delay min 500 ms, because database takes time to initilize.
      slist = await mydb.db.rawQuery('SELECT * FROM s_record ');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of Students"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: primarycolor,
          actions: [IconButton(onPressed: (){
            Get.offAll(()=>LoginPage());
          }, icon: Icon(Icons.logout))],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: slist.length == 0
                ? const Text("No any students to show.")
                : //show message if there is no any student
                Column(
                    //or populate list to Column children if there is student data.
                    children: slist.map((stuone) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: Text(stuone["name"]),
                          subtitle: Row(
                            children: [
                              Text("Roll No:" + stuone["roll_no"].toString()),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(" Address: " + stuone["address"]),
                            ],
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditSRocord(data: stuone)));
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async {
                                    await mydb.db.rawDelete(
                                        "DELETE FROM s_record WHERE id = ?",
                                        [stuone["id"]]);
                                    //delete student data with roll no.
                                    print("Data Deleted");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Student Data Deleted")));
                                    getrecord();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red))
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddSRocord());
          },
          backgroundColor: primarycolor,
          child: const Icon(Icons.add),
        ));
  }
}

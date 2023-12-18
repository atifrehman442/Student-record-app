import 'package:flutter/material.dart';
import 'package:student_recard/Allcolors/allcolor.dart';
import 'package:student_recard/Controller/s_record_controller.dart';
import 'package:student_recard/Screen/list_s_record.dart';

import '../ShowToast/show_toast.dart';

class AddSRocord extends StatefulWidget {
  const AddSRocord({super.key});

  @override
  State<AddSRocord> createState() => _AddSRocordState();
}

class _AddSRocordState extends State<AddSRocord> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Add Student",
              style: TextStyle(color: textcolor),
            ),
            centerTitle: true,
            backgroundColor: primarycolor,
            automaticallyImplyLeading: false),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Stuent Name",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: const InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  hintText: "Address:",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    var Name = name.text.trim();
                    var Rollno = rollno.text.trim();
                    var Address = address.text.trim();
                    if (Name != "" && Rollno != "" && Address != "") {
                      addstudentrecord(Name, Rollno, Address);
                      name.text = "";
                      rollno.text = "";
                      address.text = "";
                    } else {
                      showToast("This field is required");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textcolor,
                    backgroundColor: primarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListSRecord())).then((_) {
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textcolor,
                    backgroundColor: primarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

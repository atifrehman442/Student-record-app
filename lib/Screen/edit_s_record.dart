import 'package:flutter/material.dart';
import 'package:student_recard/Allcolors/allcolor.dart';
import 'package:student_recard/Screen/list_s_record.dart';

import '../Controller/s_record_controller.dart';
import '../ShowToast/show_toast.dart';


class EditSRocord extends StatefulWidget {
  final data;
  const EditSRocord({
    super.key,
    required Map this.data,
  });
  @override
  State<EditSRocord> createState() => _EditSRocordState();
}

class _EditSRocordState extends State<EditSRocord> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();
  late int id;
  @override
  void initState() {
    name.text = widget.data['name'];
    rollno.text = widget.data['roll_no'].toString();
    address.text = widget.data['address'];
    id = widget.data['id'];
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Student",
            style: TextStyle(color: textcolor),
          ),
           automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: primarycolor,
        ),
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
                      editstudentrecord(id, Name, Rollno, Address);
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

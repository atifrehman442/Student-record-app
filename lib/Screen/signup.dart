// ignore: file_names
// ignore_for_file: unused_local_variable, avoid_print, unused_field, unnecessary_null_comparison, unrelated_type_equality_checks, sort_child_properties_last, camel_case_types, non_constant_identifier_names, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:student_recard/Allcolors/allcolor.dart';
import 'package:student_recard/Controller/student_controller.dart';

import '../ShowToast/show_toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobile_noController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateEmail(String email) {
    final pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    final pattern = r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  late bool _passwordVisible;
  @override
  void initState() {
    mydb.open();
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: appbardesign(),
                        child: Container(
                          color: const Color.fromARGB(255, 0, 234, 255),
                          height: 550,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: appbardesign(),
                      child: Container(
                        height: 520,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(134, 0, 234, 255),
                          Color.fromARGB(255, 136, 229, 245),
                          Color.fromARGB(255, 165, 234, 241),
                        ])),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter user name",
                          labelText: "user name"),
                    ),
                    TextFormField(
                      controller: mobile_noController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Enter phone number",
                          labelText: "phone number"),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Entr Email",
                        labelText: "Email",
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _passwordVisible = true;
                            });
                          },
                          onLongPressUp: () {
                            setState(() {
                              _passwordVisible = false;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        prefixIcon: const Icon(Icons.password),
                        hintText: "Entr Password",
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    SizedBox(
                      height: 70,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          var Username = usernameController.text.trim();
                          var Mobile_no = mobile_noController.text.trim();
                          var Email = emailController.text.trim();
                          var Password = passwordController.text.trim();
                          if (Username != "" &&
                              Mobile_no != "" &&
                              Email != "" &&
                              Password != "") {
                            if (validateEmail(Email)) {
                              if (validatePhoneNumber(Mobile_no)) 
                              {
                                signUpStudent(
                                  Username,
                                  Mobile_no,
                                  Email,
                                  Password,
                                );
                                usernameController.text = "";
                                mobile_noController.text = "";
                                emailController.text = "";
                                passwordController.text = "";
                              } else {
                                showToast("Email and Phone Number are invalid");
                              }
                            } else {
                              showToast("Email are invalid");
                            }
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
                          "SignUp",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Allready have an account LogIn",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class appbardesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 20);
    var firstControlPoint =
        Offset(size.width / 4 - size.width / 8, size.height - 150);
    var firstEndPoint =
        Offset(size.width / 4 + size.width / 8, size.height - 100);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 1, size.height);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(appbardesign oldClipper) => false;
}

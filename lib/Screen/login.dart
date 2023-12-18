// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, camel_case_types, unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:student_recard/Allcolors/allcolor.dart';
import 'package:student_recard/ShowToast/show_toast.dart';

import '../Controller/student_controller.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateEmail(String email) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  // bool validatePassword(String password) {
  //   const pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  //   final regExp = RegExp(pattern);
  //   return regExp.hasMatch(password);
  // }

  late bool _passwordVisible;

  var email;
  var password;

  void login() {
    getdata(email, password);
  }

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
                        //color: const Color.fromARGB(255, 0, 234, 255),
                        height: 520,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(134, 0, 234, 255),
                          Color.fromARGB(255, 136, 229, 245),
                          Color.fromARGB(255, 165, 234, 241),
                        ])),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(350, 130, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.black,
                        ),
                        radius: 100,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(360, 350, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Student Profile",
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.edit)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 100, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Entr UserEmail",
                          labelText: "UserEmail",
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
                            email = emailController.text.trim();
                            password = passwordController.text.trim();
                            if (email != "" && password != "") {
                              if (validateEmail(email)) {
                                login();
                                emailController.text = "";
                                passwordController.text = "";
                              } else {
                                showToast("Email and password are invalid");
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
                            "login",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Don't have an account Signup",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
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

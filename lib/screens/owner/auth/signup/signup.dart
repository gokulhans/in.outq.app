import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/screens/owner/auth/login/login.dart';
import 'package:outq/screens/owner/store/create/create_store.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/text_strings.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = false;

class OwnerSignUpPage extends StatefulWidget {
  const OwnerSignUpPage({super.key});

  @override
  State<OwnerSignUpPage> createState() => _OwnerSignUpPageState();
}

TextEditingController nameController = TextEditingController(text: '');
TextEditingController emailController = TextEditingController(text: '');
TextEditingController pswdController = TextEditingController(text: '');

OwnerSignUpModel owners = OwnerSignUpModel('', '', '', '', '');

class _OwnerSignUpPageState extends State<OwnerSignUpPage> {
  Future save() async {
    // print({owners.name, owners.email, owners.pswd});
    final response = await http.post(
        Uri.parse(
          "${apidomain}auth/owner/register",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'name': owners.name,
          'email': owners.email,
          'pswd': owners.pswd,
          'phone': owners.phone,
          'deviceid': owners.deviceid
        });

    Color? msgclr;
    String? msg;
    String? msgdesc;
    var str;

    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      str = jsonData[0]["id"];

      msgclr = Colors.green[400];
      msg = "Signup Success";
      msgdesc = "User Signed Successfully";
    } else {
      msgclr = Colors.red[400];
      msg = "Signup Failed";
      msgdesc = "Email already in use";
      setState(() {
        isLoading = false;
      });
    }

    Get.snackbar(
      msg,
      msgdesc,
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: msgclr,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.bounceIn,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("ownerid", str);
    // Get.to(() => {OwnerExitHome(currentIndex:0)});
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const CreateStorePage()),
        (Route<dynamic> route) => false);
  }

  bool isLoading = false;
  bool passwordVisible = false;
  String repswd = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((token) {
      owners.deviceid = token!;
      print('Device token 1 : $token');
      print('Device token 2 : ${owners.deviceid}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(tDefaultSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Center(
                      child: Text(
                        tOwnerSignUp,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        //controller: nameController,
                        onChanged: (val) {
                          owners.name = val;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Name ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      const SizedBox(height: 10.0),
                      // TextField(
                      //   //controller: emailController,
                      //   onChanged: (val) {
                      //     owners.email = val;
                      //   },
                      //   decoration: const InputDecoration(
                      //       labelText: 'Email',
                      //       labelStyle: TextStyle(
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //       // hintText: 'EMAIL',
                      //       // hintStyle: ,
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.green))),
                      // ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          // Check if the entered text is a valid email address using a regex pattern
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        //controller: emailController,
                        onChanged: (val) {
                          owners.email = val;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        // //controller: emailController,
                        onChanged: (val) {
                          owners.phone = val;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      addVerticalSpace(10),
                      TextFormField(
                        // //controller: pswdController,
                        onChanged: (val) {
                          owners.pswd = val;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          String pattern =
                              r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          if (value != owners.pswd ||
                              !RegExp(pattern).hasMatch(value!)) {
                            return 'Minimum 8 characters, At least one number and \none special character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: passwordVisible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: passwordVisible,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // //controller: pswdController,
                        onChanged: (val) {
                          repswd = val;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != owners.pswd) {
                            return 'Password mismatch';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'ReEnter Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),

                      // TextField(
                      //   //controller: pswdController,
                      //   onChanged: (val) {
                      //     owners.pswd = val;
                      //   },
                      //   decoration: const InputDecoration(
                      //       labelText: 'Password',
                      //       labelStyle: TextStyle(
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.green))),
                      //   //obscureText: true,
                      // ),

                      // const Padding(
                      //   padding: EdgeInsets.only(top: 24.0),
                      //   child: Text(
                      //     "Signup Failed. Try Again!",
                      //     style: TextStyle(
                      //         color: Colors.red, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      addVerticalSpace(30),
                      // ignore: sized_box_for_whitespace
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueAccent,
                            color: ColorConstants.blue,
                            elevation: 7.0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                // print("saved");
                                if (owners.email.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(owners.email)) {
                                  Get.snackbar(
                                    "Invalid Email",
                                    "Enter Valid Email Address",
                                    icon: const Icon(Icons.person,
                                        color: Colors.white),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(15),
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 3),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.bounceIn,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else if (owners.name.isEmpty ||
                                    owners.email.isEmpty ||
                                    owners.phone.isEmpty ||
                                    owners.pswd.isEmpty) {
                                  Get.snackbar(
                                    "Fill Every Field",
                                    "Fill every fields to continue",
                                    icon: const Icon(Icons.person,
                                        color: Colors.white),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(15),
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 3),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.bounceIn,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else if (owners.pswd != repswd) {
                                  Get.snackbar(
                                    "Password Didn't Match",
                                    "Password and Re entered Password Are Different",
                                    icon: const Icon(Icons.person,
                                        color: Colors.white),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(15),
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 3),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.bounceIn,
                                  );
                                } else if (!RegExp(
                                        r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(owners.pswd)) {
                                  Get.snackbar(
                                    "Password Not Secure",
                                    "Minimum 8 characters, one number and one spacial character",
                                    icon: const Icon(Icons.person,
                                        color: Colors.white),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    borderRadius: 12,
                                    margin: const EdgeInsets.all(15),
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 3),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.bounceIn,
                                  );
                                } else {
                                  save();
                                }
                              },
                              child: isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text(
                                        tSignUp,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          )),
                      addVerticalSpace(20),
                    ],
                  )),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    tOwnerLoginQuestion,
                  ),
                  TextButton(
                    child: Text(tOwnerLogin,
                        style: TextStyle(
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Get.to(() => const OwnerLoginPage()),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

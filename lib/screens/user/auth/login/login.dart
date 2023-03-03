import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/Backend/models/user_models.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/screens/user/auth/signup/signup.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/text_strings.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = false;

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

TextEditingController nameController = TextEditingController(text: '');
TextEditingController emailController = TextEditingController(text: '');
TextEditingController pswdController = TextEditingController(text: '');

UserLoginModel users = UserLoginModel('', '');

class _UserLoginPageState extends State<UserLoginPage> {
  Future login_save(BuildContext context) async {
    // print({users.email, users.pswd});
    final response = await http.post(
        Uri.parse(
          "${apidomain}auth/user/login",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'email': users.email,
          'pswd': users.pswd,
        });

    var jsonData = jsonDecode(response.body);
    Color? msgclr;
    String? msg;
    String? msgdesc;
    var str;
    if (response.statusCode == 201) {
      str = jsonData[0]["id"];
      msgclr = Colors.green[400];
      msg = "Login Success";
      msgdesc = "User Logined Successfully";
    } else {
      msgclr = Colors.red[400];
      msg = "Login Failed";
      msgdesc = "Incorrect Email or Password";
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
    pref.setString("userid", str);
    // Get.to(() => {UserExitHome(currentIndex:0)});

    // Get.snackbar(
    //   "Login Successfull",
    //   "Logined",
    //   colorText: Colors.white,
    //   backgroundColor: Colors.lightBlue,
    //   icon: const Icon(Icons.add_alert),
    // );
    Get.offAll(() => const UserExithome());
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
                        tLogin,
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
                      const SizedBox(height: 10.0),
                      TextField(
                        // //controller: emailController,
                        onChanged: (val) {
                          users.email = val;
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
                        //controller: pswdController,
                        onChanged: (val) {
                          users.pswd = val;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        //obscureText: true,
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 24.0),
                      //   child: Text(
                      //     "Login Failed. Try Again!",
                      //     style: TextStyle(
                      //         color: Colors.red, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      const SizedBox(height: 30.0),
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
                                login_save(context);
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
                                        tLogin,
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
                    tLoginQuestion,
                  ),
                  TextButton(
                    child: Text(tSignUp,
                        style: TextStyle(
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Get.to(() => const UserSignUpPage()),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

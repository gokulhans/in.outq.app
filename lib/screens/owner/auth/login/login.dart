import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/screens/owner/auth/signup/signup.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/text_strings.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = false;

class OwnerLoginPage extends StatefulWidget {
  const OwnerLoginPage({super.key});

  @override
  State<OwnerLoginPage> createState() => _OwnerLoginPageState();
}

TextEditingController nameController = TextEditingController(text: '');
TextEditingController emailController = TextEditingController(text: '');
TextEditingController pswdController = TextEditingController(text: '');

OwnerLoginModel owners = OwnerLoginModel('', '');

class _OwnerLoginPageState extends State<OwnerLoginPage> {
  Future save() async {
    // print({owners.email, owners.pswd});
    final response = await http.post(
        Uri.parse(
          "${apidomain}auth/owner/login",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'email': owners.email,
          'pswd': owners.pswd,
        });

    Color? msgclr;
    String? msg;
    String? msgdesc;
    var str;
    var ownerid, storeid;
    // print(storeid);
    // print(ownerid);

    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      ownerid = jsonData[0]["id"];
      storeid = jsonData[0]["storeid"];
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
    pref.setString("ownerid", ownerid);
    pref.setString("storeid", storeid);
    // Get.to(() => {OwnerExitHome(currentIndex:0)});
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const OwnerExithome()),
        (Route<dynamic> route) => false);
  }

  bool isLoading = false;

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
                        tOwnerLogin,
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
                        //controller: pswdController,
                        onChanged: (val) {
                          owners.pswd = val;
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
                      //   padding: EdgeInsets.only(top:24.0),
                      //   child: Text("Login Failed. Try Again!",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
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
                                save();
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
                    tOwnerSignUpQuestion,
                  ),
                  TextButton(
                    child: Text(tOwnerSignUp,
                        style: TextStyle(
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Get.to(() => const OwnerSignUpPage()),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

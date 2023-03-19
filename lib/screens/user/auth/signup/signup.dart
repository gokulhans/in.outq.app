import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/Backend/models/user_models.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/screens/user/auth/login/login.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/text_strings.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = false;

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

// TextEditingController nameController = TextEditingController(text: '');
// TextEditingController emailController = TextEditingController(text: '');
// TextEditingController pswdController = TextEditingController(text: '');

UserSignUpModel users = UserSignUpModel('', '', '', '', '', '', '');

class _UserSignUpPageState extends State<UserSignUpPage> {
  Future signup_save(BuildContext context) async {
    // print({users.name, users.email, users.pswd});
    final response = await http.post(
        Uri.parse(
          "${apidomain}auth/user/register",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'name': users.name,
          'email': users.email,
          'pswd': users.pswd,
          'phone': users.phone,
          'location': "",
          'pincode': "",
          'deviceid': users.deviceid
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
    pref.setString("userid", str);
    // Get.offAll(() => {UserExithome()});
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const UserSignUpExithome()));
  }

  // String _currentAddress = "";
  // String _pinCode = "";
  // Position? _currentPosition;

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     // print(place.country);
  //     setState(() {
  //       _pinCode = '${place.postalCode}';
  //       _currentAddress =
  //           '${place.administrativeArea}, ${place.locality}, ${place.thoroughfare}, ${place.postalCode}';
  //     });
  //     // print(_currentAddress);
  //     users.location = _currentAddress;
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  bool isLoading = false;
  bool passwordVisible = true;
  String repswd = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((token) {
      users.deviceid = token!;
      print('Device token 1 : $token');
      print('Device token 2 : ${users.deviceid}');
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Center(
                      child: Text(
                        tSignUp,
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
                      TextFormField(
                        initialValue: "",
                        // //controller: nameController,
                        onChanged: (val) {
                          users.name = val;
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
                      TextField(
                        // //controller: emailController,
                        onChanged: (val) {
                          users.phone = val;
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
                      //          Container(
                      //   height: 80,
                      //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(22),
                      //   ),
                      //   child: TextFormField(
                      //     // //controller: locationController,
                      //     // initialValue: widget.location,
                      //     onChanged: (val) {
                      //       users.location = val;
                      //     },
                      //     decoration: const InputDecoration(
                      //       labelText: 'Location',
                      //       labelStyle: TextStyle(
                      //         fontSize: 14,
                      //         fontFamily: 'Montserrat',
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.grey,
                      //       ),
                      //       // hintText: 'myshop..',
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   // //controller: emailController,
                      //   // initialValue: users.location,
                      //   onChanged: (val) {
                      //     users.location = val;
                      //   },
                      //   decoration: const InputDecoration(
                      //       labelText: 'Address',
                      //       labelStyle: TextStyle(
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //       // hintText: 'EMAIL',
                      //       // hintStyle: ,
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.green))),
                      // ),
                      // TextFormField(
                      //   // //controller: emailController,
                      //   // initialValue: users.location,
                      //   onChanged: (val) {
                      //     users.pincode = val;
                      //   },
                      //   keyboardType: TextInputType.number,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Pincode',
                      //       labelStyle: TextStyle(
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //       // hintText: 'EMAIL',
                      //       // hintStyle: ,
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.green))),
                      // ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // //controller: pswdController,
                        onChanged: (val) {
                          users.pswd = val;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          String pattern =
                              r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          if (value != users.pswd ||
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
                          if (value != users.pswd) {
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
                      addVerticalSpace(10),
                      const TextField(
                        decoration: InputDecoration(
                            labelText: 'Coupen Code ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(top:24.0),
                      //   child: Text("Sign Up Failed. Try Again!",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
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
                                if (users.email.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(users.email)) {
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
                                } else if (users.name.isEmpty ||
                                        users.pswd.isEmpty ||
                                        users.phone.isEmpty
                                    // users.location.isEmpty ||
                                    // users.pincode.isEmpty
                                    ) {
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
                                } else if (users.pswd != repswd) {
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
                                    .hasMatch(users.pswd)) {
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
                                  signup_save(context);
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
                    tLoginQuestion,
                  ),
                  TextButton(
                    child: Text(tLogin,
                        style: TextStyle(
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Get.to(() => const UserLoginPage()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/owner/service/edit/edit_service.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/home/user_home.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var location;

Future updateuser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString("userid") ?? "null";
  // String deviceid = "";
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) {
  //   deviceid = token!;
  // });

  var response = await http.post(
      Uri.parse(
        "${apidomain}auth/user/update/$userid",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'location': location ?? "",
        // 'pincode': userpincode ?? "",
        // 'longitude': userlongitude ?? "",
        // 'latitude': userlatitude ?? "",
        // 'deviceid': deviceid
      });

  // Get.to(() => const UserHomePage());

  if (response.statusCode == 201) {
    var jsonData = jsonDecode(response.body);
    // print(jsonData);
    // print(jsonData["success"]);
    if (jsonData["status"]) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const UserHomePage()),
          (Route<dynamic> route) => false);
    }
  }
}

class UserAskLocationPage extends StatelessWidget {
  const UserAskLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DropdownDemo();
  }
}

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'Select Location';
  var userid;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString("userid");
    final response =
        await http.get(Uri.parse('${apidomain}auth/user/location/$userid'));
    var jsonData = jsonDecode(response.body);
    print({"fdgdf", jsonData, response});

    print(jsonData[0]["location"]);
    setState(() {
      location = jsonData[0]["location"];
    });
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appbgclr,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UserAppBarWithBack(
          title: "Select Your Location",
        ),
      ),
      body: Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            addVerticalSpace(10),
            Text(
              'Change Location',
              style: GoogleFonts.montserrat(
                color: ColorConstants.textclrw,
                fontSize: 20,
                // height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            addVerticalSpace(10),
            // Step 2.
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 3,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 0.1,
                ),
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: DropdownButton<String>(
                dropdownColor: ColorConstants.appbgclr2,
                // Step 3.
                value: dropdownValue,
                // Step 4.
                items: <String>[
                  'Select Location',
                  'Adoor',
                  'Pathanamthitta',
                  'Tholuzham',
                  'Thumbamon',
                  'Pandalam',
                  'Kurambala',
                  'kaipattoor',
                  'Omalloor'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontSize: 18, color: ColorConstants.textclrw),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    location = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: ColorConstants.iconclr,
                ),
                addHorizontalSpace(10),
                Container(
                  width: 250,
                  child: Text(
                    '$location',
                    // maxLines: 2,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: ColorConstants.textclrw,
                    ),
                  ),
                )
              ],
            ),
            addVerticalSpace(10),
            ElevatedButton(
              onPressed: () {
                updateuser(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

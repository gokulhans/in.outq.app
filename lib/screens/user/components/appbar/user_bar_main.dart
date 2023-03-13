import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/home/user_home.dart';
import 'package:outq/screens/user/location/asklocation.dart';
import 'package:outq/screens/user/notifications/user_notifications.dart';
import 'package:outq/screens/user/profile/myprofile.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserAppBar extends StatefulWidget {
  final String title;
  const UserAppBar({super.key, required this.title});

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  var userid;
  String location = "Select Location...";
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString("userid");
    final response =
        await http.get(Uri.parse('${apidomain}auth/user/location/$userid'));
    var jsonData = jsonDecode(response.body);
    print({"fdgdf", jsonData, response});
    print(location);
    setState(() {
      location = jsonData[0]["location"];
    });
    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      // print(jsonData);
      // print(jsonData["success"]);
      if (jsonData["status"] == "201") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const UserHomePage()),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void initState() {
    onload();
    super.initState();
    // print(_future);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: ColorConstants.appbgclr2,
        statusBarIconBrightness: Brightness.light,
        // statusBarBrightness: Brightness.light
      ),
      // leading: IconButton(
      //     icon: const Icon(
      //       Icons.location_on,
      //       color: Colors.blue,
      //       size: 30,
      //     ),
      //     onPressed: () {}),
      title: Row(
        children: const [
          Image(
            image: AssetImage("assets/app_icon/logohead.png"),
            height: 50,
            width: 100,
            // alignment: Alignment.centerLeft,
            fit: BoxFit.contain,
          ),
          // InkWell(
          //   onTap: () {
          //     Get.to(() => const UserAskLocationPage());
          //   },
          //   child: Container(
          //     child: Row(
          //       children: [
          //         const Icon(Icons.location_on),
          //         addHorizontalSpace(10),
          //         Container(
          //           width: 150,
          //           child: Text(
          //             location,
          //             // maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: GoogleFonts.montserrat(
          //               fontSize: 12,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // IconButton(
          //     icon: const Icon(
          //       Icons.queue,
          //       color: Colors.blue,
          //       size: 30,
          //     ),
          //     onPressed: () {}),
          // Text(
          //   'OutQ',
          //   style: GoogleFonts.montserrat(
          //     color: const Color(0xFF09041B),
          //     fontSize: 16,
          //     // height: 1.5,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // const Icon(
          //   Icons.arrow_drop_down_outlined,
          //   size: 24,
          // )
        ],
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: ColorConstants.appbgclr2,
      foregroundColor: Colors.white,
      // centerTitle: true,
      actions: [
        IconButton(
            icon: const Badge(
              badgeContent: Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
            onPressed: () {
              Get.to(() => const UserNotifications());
            }),
        IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            onPressed: () {
              Get.to(() => const UserMyProfilePage());
            }),
        addHorizontalSpace(10)
      ],

      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           IconButton(
      //               icon: const Icon(
      //                 Icons.location_on,
      //                 color: Colors.blue,
      //                 size: 30,
      //               ),
      //               onPressed: () {}),
      //           Text(
      //             'Calicut, Kerala',
      //             style: GoogleFonts.montserrat(
      //               color: const Color(0xFF09041B),
      //               fontSize: 16,
      //               // height: 1.5,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           IconButton(
      //               icon: const Icon(
      //                 Icons.notifications_active,
      //                 size: 30,
      //               ),
      //               onPressed: () {}),
      //           IconButton(
      //               icon: const Icon(
      //                 Icons.account_circle_outlined,
      //                 size: 30,
      //               ),
      //               onPressed: () {}),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

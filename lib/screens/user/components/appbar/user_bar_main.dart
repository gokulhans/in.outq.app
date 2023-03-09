import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/notifications/user_notifications.dart';
import 'package:outq/screens/user/profile/myprofile.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:badges/badges.dart';

class UserAppBar extends StatelessWidget {
  final String title;
  const UserAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
      // leading: IconButton(
      //     icon: const Icon(
      //       Icons.location_on,
      //       color: Colors.blue,
      //       size: 30,
      //     ),
      //     onPressed: () {}),
      title: Row(
        children: [
          Text(
            'OutQ',
            style: GoogleFonts.poppins(
              color: const Color(0xFF09041B),
              fontSize: 18,
              // height: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          // IconButton(
          //     icon: const Icon(
          //       Icons.queue,
          //       color: Colors.blue,
          //       size: 30,
          //     ),
          //     onPressed: () {}),
          // Text(
          //   'OutQ',
          //   style: GoogleFonts.poppins(
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
      backgroundColor: ColorConstants.white,
      foregroundColor: Colors.black,
      // centerTitle: true,
      actions: [
        IconButton(
            icon: const Badge(
              badgeContent: Text('1',style: TextStyle(color: Colors.white,fontSize: 10),),
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
      //             style: GoogleFonts.poppins(
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

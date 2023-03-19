import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:outq/screens/owner/notifications/owner_notifications.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerAppBar extends StatelessWidget {
  final String title;
  const OwnerAppBar({super.key, required this.title});

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
      title: const Center(
        child: Image(
          image: AssetImage("assets/app_icon/logohead.png"),
          height: 40,
          width: 100,
          // alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
        ),
      ),
      elevation: 0,
      backgroundColor: ColorConstants.appbgclr2,
      foregroundColor: ColorConstants.iconclr,
      centerTitle: true,
      actions: [
        IconButton(
            icon: Badge(
              badgeContent: Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: Icon(
                Icons.notifications,
                size: 30,
                color: ColorConstants.iconclr,
              ),
            ),
            onPressed: () {
              Get.to(() => const OwnerNotifications());
            }),
        addHorizontalSpace(10)
      ],
    );
  }
}

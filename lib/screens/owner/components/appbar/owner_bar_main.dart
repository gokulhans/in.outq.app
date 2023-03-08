import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:outq/screens/owner/notifications/owner_notifications.dart';
import 'package:outq/utils/color_constants.dart';

class OwnerAppBar extends StatelessWidget {
  final String title;
  const OwnerAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
      title: Text(title),
      elevation: 0,
      backgroundColor: ColorConstants.white,
      foregroundColor: Colors.black,
      centerTitle: true,
      actions: [
        IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () {
              Get.to(() => const OwnerNotifications());
            })
      ],
    );
  }
}

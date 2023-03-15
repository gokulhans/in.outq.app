import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outq/utils/color_constants.dart';

class UserAppBarWithBack extends StatelessWidget {
  final String title;
  const UserAppBarWithBack({super.key, required this.title});

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
      title: Text(title),
      elevation: 0,
      backgroundColor: ColorConstants.appbgclr2,
      foregroundColor: ColorConstants.textclr,
      // centerTitle: true,
      leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }
}

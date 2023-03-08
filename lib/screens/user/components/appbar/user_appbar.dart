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

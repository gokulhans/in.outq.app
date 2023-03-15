import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outq/screens/shared/drawer_pages/feedback_screen.dart';
import 'package:outq/screens/shared/drawer_pages/help_screen.dart';
import 'package:outq/screens/shared/drawer_pages/invite_friend_screen.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/image_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerDrawer extends StatelessWidget {
  const OwnerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: ColorConstants.appbgclr2,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(tWelcomeTopImage),
                  )),
                ),
              ),
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.house,
                color: ColorConstants.textclr,
                size: 18,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: ColorConstants.textclr),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent_rounded,
                  color: ColorConstants.textclr),
              title: Text(
                'Help',
                style: TextStyle(color: ColorConstants.textclr),
              ),
              onTap: () => {Get.to(() => const HelpScreen())},
            ),
            ListTile(
              leading: Icon(Icons.help, color: ColorConstants.textclr),
              title: Text(
                'Feedback',
                style: TextStyle(color: ColorConstants.textclr),
              ),
              onTap: () => {Get.to(() => const FeedbackScreen())},
            ),
            ListTile(
              leading: Icon(Icons.people, color: ColorConstants.textclr),
              title: Text(
                'Invite Friend',
                style: TextStyle(color: ColorConstants.textclr),
              ),
              onTap: () => {Get.to(() => const InviteFriend())},
            ),
            // ListTile(
            //   leading: const Icon(Icons.info),
            //   title: const Text('Logout'),
            //   onTap: () async {
            //     SharedPreferences pref =
            //         await SharedPreferences.getInstance();
            //     pref.remove("userid");
            //     Get.offAll(() => const Exithome());
            //   },
            // ),

            ListTile(
              leading:  FaIcon(
                FontAwesomeIcons.rightFromBracket,
                size: 20,
                color:ColorConstants.textclr,
              ),
              title: Text('Logout',style:TextStyle(color:ColorConstants.textclr)),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("ownerid");
                pref.remove("storeid");
                Get.offAll(() => const Exithome());
              },
            ),
          ],
        ),
      ),
    );
  }
}

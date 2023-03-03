import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/screens/shared/drawer_pages/feedback_screen.dart';
import 'package:outq/screens/shared/drawer_pages/help_screen.dart';
import 'package:outq/screens/shared/drawer_pages/invite_friend_screen.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/utils/image_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
              leading: const Icon(Icons.input),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent_rounded),
              title: const Text('Help'),
              onTap: () => {Get.to(() => const HelpScreen())},
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Feedback'),
              onTap: () => {Get.to(() => const FeedbackScreen())},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Invite Friend'),
              onTap: () => {Get.to(() => const InviteFriend())},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Logout'),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("userid");
                Get.offAll(() => const Exithome());
              },
            ),
            // const ListTile(
            //   leading: Icon(Icons.share),
            //   title: Text('Rate the app'),
            //   onTap: () => {Get.to(()=> InviteFriend())},
            // ),
            // const ListTile(
            //   leading: Icon(Icons.info
            //   ),
            //   title: Text('About Us'),
            //   onTap: () => {Get.to(()=> InviteFriend())},
            // ),
          ],
        ),
      ),
    );
  }
}

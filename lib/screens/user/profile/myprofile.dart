import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outq/screens/shared/drawer_pages/feedback_screen.dart';
import 'package:outq/screens/shared/drawer_pages/help_screen.dart';
import 'package:outq/screens/shared/drawer_pages/invite_friend_screen.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/rating/ratingmode.dart';
import 'package:outq/screens/user/rating/user_add_review_and_rating.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMyProfilePage extends StatefulWidget {
  const UserMyProfilePage({super.key});

  @override
  State<UserMyProfilePage> createState() => _UserMyProfilePageState();
}

class _UserMyProfilePageState extends State<UserMyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: UserAppBarWithBack(
          title: "Profile",
        ),
      ),
      body: Container(
        color: ColorConstants.appbgclr,
        child: Column(
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       width: 120,
            //       height: 120,
            //       decoration: const BoxDecoration(
            //         shape: BoxShape.circle,
            //         image: DecorationImage(
            //           image: AssetImage('assets/images/userImage.png'),
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //       child: Hero(
            //         tag: 'userProfile',
            //         child: Material(
            //           color: Colors.transparent,
            //           child: InkWell(
            //             onTap: () {},
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 20),
            //     const Text(
            //       'John Doe',
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     const SizedBox(height: 10),
            //     const Text(
            //       'johndoe@example.com',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // addVerticalSpace(20),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.house,
                      color: ColorConstants.textclr,
                      size: 18,
                    ),
                    title: Text('Home',style: TextStyle(color: ColorConstants.textclr),),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading:  Icon(Icons.support_agent_rounded,color: ColorConstants.textclr),
                    title: Text('Help',style: TextStyle(color: ColorConstants.textclr),),
                    onTap: () => {Get.to(() => const HelpScreen())},
                  ),
                  ListTile(
                    leading: Icon(Icons.help,color: ColorConstants.textclr),
                    title: Text('Feedback',style: TextStyle(color: ColorConstants.textclr),),
                    onTap: () => {Get.to(() => const FeedbackScreen())},
                  ),
                  ListTile(
                    leading: Icon(Icons.people,color: ColorConstants.textclr),
                    title: Text('Invite Friend',style: TextStyle(color: ColorConstants.textclr),),
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
                    leading: FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      size: 20,
                      color: ColorConstants.textclr
                    ),
                    title: Text('Logout',style: TextStyle(color: ColorConstants.textclr),),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove("userid");
                      Get.offAll(() => const Exithome());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

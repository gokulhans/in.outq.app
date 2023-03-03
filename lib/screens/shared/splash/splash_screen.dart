import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? ownerid = prefs.getString("ownerid");
      String? userid = prefs.getString("userid");
      // print(ownerid);
      // print(userid);
      if (ownerid != null) {
        Get.off(() => const OwnerExithome());
      } else if (userid != null) {
        Get.off(() => const UserExithome());
      } else {
        Get.off(() => const Exithome());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(0),
      //   child: AppBar(
      //     elevation: 0,
      //     // systemOverlayStyle: SystemUiOverlayStyle(
      //     //     systemNavigationBarColor: hexToColor("#0F3EE9"), // navigation bar color
      //     //     systemNavigationBarIconBrightness: Brightness.dark,
      //     //     // statusBarColor: Colors.black,
      //     //     statusBarIconBrightness: Brightness.light,
      //     //     statusBarBrightness: Brightness.dark),
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [hexToColor("#0F3EE9"), hexToColor("#000000")],
            transform: const GradientRotation(9 * pi / 180),
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(image: AssetImage("assets/app_icon/playstore.png"))
          ],
        )),
      ),
    );
  }
}

// class AppHome extends StatefulWidget {
//   const AppHome({super.key, required this.ownerid, required this.userid});

//   final String? ownerid;
//   final String? userid;

//   @override
//   State<AppHome> createState() => _AppHomeState();
// }

// class _AppHomeState extends State<AppHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: (widget.ownerid != null)
//           ? OwnerHomePage(currentIndex: 0)
//           : (widget.userid != null)
//               ? const UserHomePage()
//               : const ExitHome(),
//     );
//   }
// }

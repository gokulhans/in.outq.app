import 'package:flutter/material.dart';
import 'package:outq/screens/owner/home/owner_home.dart';
import 'package:outq/screens/shared/welcome_screen/welcome_screen.dart';
import 'package:outq/screens/user/home/user_home.dart';
import 'package:outq/screens/user/location/osm/osm_location_fetch.dart';
import 'package:outq/screens/user/store/view_store/user_view_single_store.dart';

class Exithome extends StatelessWidget {
  const Exithome({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                'Do you want to close OutQ ?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: const Scaffold(
          body: WelcomeScreen(),
        ));
  }
}

class UserExithome extends StatelessWidget {
  const UserExithome({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                'Do you want to close OutQ ?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: const Scaffold(
          body: UserHomePage(),
        ));
  }
}

class UserSignUpExithome extends StatelessWidget {
  const UserSignUpExithome({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                'Do you want to close OutQ ?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: const Scaffold(
          body: GetLocationPage(),
        ));
  }
}

class OwnerExithome extends StatelessWidget {
  const OwnerExithome({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                'Do you want to close OutQ ?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          body: OwnerHomePage(currentIndex: 0),
        ));
  }
}

// class LinkUserExithome extends StatelessWidget {
//   String title;
//    LinkUserExithome({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     Future<bool> showExitPopup() async {
//       return await showDialog(
//             //show confirm dialogue
//             //the return value will be from "Yes" or "No" options
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Exit App'),
//               content: const Text(
//                 'Do you want to close OutQ ?',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text('No'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   //return true when click on "Yes"
//                   child: const Text('Yes'),
//                 ),
//               ],
//             ),
//           ) ??
//           false; //if showDialouge had returned null, then return false
//     }

//     return WillPopScope(
//         onWillPop: showExitPopup,
//         child: const Scaffold(
//           body: UserViewSingleStorePage(
//             title: title,
//           ),
//         ));
//   }
// }

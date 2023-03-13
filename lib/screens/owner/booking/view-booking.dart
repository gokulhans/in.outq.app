import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/owner/home/owner_home.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;

Future cancelBooking() async {
  dynamic argumentData = Get.arguments;
  // print(argumentData[6]);
  var response =
      await http.get(Uri.parse('${apidomain}order/done/${argumentData[6]}'));
  Get.snackbar(
    "Booking Completed",
    "Booking Done Succesfully",
    icon: const Icon(Icons.person, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    borderRadius: 12,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.bounceIn,
  );
  Get.to(() => OwnerHomePage(
        currentIndex: 0,
      ));
  return true;
}

class OwnerAppoinmentInfoPage extends StatefulWidget {
  const OwnerAppoinmentInfoPage({super.key});

  @override
  State<OwnerAppoinmentInfoPage> createState() =>
      _OwnerAppoinmentInfoPageState();
}

class _OwnerAppoinmentInfoPageState extends State<OwnerAppoinmentInfoPage> {
  dynamic argumentData = Get.arguments;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: UserAppBarWithBack(
            title: "Appoinment Info",
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1562322140-8baeececf3df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"),
                      ),
                    ),
                  ),
                  addVerticalSpace(20),
                  Text(
                    argumentData[3],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    argumentData[4],
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  addVerticalSpace(30),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[0],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[5],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[3],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Store",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[4],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 300,
                        color: Colors.green,
                        child: TextButton(
                          onPressed: () {
                            cancelBooking();
                          },
                          child: Text(
                            'Done',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: Container(
                    //     width: 300,
                    //     color: Colors.blue,
                    //     child: TextButton(
                    //       onPressed: () {
                    //         // Add your onPressed action here
                    //       },
                    //       child: Text(
                    //         'Get Direction',
                    //         style: GoogleFonts.montserrat(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // addVerticalSpace(10),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: Container(
                    //     width: 300,
                    //     color: Colors.red,
                    //     child: TextButton(
                    //       onPressed: () {
                    //         // Add your onPressed action here
                    //       },
                    //       child: Text(
                    //         'Cancel Appoinment',
                    //         style: GoogleFonts.montserrat(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

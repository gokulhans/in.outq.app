import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/Backend/api/user_api.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';

class UserViewSingleStorePage extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  UserViewSingleStorePage({super.key});

  @override
  State<UserViewSingleStorePage> createState() =>
      _UserViewSingleStorePageState();
}

class _UserViewSingleStorePageState extends State<UserViewSingleStorePage> {
  dynamic argumentData = Get.arguments;
  bool isChecked = false;
  bool isFollowed = false;

  final followers = 5;
  // bool cmbscritta = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: UserAppBarWithBack(
            title: "",
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: getSingleStore(argumentData[0]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                    // return const Center(
                    //     child: SpinKitCircle(
                    //   color: Colors.blue,
                    //   size: 50.0,
                    // ));
                  } else {
                    if (snapshot.data.length == 0) {
                      return const Center(
                          child: Text(
                        'No Content is available right now.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ));
                    } else {
                      return Expanded(
                        flex: 3,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot.data[i].img),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(20),
                                Text(
                                  snapshot.data[i].name,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  snapshot.data[i].location,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                // Column(
                                //   children: [
                                //     Text("snapshot.data[i].followerscount"),
                                //     addVerticalSpace(10),
                                //     ClipRRect(
                                //       borderRadius: BorderRadius.circular(12),
                                //       child: Container(
                                //           width: 100,
                                //           height: 40,
                                //           color: isFollowed
                                //               ? Colors.blue
                                //               : Colors.grey,
                                //           child: TextButton(
                                //               onPressed: () {
                                //                 setState(() {
                                //                   isFollowed = !isFollowed;
                                //                 });
                                //               },
                                //               child: isFollowed
                                //                   ? const Text(
                                //                       "Follow",
                                //                       style: TextStyle(
                                //                           color: Colors.white),
                                //                     )
                                //                   : const Text(
                                //                       "Unfollow",
                                //                       style: TextStyle(
                                //                           color: Colors.white),
                                //                     ))),
                                //     ),
                                //   ],
                                // )
                                // addVerticalSpace(30),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
              FutureBuilder(
                future: getSingleStoreServices(argumentData[0]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                        child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ));
                  } else {
                    if (snapshot.data.length == 0) {
                      return const Center(
                          child: Text(
                        'No Content is available right now.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ));
                    } else {
                      return Expanded(
                        flex: 3,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: tDefaultSize),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => const ShopBookingPage(),
                                    arguments: [
                                      snapshot.data[i].id,
                                      snapshot.data[i].storeid,
                                      argumentData[0],
                                      snapshot.data[i].name,
                                      snapshot.data[i].price,
                                      argumentData[1],
                                      argumentData[2],
                                      argumentData[3],
                                    ]);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                snapshot.data[i].img),
                                            width: 60,
                                            height: 50,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[i].name,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            // Text(
                                            //   snapshot.data[i].price,
                                            //   textAlign: TextAlign.left,
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .subtitle2,
                                            // ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data[i].ogprice +
                                                      " ₹",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                addHorizontalSpace(10),
                                                Text(
                                                    snapshot.data[i].price +
                                                        " ₹",
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          width: 100,
                                          height: 25,
                                          color: Colors.blue[700],
                                          child: Center(
                                              child: Text(
                                            "Book",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 10,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ));
  }
}

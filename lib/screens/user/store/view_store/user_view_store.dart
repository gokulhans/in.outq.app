import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/Backend/api/user_api.dart';
import 'package:outq/components/Services/service_card_long.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/rating/allreviews.dart';
import 'package:outq/screens/user/rating/ratingmode.dart';
import 'package:outq/screens/user/search/user_search.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchInBrowser(url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

class UserViewStorePage extends StatefulWidget {
  const UserViewStorePage({super.key});

  @override
  State<UserViewStorePage> createState() => _UserViewStorePageState();
}

class _UserViewStorePageState extends State<UserViewStorePage> {
  dynamic argumentData = Get.arguments;
  bool isChecked = false;
  bool isFollowed = false;
  // bool cmbscritta = false;
  var userid;
  var followcount;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString("userid");
    var response = await http
        .get(Uri.parse('${apidomain}follow/check/${argumentData[0]}/$userid'));
    var jsonData = await jsonDecode(response.body);
    print(jsonData["followed"]);
    setState(() {
      isFollowed = jsonData["followed"];
    });
  }

  @override
  void initState() {
    onload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: UserAppBarWithBack(
            title: argumentData[1],
          ),
        ),
        body: Container(
          color: ColorConstants.appbgclr,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<http.Response>(
                  future: http.get(Uri.parse(
                      '${apidomain}store/store/get/${argumentData[0]}')),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    if (snapshot.hasData) {
                      var data = jsonDecode(snapshot.data!.body);
                      print(data);
                      // return Expanded(
                      //   child: ListView.builder(
                      //     itemCount: data.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return ListTile(
                      //         title: Text(data[index]['name']),
                      //       );
                      //     },
                      //   ),
                      // );
                      // return Text(data["t"].toString());
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 210,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data["img"]),
                                  ),
                                ),
                              ),
                              addVerticalSpace(10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Text(
                                  //   data[i]["name"],
                                  //   style: GoogleFonts.montserrat(
                                  //     color: Colors.black87,
                                  //     fontSize: 24,
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   data[i]["location"],
                                  //   style:
                                  //       Theme.of(context).textTheme.subtitle2,
                                  // ),
                                  // Column(
                                  //   children: [
                                  //     // isFollowed
                                  //     //     ?
                                  //     // Text(followcount),
                                  //     // :
                                  //     Text(
                                  //         "${data[i]["followerslist"].length} Followers"),
                                  //     addVerticalSpace(10),
                                  //     ClipRRect(
                                  //       borderRadius: BorderRadius.circular(12),
                                  //       child: Container(
                                  //         width: 100,
                                  //         height: 40,
                                  //         color: isFollowed
                                  //             ? Colors.grey
                                  //             : Colors.blue,
                                  //         child: TextButton(
                                  //           onPressed: () async {
                                  //             setState(() {
                                  //               isFollowed = !isFollowed;
                                  //             });
                                  //             await http.get(Uri.parse(
                                  //                 '${apidomain}follow/follow/${data[i]["_id"]}/$userid'));
                                  //           },
                                  //           child: isFollowed
                                  //               ? const Text(
                                  //                   "Unfollow",
                                  //                   style: TextStyle(
                                  //                       color: Colors.white),
                                  //                 )
                                  //               : const Text(
                                  //                   "Follow",
                                  //                   style: TextStyle(
                                  //                       color: Colors.white),
                                  //                 ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  addVerticalSpace(20),
                                  Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 3),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    // decoration: BoxDecoration(
                                    //   color: Colors.white,
                                    //   boxShadow: [
                                    //     BoxShadow(
                                    //       color: Colors.grey.withOpacity(0.5),
                                    //       spreadRadius: 1,
                                    //       blurRadius: 3,
                                    //       offset: const Offset(0,
                                    //           3), // changes position of shadow
                                    //     ),
                                    //   ],
                                    //   borderRadius: BorderRadius.circular(10),
                                    //   // border: Border.all(
                                    //   //   color: Colors.black,
                                    //   //   width: 0.1,
                                    //   // ),
                                    // ),
                                    child: Row(
                                      children: [
                                        // Expanded(
                                        //   flex: 2,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //       vertical: 12.0,
                                        //     ),
                                        //     child: SizedBox(
                                        //       height: 60,
                                        //       child: ClipRRect(
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   12.0),
                                        //           child: Image(
                                        //               image: NetworkImage(
                                        //                   data[i]["img"]))),
                                        //     ),
                                        //   ),
                                        // ),
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
                                                    data["name"],
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: ColorConstants
                                                          .textclr,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  addVerticalSpace(10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          RatingBarIndicator(
                                                            unratedColor:
                                                                Colors.white,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemCount: 5,
                                                            rating: double
                                                                .parse(data[
                                                                    "reviews"]),
                                                            itemSize: 15,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                          ),
                                                          Text(
                                                            " (${data["reviews"]})",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          )
                                                        ],
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                () =>
                                                                    const AllShopReviews(),
                                                                arguments:
                                                                    data);
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            padding: EdgeInsets
                                                                .zero, // Removes padding
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "View All Reviews",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Colors
                                                                        .amber),
                                                              ),
                                                              Text(
                                                                " (${data["reviewcount"]})",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Colors
                                                                        .amber),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  Text(
                                                    data["location"],
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: ColorConstants
                                                          .textclr,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data["followerslist"].length} Followers",
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: ColorConstants
                                                          .textclr,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  // Text('₹7',
                                                  //     textAlign: TextAlign.left,
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .headline5),
                                                ]),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow[900],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                width: 100,
                                                height: 30,
                                                child: TextButton(
                                                  child: Text(
                                                    'Rate Store',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color:
                                                                ColorConstants
                                                                    .textclrw,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  onPressed: () {
                                                    Get.to(
                                                        () =>
                                                            const ShopRatingPage(),
                                                        arguments: data);
                                                  },
                                                ),
                                              ),
                                              addVerticalSpace(10),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Container(
                                                  width: 100,
                                                  height: 30,
                                                  color: isFollowed
                                                      ? Colors.grey
                                                      : Colors.blue,
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        isFollowed =
                                                            !isFollowed;
                                                      });
                                                      await http.get(Uri.parse(
                                                          '${apidomain}follow/follow/${data["_id"]}/$userid'));
                                                    },
                                                    child: isFollowed
                                                        ? const Text(
                                                            "Unfollow",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        : const Text(
                                                            "Follow",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              addVerticalSpace(10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[900],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                width: 100,
                                                height: 30,
                                                child: TextButton(
                                                  child: Text(
                                                    'Get Direction',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color:
                                                                ColorConstants
                                                                    .textclrw,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  onPressed: () {
                                                    String url =
                                                        'https://www.google.com/maps/dir/?api=1&destination=${data["latitude"]},${data["longitude"]}';
                                                    Uri uri = Uri.parse(url);
                                                    _launchInBrowser(uri);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasData) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const PlaceholderBig();
                    }
                  },
                ),
                FutureBuilder(
                  future: getSingleStoreServices(argumentData[0]),
                  builder: (context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == null) {
                      return const PlaceholderLong();
                    } else {
                      if (snapshot.data.length == 0) {
                        return const Expanded(
                          flex: 3,
                          child: Center(
                              child: Text(
                            'No Content is available right now.',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: tDefaultSize),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ServiceCardLong(
                                data: snapshot.data[i], argdata: argumentData);
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

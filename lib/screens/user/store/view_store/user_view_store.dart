import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/Backend/api/user_api.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/search/user_search.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
          color: Colors.white,
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
                    return Expanded(
                      flex: 3,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
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
                                    image: NetworkImage(data[i]["img"]),
                                  ),
                                ),
                              ),
                              addVerticalSpace(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data[i]["name"],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    data[i]["location"],
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Column(
                                    children: [
                                      // isFollowed
                                      //     ?
                                      // Text(followcount),
                                      // :
                                      Text(
                                          "${data[i]["followerslist"].length} Followers"),
                                      addVerticalSpace(10),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          color: isFollowed
                                              ? Colors.grey
                                              : Colors.blue,
                                          child: TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                isFollowed = !isFollowed;
                                              });
                                              await http.get(Uri.parse(
                                                  '${apidomain}follow/follow/${data[i]["_id"]}/$userid'));
                                            },
                                            child: isFollowed
                                                ? const Text(
                                                    "Unfollow",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : const Text(
                                                    "Follow",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  addVerticalSpace(20),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(child: CircularProgressIndicator()));
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
                      return Expanded(
                        flex: 3,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: tDefaultSize),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                snapshot.data[i].img),
                                            width: 100,
                                            height: 80,
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
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.timelapse,
                                                  size: 14,
                                                ),
                                                addHorizontalSpace(3),
                                                Text(
                                                  "${snapshot.data[i].duration} minutes",
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ),
                                              ],
                                            ),
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
                                            Text(
                                              "${snapshot.data[i].description}",
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
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
                                              child: TextButton(
                                            onPressed: () {
                                              Get.to(
                                                  () => const ShopBookingPage(),
                                                  arguments: [
                                                    snapshot.data[i].id,
                                                    snapshot.data[i].storeid,
                                                    argumentData[0],
                                                    snapshot.data[i].name,
                                                    snapshot.data[i].price,
                                                    argumentData[1],
                                                    argumentData[2],
                                                    argumentData[3],
                                                    snapshot.data[i].img,
                                                    snapshot.data[i].duration,
                                                  ]);
                                            },
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

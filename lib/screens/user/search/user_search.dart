import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:http/http.dart' as http;
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? userid;
Future getUserId(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getString("userid")!;
  // print(userid);
}

class UserSearchServicesPage extends StatefulWidget {
  var title;

  UserSearchServicesPage({super.key, required this.title});

  @override
  State<UserSearchServicesPage> createState() => _UserSearchServicesPageState();
}

class _UserSearchServicesPageState extends State<UserSearchServicesPage> {
  dynamic argumentData = Get.arguments;
  // @override
  // void initState() async {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getUserId(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: UserAppBarWithBack(
          title: widget.title,
        ),
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: http.get(Uri.parse(
                  '${apidomain}service/search/${argumentData[0]}/$userid')),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data!.body);
                  if (data.length == 0) {
                    return const Text('No services Found ');
                  }
                  return Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: tDefaultSize),
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {
                            // Get.to(() => UserViewSingleStorePage(),
                            //     arguments: [
                            //       data[i]['storeid'],
                            //     ]);
                            Get.to(() => const ShopBookingPage(), arguments: [
                              data[i]['ownerid'],
                              data[i]['type'],
                              data[i]['storeid'],
                              data[i]['name'],
                              data[i]['price'],
                              data[i]['storename'],
                              data[i]['start'],
                              data[i]['end'],
                              data[i]['img'],
                              data[i]['duration'],
                            ]);
                          },
                          child: Container(
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data[i]['img']),
                                        width: 60,
                                        height: 50,
                                      ),
                                      // child: const Image(
                                      //     image: AssetImage(
                                      //         'assets/images/userImage.png'))
                                    ),
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
                                            data[i]['name'],
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Text(
                                            data[i]['storename'],
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timelapse,
                                                size: 14,
                                              ),
                                              addHorizontalSpace(3),
                                              Text(
                                                "${data[i]['duration']} minutes",
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
                                                data[i]['ogprice'] + " ₹",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              addHorizontalSpace(10),
                                              Text(data[i]['price'] + " ₹",
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5),
                                            ],
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 100,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(17.5),
                                          topRight: Radius.circular(17.5),
                                          bottomLeft: Radius.circular(17.5),
                                          bottomRight: Radius.circular(17.5),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment(0.8459399938583374,
                                              0.1310659646987915),
                                          end: Alignment(-0.1310659646987915,
                                              0.11150387674570084),
                                          colors: [
                                            Color.fromRGBO(0, 81, 255, 1),
                                            Color.fromRGBO(0, 132, 255, 1)
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Book",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.montserrat(
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('No services Found');
                } else {
                  return Center(child: PlaceholderLong());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

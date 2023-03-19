import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:outq/screens/owner/service/edit/edit_service.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});
  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  var userid;
  Future<http.Response>? _future;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString("userid");
    setState(() {
      _future =
          http.get(Uri.parse('${apidomain}notification/create/u/$userid'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: UserAppBarWithBack(
          title: "Notifications",
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConstants.appbgclr,
        child: FutureBuilder<http.Response>(
          future: _future,
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data!.body);
              print(data);
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                      color: ColorConstants.appbgclr2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Icon(
                                Icons.notifications,
                                size: 30,
                                color: ColorConstants.iconclr,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              // onTap: (() => {
                              //       Get.to(() => const ShopBookingPage(),
                              //           arguments: [
                              //             data[i]['ownerid'],
                              //             data[i]['type'],
                              //             data[i]['storeid'],
                              //             data[i]['name'],
                              //             data[i]['price'],
                              //             data[i]['storename'],
                              //             data[i]['start'],
                              //             data[i]['end'],
                              //             data[i]['img'],
                              //             data[i]['duration']
                              //           ])
                              //     }),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[i]["message"],
                                      textAlign: TextAlign.left,
                                      style:
                                          Theme.of(context).textTheme.subtitle1!.copyWith(
                                            color: ColorConstants.textclrw,fontSize: 14,fontWeight: FontWeight.w500
                                          ),
                                    ),
                                    addVerticalSpace(10),
                                    Text(
                                      data[i]["title"],
                                      textAlign: TextAlign.left,
                                      style:
                                          Theme.of(context).textTheme.subtitle2!.copyWith(
                                            color: ColorConstants.textclr
                                          ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
      ),
    );
  }
}

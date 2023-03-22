import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/Services/service_card_long.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/color_constants.dart';
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

class GenderFilterPage extends StatefulWidget {
  const GenderFilterPage({super.key});

  @override
  State<GenderFilterPage> createState() => _GenderFilterPageState();
}

class _GenderFilterPageState extends State<GenderFilterPage> {
  dynamic argumentData = Get.arguments;
  // @override
  // void initState() async {
  //   super.initState();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: UserAppBarWithBack(
          title: argumentData[0],
        ),
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        color: ColorConstants.appbgclr,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: http.get(Uri.parse(
                  '${apidomain}store/type/${argumentData[0]}/$userid')),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data!.body);
                  print(data);

                  if (data.length == 0) {
                    return Column(
                      children: [
                        addVerticalSpace(30),
                        Center(
                          child: Text(
                            'No Stores Found',
                            style: TextStyle(color: ColorConstants.textclr),
                          ),
                        ),
                      ],
                    );
                  }

                  return Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: tDefaultSize),
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ServiceCardLong2(data: data[i]);
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('No services Found ');
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

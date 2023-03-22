import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;

class AllShopReviews extends StatefulWidget {
  const AllShopReviews({super.key});

  @override
  State<AllShopReviews> createState() => _AllShopReviewsState();
}

class _AllShopReviewsState extends State<AllShopReviews> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: UserAppBarWithBack(
          title: "All Reviews",
        ),
      ),
      backgroundColor: ColorConstants.appbgclr,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return FutureBuilder<http.Response>(
                  future: http.get(Uri.parse(
                      '${apidomain}review/get/${argumentData["type"]}')),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    if (snapshot.hasData) {
                      var data = jsonDecode(snapshot.data!.body);
                      print(data);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // addVerticalSpace(20),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text('All Reviews',
                          //       style: GoogleFonts.montserrat(
                          //           fontWeight: FontWeight.w700,
                          //           fontSize: 24,
                          //           color: ColorConstants.textclrw)),
                          // ),
                          addVerticalSpace(10),
                          Center(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.appbgclr2,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 1,
                                    //     blurRadius: 3,
                                    //     offset: Offset(0,
                                    //         3), // changes position of shadow
                                    //   ),
                                    // ],
                                    borderRadius: BorderRadius.circular(10),
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   width: 0,
                                    // ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data[i]['user']['name'],
                                            style: GoogleFonts.montserrat(
                                              color: ColorConstants.textclrw,
                                              fontSize: 15,
                                              // height: 1.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                unratedColor: Colors.white,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                rating: data[i]['rating'].toDouble(),
                                                itemSize: 15,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                              Text(
                                                " (${data[i]['rating'].toDouble()})",
                                                style: GoogleFonts.montserrat(
                                                    color:
                                                        ColorConstants.textclrw,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      addVerticalSpace(10),
                                      Text(
                                        data[i]['comment'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: ColorConstants.textclr),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(child: PlaceholderLong());
                    }
                  },
                );
              }),
            ]),
      ),
    );
  }
}

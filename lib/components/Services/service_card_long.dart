// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:outq/screens/user/booking/booking.dart';
// import 'package:outq/utils/widget_functions.dart';

// class ServiceCardLong extends StatelessWidget {
//   var data, argdata;
//   ServiceCardLong({super.key, required this.data, required this.argdata});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(3),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: Colors.black,
//           width: 0.1,
//         ),
//       ),
//       child: InkWell(
//         onTap: () {
//           Get.to(() => const ShopBookingPage(), arguments: [
//             data.id,
//             data.storeid,
//             argdata[0],
//             data.name,
//             data.price,
//             argdata[1],
//             argdata[2],
//             argdata[3],
//             data.img,
//             data.duration,
//           ]);
//         },
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12.0),
//                     child: Image(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(data.img),
//                       width: 100,
//                       height: 80,
//                     )),
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data.name,
//                         textAlign: TextAlign.left,
//                         style: Theme.of(context).textTheme.subtitle1,
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.timelapse,
//                             size: 14,
//                           ),
//                           addHorizontalSpace(3),
//                           Text(
//                             "${data.duration} minutes",
//                             textAlign: TextAlign.left,
//                             style: Theme.of(context).textTheme.subtitle2,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             data.ogprice + " ₹",
//                             textAlign: TextAlign.left,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.red,
//                                 decoration: TextDecoration.lineThrough),
//                           ),
//                           addHorizontalSpace(10),
//                           Text(data.price + " ₹",
//                               textAlign: TextAlign.left,
//                               style: Theme.of(context).textTheme.headline5),
//                         ],
//                       ),
//                       Text(
//                         "${data.description}",
//                         textAlign: TextAlign.left,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.subtitle2,
//                       ),
//                     ]),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 100,
//                     height: 25,
//                     color: Colors.blue[700],
//                     child: Center(
//                         child: Text(
//                       "Book",
//                       textAlign: TextAlign.left,
//                       style: GoogleFonts.montserrat(
//                         color: Colors.white,
//                         fontSize: 10,
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.w600,
//                         height: 1,
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/shared/welcome_screen/welcome_screen.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceCardLong extends StatelessWidget {
  var data, argdata;
  ServiceCardLong({super.key, required this.data, required this.argdata});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 48, 97),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 0.3,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => const ShopBookingPage(), arguments: [
            data.id,
            data.storeid,
            argdata[0],
            data.name,
            data.price,
            argdata[1],
            argdata[2],
            argdata[3],
            data.img,
            data.duration,
          ]);
        },
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(data.img),
                      width: 100,
                      height: 80,
                    )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 14,
                            color: Colors.white,
                          ),
                          addHorizontalSpace(3),
                          Text(
                            "${data.duration} minutes",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          Text(
                            data.ogprice + " ₹",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          addHorizontalSpace(10),
                          Text(
                            data.price + " ₹",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${calculatePercentageDifference(double.parse(data.price.replaceAll(",", "")), double.parse(data.ogprice.replaceAll(",", ""))).toStringAsFixed(2)} % OFF",
                        // data['location'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[100]),
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${data.description}",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
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
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Book",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 18, 48, 97),
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
      ),
    );
  }
}

class ServiceCardLong2 extends StatelessWidget {
  var data;
  ServiceCardLong2({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 48, 97),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 0.3,
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => const ShopBookingPage(), arguments: [
            data['ownerid'],
            data['type'],
            data['storeid'],
            data['name'],
            data['price'],
            data['storename'],
            data['start'],
            data['end'],
            data['img'],
            data['duration'],
          ]);
        },
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(data["img"]),
                      width: 100,
                      height: 80,
                    )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["name"],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 14,
                            color: Colors.white,
                          ),
                          addHorizontalSpace(3),
                          Text(
                            "${data["duration"]} minutes",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          Text(
                            data["ogprice"] + " ₹",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          addHorizontalSpace(10),
                          Text(
                            data["price"] + " ₹",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${calculatePercentageDifference(double.parse(data["price"].replaceAll(",", "")), double.parse(data["ogprice"].replaceAll(",", ""))).toStringAsFixed(2)} % OFF",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[100]),
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${data["description"]}",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
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
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Book",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 18, 48, 97),
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
      ),
    );
  }
}

class ServiceCardLong3 extends StatelessWidget {
  var data;
  ServiceCardLong3({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 18, 48, 97),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 0.3,
        ),
      ),
      child: InkWell(
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          var userid = pref.getString("userid");
          if (userid != null) {
            Get.to(() => const ShopBookingPage(), arguments: [
              data.ownerid,
              data.storeid,
              data.storeid,
              data.name,
              data.price,
              data.storename,
              data.start,
              data.end,
              data.img,
              data.duration,
            ]);
          } else {
            Get.snackbar(
              "Please Login",
              "Login to OutQ to Follow And Book Your Favourite Shop",
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
            Get.to(() => const WelcomeScreen());
          }
        },
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(data.img),
                      width: 100,
                      height: 80,
                    )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 14,
                            color: Colors.white,
                          ),
                          addHorizontalSpace(3),
                          Text(
                            "${data.duration} minutes",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          Text(
                            data.ogprice + " ₹",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          addHorizontalSpace(10),
                          Text(
                            data.price + " ₹",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${calculatePercentageDifference(double.parse(data.price.replaceAll(",", "")), double.parse(data.ogprice.replaceAll(",", ""))).toStringAsFixed(2)} % OFF",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[100]),
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${data.description}",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
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
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Book",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 18, 48, 97),
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
      ),
    );
  }
}

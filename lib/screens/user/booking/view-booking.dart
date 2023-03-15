import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/user_api.dart';
import 'package:outq/screens/user/booking/user_view_booking.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';

class UserViewBookingsPage extends StatefulWidget {
  const UserViewBookingsPage({super.key});
  @override
  State<UserViewBookingsPage> createState() => _UserViewBookingsPageState();
}

class _UserViewBookingsPageState extends State<UserViewBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorConstants.appbgclr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Appoinments',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.textclr,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getUserBookings(),
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
                  return Center(
                      child: Text(
                    'No Booking is available right now.',
                    style: GoogleFonts.montserrat(
                      color: ColorConstants.textclr,
                      // fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ));
                } else {
                  return Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: tDefaultSize),
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () => Get.to(
                              () => const UserSingleAppoinmentInfoPage(),
                              arguments: [
                                snapshot.data[i].start,
                                snapshot.data[i].storeid,
                                snapshot.data[i].serviceid,
                                snapshot.data[i].bookingid,
                                snapshot.data[i].servicename,
                                snapshot.data[i].storename,
                              ]),
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 3),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 0.1,
                              // ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: SizedBox(
                                      height: 60,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image(
                                              image: NetworkImage(
                                                  snapshot.data[i].img))),
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
                                            snapshot.data[i].servicename,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Text(
                                            snapshot.data[i].storename,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          Text(
                                            snapshot.data[i].date,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: 100,
                                        height: 25,
                                        color: Colors.blue[700],
                                        child: Center(
                                            child: TextButton(
                                          onPressed: () {
                                            // Get.to(() => const ShopBookingPage(),
                                            //     arguments: [
                                            //       snapshot.data[i].id,
                                            //       snapshot.data[i].storeid,
                                            //       // snapshot.data[i].price,
                                            //       snapshot.data[i].name,
                                            //     ]);
                                          },
                                          child: Text(
                                            snapshot.data[i].start,
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
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

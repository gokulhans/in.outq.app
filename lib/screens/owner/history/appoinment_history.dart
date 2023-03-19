import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/screens/user/booking/user_view_booking.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerAppoinmentHistoryPage extends StatefulWidget {
  const OwnerAppoinmentHistoryPage({super.key});

  @override
  State<OwnerAppoinmentHistoryPage> createState() =>
      _OwnerAppoinmentHistoryPageState();
}

class _OwnerAppoinmentHistoryPageState
    extends State<OwnerAppoinmentHistoryPage> {
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
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'History',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: ColorConstants.textclr),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getOwnerOrders(),
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
                  return Column(
                    children: [
                      addVerticalSpace(50),
                      Center(
                          child: Text(
                        'No Appoinment is Done.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ColorConstants.textclr,
                        ),
                      )),
                    ],
                  );
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
                          child: Row(
                            children: [
                              // Expanded(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //       vertical: 12.0,
                              //     ),
                              //     child: Container(
                              //       height: 60,
                              //       child: ClipRRect(
                              //           borderRadius:
                              //               BorderRadius.circular(12.0),
                              //           child: const Image(
                              //               image: AssetImage(
                              //                   'assets/images/userImage.png'))),
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
                                          snapshot.data[i].servicename,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color:
                                                      ColorConstants.textclr),
                                        ),
                                        Text(
                                          snapshot.data[i].date,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color:
                                                      ColorConstants.textclr),
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
                                    child: SizedBox(
                                      width: 100,
                                      height: 25,
                                      // color: Colors.blue[700],
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
                                          child: snapshot.data[i].orderid ==
                                                  "Cancelled"
                                              ? Text(
                                                  snapshot.data[i].orderid,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1,
                                                  ),
                                                )
                                              : Text(
                                                  snapshot.data[i].orderid,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.green,
                                                    fontSize: 12,
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1,
                                                  ),
                                                ),
                                        ),
                                      ),
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

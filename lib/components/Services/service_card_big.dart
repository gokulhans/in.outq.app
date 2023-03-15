import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/utils/widget_functions.dart';

class ServiceCardBig extends StatelessWidget {
  var data;
  ServiceCardBig({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => {
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
              data['duration']
            ])
          }),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 3),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        // padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 0.1,
          // ),
        ),
        //decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.5),
        //       spreadRadius: 2,
        //       blurRadius: 10,
        //       offset: Offset(0, 3), // changes position of shadow
        //     ),
        //   ],
        // ),
        child: SizedBox(
          width: 240,
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  data['img'],
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              addVerticalSpace(10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          Text(
                            "${data['ogprice']} ₹",
                            // data['location'],
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.red[900]),
                          ),
                          addHorizontalSpace(5),
                          Text(
                            "${data['price']} ₹",
                            // data['location'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.green[900]),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${calculatePercentageDifference(double.parse(data['price'].replaceAll(",", "")), double.parse(data['ogprice'].replaceAll(",", ""))).toStringAsFixed(2)} % OFF",
                        // data['location'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.yellow[900]),
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 14,
                          ),
                          addHorizontalSpace(3),
                          Text(
                            "${data['duration']} minutes",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                              // color: ,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(5),
                      Text(
                        "${data['description']}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      addVerticalSpace(5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

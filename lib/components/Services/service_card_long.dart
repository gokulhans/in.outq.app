import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/utils/widget_functions.dart';

class ServiceCardLong extends StatelessWidget {
  var data, argdata;
  ServiceCardLong({super.key, required this.data, required this.argdata});

  @override
  Widget build(BuildContext context) {
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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
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
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 14,
                          ),
                          addHorizontalSpace(3),
                          Text(
                            "${data.duration} minutes",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            data.ogprice + " ₹",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough),
                          ),
                          addHorizontalSpace(10),
                          Text(data.price + " ₹",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                      Text(
                        "${data.description}",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2,
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
            ),
          ],
        ),
      ),
    );
  }
}
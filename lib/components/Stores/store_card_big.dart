import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/store/view_store/user_view_store.dart';
import 'package:outq/utils/widget_functions.dart';

class StoreCardBig extends StatelessWidget {
  var data;
  StoreCardBig({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const UserViewStorePage(), arguments: [
          data['type'],
          data['name'],
          data['start'],
          data['end']
        ]);
      },
      child: Container(
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
        child: SizedBox(
          width: 240,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Image.network(
                  data['img'],
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      data['name'],
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    addVerticalSpace(5),
                    Text(
                      data['location'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      // data['location'],
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.yellow[900]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

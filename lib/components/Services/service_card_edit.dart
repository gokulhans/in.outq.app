import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/owner/service/view/owner_single_service.dart';
import 'package:outq/utils/widget_functions.dart';

class ServiceCardEdit extends StatelessWidget {
  var data;
  ServiceCardEdit({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      // padding: const EdgeInsets.all(3),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.grey[200],
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.img),
                          width: 60,
                          height: 50,
                        )),
                  ),
                ),
                addHorizontalSpace(10),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text("${data.price} ₹",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline5),
                        ]),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          begin:
                              Alignment(0.8459399938583374, 0.1310659646987915),
                          end: Alignment(
                              -0.1310659646987915, 0.11150387674570084),
                          colors: [
                            Color.fromRGBO(83, 130, 231, 1),
                            Color.fromRGBO(20, 130, 231, 1)
                          ],
                        ),
                      ),
                      child: Center(
                        child: TextButton(
                            onPressed: () async {
                              Get.to(() => OwnerSingleServicePage(),
                                  arguments: [data.name, data.id]);
                            },
                            child: Text(
                              'View',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

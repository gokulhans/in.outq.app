import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/components/Services/service_card_edit.dart';
import 'package:outq/screens/owner/service/create/create_service.dart';
import 'package:outq/screens/owner/service/view/owner_single_service.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerViewServicePage extends StatelessWidget {
  const OwnerViewServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.appbgclr,
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                addVerticalSpace(10),
                Text(
                  'All Services',
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.textclr,
                    fontSize: 18,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => const CreateServicePage());
                    },
                    child: Text(
                      'New +',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFFFF7B32),
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
            FutureBuilder(
              future: getStoreServices(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                      child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ));
                } else {
                  if (snapshot.data.length == 0) {
                    return Column(
                      children: [
                        addVerticalSpace(30),
                        Center(
                            child: Text(
                          'Add Your First Service..',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: ColorConstants.textclr,
                          ),
                        )),
                      ],
                    );
                  } else {
                    return Expanded(
                      flex: 2,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return ServiceCardEdit(
                              data: snapshot.data[i],
                            );
                          }),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/Backend/api/owner_api.dart';
import 'package:outq/screens/owner/home/owner_home.dart';
import 'package:outq/screens/owner/service/edit/edit_service.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerSingleServicePage extends StatelessWidget {
  dynamic argumentData = Get.arguments;
  OwnerSingleServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: UserAppBarWithBack(
          title: argumentData[0],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getSingleServiceDetails(argumentData[1]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                      child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ));
                } else {
                  if (snapshot.data.length == 0) {
                    return const Center(
                        child: Text(
                      'No Content is available right now.',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ));
                  } else {
                    return Expanded(
                        flex: 2,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addVerticalSpace(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Service Details',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF09041B),
                                          fontSize: 18,
                                          // height: 1.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Get.to(() => EditServicePage(),
                                                arguments: snapshot.data[i]);
                                          },
                                          child: Text(
                                            'Edit',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFFF7B32),
                                              fontSize: 12,
                                              // height: 1.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ))
                                    ],
                                  ),
                                  addVerticalSpace(20),
                                  Text(
                                    'Name',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF09041B),
                                      fontSize: 15,
                                      // height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    snapshot.data[i].name,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  addVerticalSpace(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Description',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF09041B),
                                          fontSize: 15,
                                          // height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // TextButton(
                                      //     onPressed: () {},
                                      //     child: Text(
                                      //       'Edit',
                                      //       style: GoogleFonts.poppins(
                                      //         color: const Color(0xFFFF7B32),
                                      //         fontSize: 12,
                                      //         // height: 1.5,
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ))
                                    ],
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    snapshot.data[i].description,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  addVerticalSpace(20),
                                  Text(
                                    'Image',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF09041B),
                                      fontSize: 15,
                                      // height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  addVerticalSpace(20),
                                  Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              snapshot.data[i].img),
                                        ),
                                      ),
                                    ),
                                  ),
                                  addVerticalSpace(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discounted Price',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF09041B),
                                          fontSize: 15,
                                          // height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // TextButton(
                                      //     onPressed: () {},
                                      //     child: Text(
                                      //       'Edit',
                                      //       style: GoogleFonts.poppins(
                                      //         color: const Color(0xFFFF7B32),
                                      //         fontSize: 12,
                                      //         // height: 1.5,
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ))
                                    ],
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    snapshot.data[i].price,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  addVerticalSpace(20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Original Price',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF09041B),
                                          fontSize: 15,
                                          // height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // TextButton(
                                      //     onPressed: () {},
                                      //     child: Text(
                                      //       'Edit',
                                      //       style: GoogleFonts.poppins(
                                      //         color: const Color(0xFFFF7B32),
                                      //         fontSize: 12,
                                      //         // height: 1.5,
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ))
                                    ],
                                  ),
                                  addVerticalSpace(10),
                                  Text(
                                    snapshot.data[i].ogprice,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  addVerticalSpace(20),
                                  TextButton(
                                      onPressed: () async {
                                        await deleteService(
                                            snapshot.data[i].id);
                                        Get.to(() =>
                                            OwnerHomePage(currentIndex: 2));
                                      },
                                      child: Text(
                                        'Delete Service',
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 14,
                                          // height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                ],
                              );
                            }));
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

class ServiceListTile extends StatelessWidget {
  final name, price;
  const ServiceListTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Hair Cutting',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            addHorizontalSpace(20),
            Text(
              '10₹',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        // TextButton(
        //   onPressed: () {},
        //   child: Text(
        //     'Edit',
        //     style: GoogleFonts.poppins(
        //       color: const Color(0xFFFF7B32),
        //       fontSize: 12,
        //       // height: 1.5,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/store/view_store/user_view_store.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:http/http.dart' as http;

//  Container(
//                 padding: EdgeInsets.symmetric(horizontal: tDefaultSize),
//                 child: Column(
//                   children: [
//                     TextField(
//                       onChanged: (val) {
//                         setState(() {
//                           query = val;
//                           // print(query);
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         hintStyle: TextStyle(color: Colors.grey[500]),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: const BorderSide(
//                             color: Colors.grey,
//                             width: 2.0,
//                           ),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 14),
//                         suffixIcon: Icon(
//                           Icons.search,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           Get.to(() => SearchStorePage(), arguments: [query]);
//                         },
//                         child: const Text("Search")),
//                   ],
//                 ),
//               ),
class SearchStorePage extends StatelessWidget {
  dynamic argumentData = Get.arguments;
  SearchStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // print(argumentData[0]);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: UserAppBarWithBack(
          title: "Search Results",
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: tDefaultSize),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
              //   child: Column(
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(vertical: 16.0),
              //         child: Container(
              //           height: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15),
              //             color: Colors.grey[100],
              //           ),
              //           child: TextField(
              //             decoration: InputDecoration(
              //               hintText: "Search",
              //               hintStyle: TextStyle(color: Colors.grey[500]),
              //               border: InputBorder.none,
              //               contentPadding: const EdgeInsets.symmetric(
              //                   horizontal: 20, vertical: 14),
              //               suffixIcon: Icon(
              //                 Icons.search,
              //                 color: Colors.grey[800],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              FutureBuilder(
                future: http.get(
                    Uri.parse('${apidomain}store/search/${argumentData[0]}')),
                builder: (BuildContext context,
                    AsyncSnapshot<http.Response> snapshot) {
                  if (snapshot.hasData) {
                    var data = jsonDecode(snapshot.data!.body);
                    // return Expanded(
                    //   child: ListView.builder(
                    //     itemCount: data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return ListTile(
                    //         title: Text(data[index]['name']),
                    //       );
                    //     },
                    //   ),
                    // );
                    return Expanded(
                      flex: 3,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: tDefaultSize),
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data[i]['img']),
                                      width: 60,
                                      height: 50,
                                    ),
                                    // child: const Image(
                                    //     image: AssetImage(
                                    //         'assets/images/userImage.png'))
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
                                          data[i]['name'],
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Text(
                                          data[i]['description'],
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
                                        begin: Alignment(0.8459399938583374,
                                            0.1310659646987915),
                                        end: Alignment(-0.1310659646987915,
                                            0.11150387674570084),
                                        colors: [
                                          Color.fromRGBO(0, 81, 255, 1),
                                          Color.fromRGBO(0, 132, 255, 1)
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                        child: TextButton(
                                      onPressed: () {
                                        Get.to(() => const UserViewStorePage(),
                                            arguments: [
                                              data[i]['type'],
                                              data[i]['name'],
                                              data[i]['start'],
                                              data[i]['end']
                                            ]);
                                      },
                                      child: Text(
                                        "View",
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
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(child: PlaceholderLong());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

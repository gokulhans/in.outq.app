import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:outq/Backend/api/user_api.dart';
import 'package:outq/Backend/models/user_models.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq/screens/user/booking/success_booked.dart';
import 'package:outq/screens/user/components/appbar/user_appbar.dart';
import 'package:outq/screens/user/store/view_store/user_view_store.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

bool isLoadingBB = false;

Future save(BuildContext context) async {
  dynamic argumentData = Get.arguments;
  SharedPreferences pref = await SharedPreferences.getInstance();
  String userid = pref.getString("userid") ?? "null";
  if (userid == "null") {
    Get.to(() => const Exithome());
  }

  getTimeSlots(argumentData[2], booking.date);

  print({booking.date, booking.start, argumentData[2]});
  final response = await http.post(
      Uri.parse(
        "${apidomain}booking/book",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'start': booking.start,
        'end': booking.end,
        'storeid': booking.storeid,
        'serviceid': booking.serviceid,
        'userid': userid,
        'price': booking.price,
        'date': booking.date,
        'servicename': argumentData[3],
        'storename': argumentData[5],
        'img': argumentData[8],
        'username': userid,
      });
  isLoadingBB = false;
  // print(response);
  var jsonData = jsonDecode(response.body);
  // print(jsonData["success"]);
  if (jsonData["success"]) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Slot Successfully Booked')));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const AppointmentBooked()),
        (Route<dynamic> route) => false);
    isLoadingBB = false;
  } else {
    Get.snackbar(
      "Booking Failed",
      "Slot Can not book",
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.bounceIn,
    );
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(content: Text('Slot Could Not Booked')));
    isLoadingBB = false;
  }
}

BookingModel booking = BookingModel('', '', '', '', '', '', '', '', '', '', '');

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.width,
      required this.title,
      required this.onPressed,
      required this.disable})
      : super(key: key);

  final double width;
  final String title;
  final bool disable; //this is used to disable button
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        // width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: disable ? null : onPressed,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ShopBookingPage extends StatefulWidget {
  const ShopBookingPage({Key? key}) : super(key: key);

  @override
  State<ShopBookingPage> createState() => _ShopBookingPageState();
}

class _ShopBookingPageState extends State<ShopBookingPage> {
  dynamic argumentData = Get.arguments;

  //declaration
  // final CalendarFormat _format = CalendarFormat.month;
  final DateTime _focusDay = DateTime.now();
  final DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  final bool _isWeekend = false;
  final bool _dateSelected = false;
  final bool _timeSelected = false;
  String? token; //get token for insert booking date and time into database

  // Time
  // TimeOfDay selectedTime = TimeOfDay.now();
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked_s = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime,
  //   );

  //   if (picked_s != null && picked_s != selectedTime)
  //     setState(() {
  //       selectedTime = picked_s;
  //       final localizations = MaterialLocalizations.of(context);
  //       final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
  //       booking.start = formattedTimeOfDay;
  //       booking.end = formattedTimeOfDay;
  //       // // print(booking.date);
  //     });
  // }

  // Future<void> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('token') ?? '';
  // }

  // @override
  // void initState() {
  //   getToken();
  //   super.initState();
  // }

  late Future<http.Response> _future;

  @override
  void initState() {
    super.initState();
    booking.start = "10:00 AM";
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    booking.date = formattedDate;
    print({booking.date, booking.start});
    _future = http.get(Uri.parse(
        '${apidomain}booking/timeslots/${argumentData[2]}/${booking.date}'));
    // print(_future);
    // print(DateTime.now());
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectBookingTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        final localizations = MaterialLocalizations.of(context);
        final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
        var start = formattedTimeOfDay;
        booking.start = start;
        // print(start);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;

    List<Widget> timeSlots = [];

    final DateTime startTime = DateTime(2023, 3, 6, 9, 0); // 9:00 AM
    final DateTime endTime = DateTime(2023, 3, 6, 17, 0); // 5:00 PM
    final int timeIntervalInMinutes = 10;

    // Loop through each 10-minute interval between start and end time
    for (DateTime time = startTime;
        time.isBefore(endTime);
        time = time.add(Duration(minutes: timeIntervalInMinutes))) {
      DateTime endTimeForSlot =
          time.add(Duration(minutes: timeIntervalInMinutes));

      // Format the start and end time for display
      String startTimeString = DateFormat.jm().format(time);
      String endTimeString = DateFormat.jm().format(endTimeForSlot);

      // Create a list item for the time interval
      timeSlots.add(ListTile(
        title: Text('$startTimeString - $endTimeString'),
        onTap: () {
          // Handle booking logic when a time slot is tapped
        },
      ));
    }

    // Future createTimeslots(var serviceid, var date) async {
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   var userid = pref.getString("userid");

    //   var response = await http
    //       .get(Uri.parse('${apidomain}booking/timeslots/$serviceid/$date'));
    //   var jsonData = jsonDecode(response.body);
    //   print({"test time ", jsonData[0]});

    //   final chunkSize = 6;
    //   for (var i = 0; i < jsonData.length; i += chunkSize) {
    //     chunks.add(jsonData.sublist(i,
    //         i + chunkSize > jsonData.length ? jsonData.length : i + chunkSize));
    //   }
    //   setState(() {
    //     chunks = chunks;
    //   });

    //   print({"chunks", chunks[0]});
    // }

    // int start = 12 - int.parse(argumentData[6]);
    // int end = int.parse(argumentData[7]);
    // int hours = start + end + 1;
    // Config().init(context);
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: UserAppBarWithBack(
          title: argumentData[3],
        ),
      ),
      // floatingActionButton:
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
          color: ColorConstants.appbgclr,
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        // margin: const EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 20),
                        // padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 238, 238, 238),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(01),
                          //     spreadRadius: 1,
                          //     blurRadius: 3,
                          //     offset: const Offset(
                          //         0, 3), // changes position of shadow
                          //   ),
                          // ],
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
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(argumentData[8]),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                argumentData[3],
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
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
                                                    "${argumentData[9]} minutes",
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  ),
                                                ],
                                              ),
                                              addVerticalSpace(5),
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   data.ogprice + " ₹",
                                                  //   textAlign: TextAlign.left,
                                                  //   style: const TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w600,
                                                  //       color: Colors.red,
                                                  //       decoration:
                                                  //           TextDecoration
                                                  //               .lineThrough),
                                                  // ),
                                                  // addHorizontalSpace(10),
                                                  Text(argumentData[4] + " ₹",
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5),
                                                ],
                                              ),
                                              // Text(
                                              //   argumentData[9],
                                              //   textAlign: TextAlign.left,
                                              //   maxLines: 1,
                                              //   overflow: TextOverflow.ellipsis,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .subtitle2,
                                              // ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(argumentData[2]),
                      addVerticalSpace(20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConstants.textclr,
                          ),
                        ),
                      ),
                      addVerticalSpace(30),
                      HorizontalCalendar(
                        date: DateTime.now(),
                        textColor: ColorConstants.textclr,
                        backgroundColor: ColorConstants.appbgclr,
                        selectedColor: ColorConstants.blue,
                        showMonth: true,
                        onDateSelected: (date) {
                          // // print(argumentData);
                          print(date);
                          booking.date = date.toString();
                          // print(booking.date);
                          setState(() {
                            _future = http.get(Uri.parse(
                                '${apidomain}booking/timeslots/${argumentData[2]}/${booking.date}'));
                            print({
                              booking.date,
                              booking.storeid,
                              argumentData[2]
                            });
                          });
                          Get.to(() => const ShopBookingPage());
                        },
                      ),
                      addVerticalSpace(50),
                      // addVerticalSpace(30),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       _selectTime(context);
                      //     },
                      //     child: const Text('Choose Time'),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Chose Your Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConstants.textclr,
                          ),
                        ),
                      ),
                      addVerticalSpace(20),
                      FutureBuilder<http.Response>(
                        future: _future,
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> snapshot) {
                          if (snapshot.hasData) {
                            var data = jsonDecode(snapshot.data!.body);
                            final chunkSize = 12;

                            var chunks = <List<dynamic>>[];

                            for (var i = 0; i < data.length; i += chunkSize) {
                              chunks.add(data.sublist(
                                  i,
                                  i + chunkSize > data.length
                                      ? data.length
                                      : i + chunkSize));
                            }
                            print(chunks);
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
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: chunks
                                    .length, // The number of items in the list
                                itemBuilder: (BuildContext context, int i) {
                                  // This function is called for each item in the list
                                  return Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            "${chunks[i][0]["time"].contains("AM") || chunks[i][0]["time"].contains("PM") ? chunks[i][0]["time"] : chunks[i][0]["time"] + " AM"}",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      GridView.builder(
                                        // physics:
                                        //     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 2),
                                        itemCount: chunks[i].length,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              print(chunks[i][index]["time"]);
                                              setState(() {
                                                _currentIndex = i * 100 + index;
                                                booking.start =
                                                    chunks[i][index]["time"];
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //   color: _currentIndex == index
                                                //       ? Colors.white
                                                //       : (data[index]["status"] == "n")
                                                //           ? Colors.black
                                                //           : Colors.white,
                                                // ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: _currentIndex ==
                                                        i * 100 + index
                                                    ? Colors.blue
                                                    : (chunks[i][index]
                                                                ["status"] ==
                                                            "n")
                                                        ? Colors.white70
                                                        : Colors.red,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                chunks[i][index]['time'],
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: _currentIndex ==
                                                            i * 100 + index
                                                        ? Colors.white
                                                        : (chunks[i][index][
                                                                    "status"] ==
                                                                "n")
                                                            ? const Color
                                                                    .fromARGB(
                                                                255, 18, 48, 97)
                                                            : Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                });
                          } else if (snapshot.hasData) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Center(child: PlaceholderLong());
                          }
                        },
                      ),
                      // FutureBuilder(
                      //   future: _future,
                      //   // future: getTimeSlots(argumentData[2], booking.date),
                      //   builder: (context, AsyncSnapshot snapshot) {
                      //     if (snapshot.data == null) {
                      //       return const Center(
                      //           child: SpinKitCircle(
                      //         color: Colors.blue,
                      //         size: 50.0,
                      //       ));
                      //     } else {
                      //       if (snapshot.data.length == 0) {
                      //         return const Padding(
                      //           padding: EdgeInsets.all(24.0),
                      //           child: Center(
                      //               child: Text(
                      //             'No Appoinment Found Today',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w800,
                      //               color: Colors.red,
                      //             ),
                      //           )),
                      //         );
                      //       } else {
                      //         return SizedBox(
                      //           height: 150,
                      //           child: Center(
                      //             child: GridView.builder(
                      //                 // physics:
                      //                 //     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                      //                 shrinkWrap: true,
                      //                 gridDelegate:
                      //                     const SliverGridDelegateWithFixedCrossAxisCount(
                      //                         crossAxisCount: 3,
                      //                         childAspectRatio: 2.8),
                      //                 itemCount: snapshot.data.length,
                      //                 itemBuilder:
                      //                     (BuildContext context, int index) {
                      //                   return InkWell(
                      //                     splashColor: Colors.transparent,
                      //                     onTap: () {
                      //                       // setState(() {
                      //                       //   // print(
                      //                       //       "${index + 9}:${30} ${index + 9 > 11 ? "PM" : "AM"}");
                      //                       //   _currentIndex = index;
                      //                       //   _timeSelected = true;
                      //                       // });
                      //                     },
                      //                     child: Container(
                      //                       height: 50,
                      //                       margin: const EdgeInsets.all(5),
                      //                       decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                           color: _currentIndex == index
                      //                               ? Colors.white
                      //                               : Colors.white,
                      //                         ),
                      //                         borderRadius:
                      //                             BorderRadius.circular(15),
                      //                         color: Colors.red,
                      //                       ),
                      //                       alignment: Alignment.center,
                      //                       child: Text(
                      //                         snapshot.data[index].start +
                      //                             " to " +
                      //                             snapshot.data[index].end,
                      //                         style: TextStyle(
                      //                             fontSize: 8,
                      //                             fontWeight: FontWeight.bold,
                      //                             color: _currentIndex == index
                      //                                 ? Colors.white
                      //                                 : Colors.white),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }),
                      //           ),
                      //         );
                      //       }
                      //     }
                      //   },
                      // ),
                      addVerticalSpace(30),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10),
                      //   child: Text(
                      //     'Select Your Time',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 80,
                      //   // padding: const EdgeInsets.symmetric(vertical: 12.0),
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(22),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       TextButton(
                      //         onPressed: () {
                      //           _selectBookingTime(context);
                      //         },
                      //         child: Container(
                      //           color: Colors.blue,
                      //           child: const Padding(
                      //             padding: EdgeInsets.all(8.0),
                      //             child: Text(
                      //               'Chose Booking Time',
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Text(
                      //         booking.start,
                      //         style: Theme.of(context).textTheme.subtitle1,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 200,
                      //   // child: Center(
                      //   //   child: GridView.builder(
                      //   //       physics:
                      //   //           const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                      //   //       shrinkWrap: true,
                      //   //       gridDelegate:
                      //   //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //   //               crossAxisCount: 4, childAspectRatio: 1.6),
                      //   //       itemCount: 10,
                      //   //       itemBuilder: (BuildContext context, int index) {
                      //   //         return InkWell(
                      //   //           splashColor: Colors.transparent,
                      //   //           onTap: () {
                      //   //             booking.start =
                      //   //                 "${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}";
                      //   //             // print(booking.start);
                      //   //             setState(() {
                      //   //               _currentIndex = index;
                      //   //               // _timeSelected = true;
                      //   //             });
                      //   //           },
                      //   //           child: Container(
                      //   //             margin: const EdgeInsets.all(5),
                      //   //             decoration: BoxDecoration(
                      //   //               border: Border.all(
                      //   //                 color: _currentIndex == index
                      //   //                     ? Colors.white
                      //   //                     : Colors.black,
                      //   //               ),
                      //   //               borderRadius: BorderRadius.circular(15),
                      //   //               color: _currentIndex == index
                      //   //                   ? Colors.blue
                      //   //                   : null,
                      //   //             ),
                      //   //             alignment: Alignment.center,
                      //   //             child: Text(
                      //   //               '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                      //   //               style: TextStyle(
                      //   //                 fontSize: 12,
                      //   //                 fontWeight: FontWeight.bold,
                      //   //                 color: _currentIndex == index
                      //   //                     ? Colors.white
                      //   //                     : null,
                      //   //               ),
                      //   //             ),
                      //   //           ),
                      //   //         );
                      //   //       }),
                      //   // ),
                      //   child: ListView(
                      //     children: timeSlots,
                      //   ),
                      // ),
                      addVerticalSpace(30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Store',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: ColorConstants.textclr,
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[5],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue[100],
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Service',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: ColorConstants.textclr,
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[3],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue[100],
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: ColorConstants.textclr,
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[4],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue[100],
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      // addVerticalSpace(10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: ColorConstants.textclr,
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  argumentData[9],
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue[100],
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(20),
                      Center(
                        child: Container(
                          width: 150,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                ColorConstants.bluegradient1,
                                ColorConstants.bluegradient2
                              ],
                              transform: const GradientRotation(9 * pi / 180),
                            ),
                          ),
                          child: Center(
                            child: TextButton(
                              child: isLoadingBB
                                  ? const Center(
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Book",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                              onPressed: () {
                                setState(() {
                                  isLoadingBB = true;
                                });
                                // print('booking 1');
                                // print(booking);
                                // print({
                                //   booking.serviceid,
                                //   booking.storeid,
                                //   booking.price,
                                //   booking.img
                                // });
                                // print('booking 2');
                                // print({argumentData[0], argumentData[2]});
                                // print('booking 3');
                                booking.serviceid = argumentData[0];
                                booking.storeid = argumentData[2];
                                booking.price = argumentData[4];
                                booking.img = argumentData[8];
                                // print('booking');
                                save(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(20),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

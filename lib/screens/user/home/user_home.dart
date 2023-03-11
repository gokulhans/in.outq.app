import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/owner/service/edit/edit_service.dart';
import 'package:outq/screens/user/booking/booking.dart';
import 'package:outq/screens/user/booking/view-booking.dart';
import 'package:outq/screens/user/components/appbar/user_bar_main.dart';
import 'package:outq/screens/user/search/gender_search.dart';
import 'package:outq/screens/user/search/user_search.dart';
import 'package:outq/screens/user/store/view_store/user_view_store.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String? userlocation;
String? userlongitude;
String? userlatitude;
String? userpincode;
bool isVisible = true;

Future updateuser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString("userid") ?? "null";
  // String deviceid = "";

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) {
  //   deviceid = token!;
  // });

  http.post(
      Uri.parse(
        "${apidomain}auth/user/update/$userid",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'location': userlocation ?? "",
        'pincode': userpincode ?? "",
        'longitude': userlongitude ?? "",
        'latitude': userlatitude ?? "",
        // 'deviceid': deviceid
      });

  // if (response.statusCode == 201) {
  //   var jsonData = jsonDecode(response.body);
  //   // print(jsonData);
  //   // print(jsonData["success"]);
  //   if (jsonData["success"]) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (BuildContext context) => OwnerExithome()),
  //         (Route<dynamic> route) => false);
  //   }
  // }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String _currentAddress = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Location permissions are denied. Enable to Continue')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      Geolocator.openLocationSettings();
    }
    // return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // print(place.country);
      setState(() {
        _currentAddress =
            '${place.administrativeArea}, ${place.locality}, ${place.thoroughfare}, ${place.postalCode}';
      });
      // print({_currentAddress, _currentPosition});
      userlocation = _currentAddress;
      userlongitude = _currentPosition!.longitude.toString();
      userlatitude = _currentPosition!.latitude.toString();
      userpincode = place.postalCode.toString();
      updateuser(context);
      isVisible = true;
      setState(() {});
      // print("object");
      // print(isVisible);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  int currentIndex = 0;
  List tabScreens = [
    const Center(child: UserHomeScreen()),
    // Center(child: UserSearchServicesPage()),
    const Center(child: UserViewBookingsPage()),
    // Center(child: UserServiceSearchPage()),
    // Center(child: UserChatListPage()),
    // Center(child: UserMyProfilePage()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: UserAppBar(
          title: "_currentAddress",
        ),
      ),
      // drawer: const UserDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          unselectedLabelStyle: GoogleFonts.poppins(
            color: Colors.blueGrey[50],
          ),
          selectedIconTheme: IconThemeData(
            color: ColorConstants.blue,
          ),
          selectedLabelStyle: GoogleFonts.poppins(
            color: ColorConstants.blue,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.blueGrey[200],
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 20,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // icon: Icon(Icons.home_rounded),
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch),
              label: 'Appoinments',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
          ]),
      body: tabScreens.elementAt(currentIndex),
      // body: const UserHomeScreen(),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Future<http.Response>? _followfuture;
  Future<http.Response>? _combofuture;
  var userid;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString("userid");
    setState(() {
      _combofuture =
          http.get(Uri.parse('${apidomain}service/search/combo/$userid'));
      _followfuture =
          http.get(Uri.parse('${apidomain}auth/user/saved/$userid'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    onload();
    super.initState();
  }

  var query;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: isVisible
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addVerticalSpace(10),
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: ListView(
                        children: [
                          CarouselSlider(
                            items: [
                              //1st Image of Slider
                              InkWell(
                                onTap: () {
                                  Get.to(() => const UserViewStorePage(),
                                      arguments: [
                                        // "6409b179b4eee0572655fef8",
                                        // "nsah",
                                        // "9:00 AM",
                                        // "5:00 PM",
                                        //  "data[index]['type']",
                                        //         // data[index]['name'],
                                        //         // data[index]['start'],
                                        //         // data[index]['end']
                                      ]);
                                },
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://outq.vercel.app/image1.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                // onTap: () {
                                //   Get.to(() => const UserViewStorePage(),
                                //       arguments: [
                                //         "data[index]['type']",
                                //         "data[index]['type']",
                                //         "data[index]['type']",
                                //         "data[index]['type']",
                                //         // data[index]['name'],
                                //         // data[index]['start'],
                                //         // data[index]['end']
                                //       ]);
                                // },
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://outq.vercel.app/image2.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            //Slider Container properties
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              // autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              // viewportFraction: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(10),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  query = val;
                                  // print(query);
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                // suffixIcon: Icon(
                                //   Icons.search,
                                //   color: Colors.grey[800],
                                // ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(
                                    () => UserSearchServicesPage(
                                          title: "Search Results for $query",
                                        ),
                                    arguments: [query]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue,
                                ),
                                child: const Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    // addVerticalSpace(20),
                    // Container(
                    //   height: 180,
                    //   margin: const EdgeInsets.all(6.0),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     image: const DecorationImage(
                    //       image: AssetImage("assets/images/ad.jpg"),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    addVerticalSpace(10),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Gender',
                    //         style: GoogleFonts.poppins(
                    //           color: const Color(0xFF09041B),
                    //           fontSize: 18,
                    //           // height: 1.5,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //       // TextButton(
                    //       //     onPressed: () {},
                    //       //     child: Text(
                    //       //       'View More',
                    //       //       style: GoogleFonts.poppins(
                    //       //         color: const Color(0xFFFF7B32),
                    //       //         fontSize: 12,
                    //       //         // height: 1.5,
                    //       //         fontWeight: FontWeight.w500,
                    //       //       ),
                    //       //     ))
                    //     ],
                    //   ),
                    // ),
                    // addVerticalSpace(10),
                    // SizedBox(
                    //   height: 120,
                    //   child: ListView.builder(
                    //     physics: const BouncingScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 2,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       List<String> myArray = [
                    //         "Gents",
                    //         "Ladies",
                    //       ];
                    //       return InkWell(
                    //         onTap: (() => {
                    //               Get.to(() => const GenderFilterPage(),
                    //                   arguments: [myArray[index]])
                    //             }),
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 8),
                    //           child: Container(
                    //             width: 80.0,
                    //             height: 80.0,
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: Colors.blue,
                    //             ),
                    //             child: Center(
                    //               child: ClipOval(
                    //                 child: Container(
                    //                   color: Colors.green,
                    //                   width: 80.0,
                    //                   height: 80.0,
                    //                   child: Center(
                    //                     child: Text(
                    //                       myArray[index],
                    //                       style: TextStyle(
                    //                         fontSize: 10.0,
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    addVerticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(() => const GenderFilterPage(),
                                      arguments: ['Men'])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    // width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(12),
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Men",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )),
                                  ),
                                ),
                                addVerticalSpace(5),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(() => const GenderFilterPage(),
                                      arguments: ['Women'])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    // width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(12),
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Women",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )),
                                  ),
                                ),
                                addVerticalSpace(5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Services Types',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF09041B),
                              fontSize: 20,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View More',
                          //       style: GoogleFonts.poppins(
                          //         color: const Color(0xFFFF7B32),
                          //         fontSize: 12,
                          //         // height: 1.5,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(
                                      () => UserSearchServicesPage(
                                            title: "Facial",
                                          ),
                                      arguments: ["facial"])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: ClipOval(
                                        child: Container(
                                          // color: Colors.green,
                                          width: 60.0,
                                          height: 60.0,
                                          child: const Center(
                                              child: Icon(
                                            Icons.face,
                                            size: 32,
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(
                                  "Facial ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(
                                      () => UserSearchServicesPage(
                                            title: "Cut",
                                          ),
                                      arguments: ["cut"])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: ClipOval(
                                        child: Container(
                                          // color: Colors.green,
                                          width: 80.0,
                                          height: 80.0,
                                          child: const Center(
                                              child: Icon(Icons.cut, size: 24)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(
                                  "Hair Cut",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(
                                      () => UserSearchServicesPage(
                                            title: "Threading",
                                          ),
                                      arguments: ["Threading"])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: ClipOval(
                                        child: Container(
                                          // color: Colors.green,
                                          width: 80.0,
                                          height: 80.0,
                                          child: const Center(
                                              child: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  size: 32)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(
                                  "Threading ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (() => {
                                  Get.to(
                                      () => UserSearchServicesPage(
                                            title: "Pedicure",
                                          ),
                                      arguments: ["Pedicure"])
                                }),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                      // color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: ClipOval(
                                        child: Container(
                                          // color: Colors.green,
                                          width: 80.0,
                                          height: 80.0,
                                          child: const Center(
                                              child: Icon(Icons.fingerprint,
                                                  size: 32)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(
                                  "Pedicure ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Near By Offers',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF09041B),
                              fontSize: 20,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View More',
                          //       style: GoogleFonts.poppins(
                          //         color: const Color(0xFFFF7B32),
                          //         fontSize: 12,
                          //         // height: 1.5,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    addVerticalSpace(10),
                    addVerticalSpace(10),
                    FutureBuilder(
                      future: http.get(Uri.parse('${apidomain}service/getall')),
                      builder: (BuildContext context,
                          AsyncSnapshot<http.Response> snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data!.body);
                          // print(data);
                          return SizedBox(
                            height: 280,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data
                                  .length, // Replace with the actual number of items in your list
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: (() => {
                                        Get.to(() => const ShopBookingPage(),
                                            arguments: [
                                              data[index]['ownerid'],
                                              data[index]['type'],
                                              data[index]['storeid'],
                                              data[index]['name'],
                                              data[index]['price'],
                                              data[index]['storename'],
                                              data[index]['start'],
                                              data[index]['end'],
                                              data[index]['img'],
                                              data[index]['duration']
                                            ])
                                      }),
                                  child: Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 3),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                            child: Image.network(
                                              data[index]['img'],
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          addVerticalSpace(10),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    data[index]['name'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data[index]['ogprice']} ₹",
                                                        // data[index]['location'],
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .red[900]),
                                                      ),
                                                      addHorizontalSpace(5),
                                                      Text(
                                                        "${data[index]['price']} ₹",
                                                        // data[index]['location'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .green[900]),
                                                      ),
                                                    ],
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
                                                        "${data[index]['duration']} minutes",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors
                                                              .yellow[900],
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Text(
                                                    "${data[index]['description']}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    // addVerticalSpace(10),

                    // addVerticalSpace(10),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Saved Stores',
                    //         style: GoogleFonts.poppins(
                    //           color: const Color(0xFF09041B),
                    //           fontSize: 18,
                    //           // height: 1.5,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //       // TextButton(
                    //       //     onPressed: () {},
                    //       //     child: Text(
                    //       //       'View More',
                    //       //       style: GoogleFonts.poppins(
                    //       //         color: const Color(0xFFFF7B32),
                    //       //         fontSize: 12,
                    //       //         // height: 1.5,
                    //       //         fontWeight: FontWeight.w500,
                    //       //       ),
                    //       //     ))
                    //     ],
                    //   ),
                    // ),
                    // addVerticalSpace(10),
                    // FutureBuilder(
                    //   future: http.get(Uri.parse('${apidomain}service/getall')),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<http.Response> snapshot) {
                    //     if (snapshot.hasData) {
                    //       var data = jsonDecode(snapshot.data!.body);
                    //       // print(data);
                    //       return SizedBox(
                    //         height: 240,
                    //         child: ListView.builder(
                    //           physics: const BouncingScrollPhysics(),
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: data
                    //               .length, // Replace with the actual number of items in your list
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return InkWell(
                    //               onTap: (() => {
                    //                     Get.to(() => const ShopBookingPage(),
                    //                         arguments: [
                    //                           data[index]['ownerid'],
                    //                           data[index]['type'],
                    //                           data[index]['storeid'],
                    //                           data[index]['name'],
                    //                           data[index]['price'],
                    //                           data[index]['storename'],
                    //                           data[index]['start'],
                    //                           data[index]['end'],
                    //                           data[index]['img'],
                    //                           data[index]['duration']
                    //                         ])
                    //                   }),
                    //               child: Container(
                    //                 margin: EdgeInsets.symmetric(horizontal: 3),
                    //                 //decoration: BoxDecoration(
                    //                 //   boxShadow: [
                    //                 //     BoxShadow(
                    //                 //       color: Colors.black.withOpacity(0.5),
                    //                 //       spreadRadius: 2,
                    //                 //       blurRadius: 10,
                    //                 //       offset: Offset(0, 3), // changes position of shadow
                    //                 //     ),
                    //                 //   ],
                    //                 // ),
                    //                 child: SizedBox(
                    //                   width: 240,
                    //                   height: 140,
                    //                   child: Card(
                    //                     margin: const EdgeInsets.symmetric(
                    //                         horizontal: 8, vertical: 8),
                    //                     elevation: 0,
                    //                     shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(16)),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.stretch,
                    //                       children: [
                    //                         ClipRRect(
                    //                           borderRadius:
                    //                               const BorderRadius.vertical(
                    //                                   top: Radius.circular(16)),
                    //                           child: Image.network(
                    //                             data[index]['img'],
                    //                             height: 140,
                    //                             fit: BoxFit.cover,
                    //                           ),
                    //                         ),
                    //                         addVerticalSpace(5),
                    //                         Padding(
                    //                           padding: const EdgeInsets.all(4),
                    //                           child: Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: [
                    //                               Text(
                    //                                 data[index]['name'],
                    //                                 style: const TextStyle(
                    //                                     fontSize: 16,
                    //                                     fontWeight:
                    //                                         FontWeight.w700),
                    //                               ),
                    //                               addVerticalSpace(5),
                    //                               Row(
                    //                                 children: [
                    //                                   Text(
                    //                                     "${data[index]['ogprice']} ₹",
                    //                                     // data[index]['location'],
                    //                                     style: TextStyle(
                    //                                         decoration:
                    //                                             TextDecoration
                    //                                                 .lineThrough,
                    //                                         fontSize: 12,
                    //                                         fontWeight:
                    //                                             FontWeight.w700,
                    //                                         color: Colors
                    //                                             .red[900]),
                    //                                   ),
                    //                                   addHorizontalSpace(5),
                    //                                   Text(
                    //                                     "${data[index]['price']} ₹",
                    //                                     // data[index]['location'],
                    //                                     style: TextStyle(
                    //                                         fontSize: 14,
                    //                                         fontWeight:
                    //                                             FontWeight.w700,
                    //                                         color: Colors
                    //                                             .green[900]),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               addVerticalSpace(3),
                    //                               Text(
                    //                                 "${data[index]['duration']} minutes",
                    //                                 style: const TextStyle(
                    //                                     fontSize: 12,
                    //                                     fontWeight:
                    //                                         FontWeight.w500),
                    //                               ),
                    //                               Text(
                    //                                 "${data[index]['description']}",
                    //                                 style: const TextStyle(
                    //                                     fontSize: 12,
                    //                                     fontWeight:
                    //                                         FontWeight.w500),
                    //                               ),
                    //                               // addVerticalSpace(5),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Text('${snapshot.error}');
                    //     }
                    //     return const CircularProgressIndicator();
                    //   },
                    // ),
                    addVerticalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Near By Stores',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF09041B),
                              fontSize: 20,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View More',
                          //       style: GoogleFonts.poppins(
                          //         color: const Color(0xFFFF7B32),
                          //         fontSize: 12,
                          //         // height: 1.5,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    FutureBuilder(
                      future:
                          http.get(Uri.parse('${apidomain}store/store/get')),
                      builder: (BuildContext context,
                          AsyncSnapshot<http.Response> snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data!.body);
                          // print(data);
                          return Container(
                            child: SizedBox(
                              height: 240,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const UserViewStorePage(),
                                          arguments: [
                                            data[index]['type'],
                                            data[index]['name'],
                                            data[index]['start'],
                                            data[index]['end']
                                          ]);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
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
                                        child: Card(
                                          // margin: const EdgeInsets.symmetric(
                                          //     horizontal: 8,),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .vertical(
                                                    top: Radius.circular(10)),
                                                child: Image.network(
                                                  data[index]['img'],
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              addVerticalSpace(10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      data[index]['name'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    addVerticalSpace(5),
                                                    Text(
                                                      data[index]['location'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // data[index]['location'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .yellow[900]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    addVerticalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Followed Stores',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF09041B),
                              fontSize: 20,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View More',
                          //       style: GoogleFonts.poppins(
                          //         color: const Color(0xFFFF7B32),
                          //         fontSize: 12,
                          //         // height: 1.5,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    FutureBuilder(
                      future: _followfuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<http.Response> snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data!.body);
                          print(data);
                          return Container(
                            child: SizedBox(
                              height: 240,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const UserViewStorePage(),
                                          arguments: [
                                            data[index]['type'],
                                            data[index]['name'],
                                            data[index]['start'],
                                            data[index]['end']
                                          ]);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
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
                                        child: Card(
                                          // margin: const EdgeInsets.symmetric(
                                          //     horizontal: 8,),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .vertical(
                                                    top: Radius.circular(10)),
                                                child: Image.network(
                                                  data[index]['img'],
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              addVerticalSpace(10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      data[index]['name'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    addVerticalSpace(5),
                                                    Text(
                                                      data[index]['location'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // data[index]['location'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .yellow[900]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    addVerticalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Combo Offers',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF09041B),
                              fontSize: 20,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View More',
                          //       style: GoogleFonts.poppins(
                          //         color: const Color(0xFFFF7B32),
                          //         fontSize: 12,
                          //         // height: 1.5,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    FutureBuilder(
                      future: _combofuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<http.Response> snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data!.body);
                          // print(data);
                          return SizedBox(
                            height: 280,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data
                                  .length, // Replace with the actual number of items in your list
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: (() => {
                                        Get.to(() => const ShopBookingPage(),
                                            arguments: [
                                              data[index]['ownerid'],
                                              data[index]['type'],
                                              data[index]['storeid'],
                                              data[index]['name'],
                                              data[index]['price'],
                                              data[index]['storename'],
                                              data[index]['start'],
                                              data[index]['end'],
                                              data[index]['img'],
                                              data[index]['duration']
                                            ])
                                      }),
                                  child: Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 3),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                            child: Image.network(
                                              data[index]['img'],
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          addVerticalSpace(10),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    data[index]['name'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data[index]['ogprice']} ₹",
                                                        // data[index]['location'],
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .red[900]),
                                                      ),
                                                      addHorizontalSpace(5),
                                                      Text(
                                                        "${data[index]['price']} ₹",
                                                        // data[index]['location'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .green[900]),
                                                      ),
                                                    ],
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
                                                        "${data[index]['duration']} minutes",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors
                                                              .yellow[900],
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Text(
                                                    "${data[index]['description']}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    addVerticalSpace(20),
                  ],
                ),
              ),
            )
          : const SpinKitCircle(
              color: Colors.blue,
              size: 50.0,
            ),
    );
  }
}

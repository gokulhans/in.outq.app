import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:outq/screens/user/home/user_home.dart';
import 'package:outq/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latLng;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

String _userlocation = "";
String _userlongitude = "0.0";
String _userlatitude = "0.0";

Future updateuser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString("userid") ?? "null";
  // String deviceid = "";

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) {
  //   deviceid = token!;
  // });

  var response = await http.post(
      Uri.parse(
        "${apidomain}auth/user/update/$userid",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'location': _userlocation,
        'pincode': "",
        'longitude': _userlongitude,
        'latitude': _userlatitude,
        // 'deviceid': deviceid
      });

  Get.to(() => const UserHomePage());
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

class ShowLocationMap extends StatefulWidget {
  var lat, long;
  ShowLocationMap({super.key, required this.lat, required this.long});

  @override
  State<ShowLocationMap> createState() => _ShowLocationMapState();
}

class _ShowLocationMapState extends State<ShowLocationMap> {
  final mapController = MapController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.lat);
    print(widget.long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: OpenStreetMapSearchAndPick(
            center: LatLong(widget.lat, widget.long),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              setState(() {
                _userlocation = pickedData.address;
                _userlatitude = pickedData.latLong.latitude.toString();
                _userlongitude = pickedData.latLong.longitude.toString();
                updateuser(context);
              });
            }),
      ),
    );
  }
}

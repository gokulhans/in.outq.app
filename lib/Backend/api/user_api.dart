import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/Backend/models/user_models.dart';
import 'package:outq/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getAllStores() async {
  var response = await http.get(Uri.parse('${apidomain}store/store/get'));
  var jsonData = jsonDecode(response.body);
  // print(jsonData);
  List<Store> stores = [];
  for (var u in jsonData) {
    Store store = Store(
        u["_id"],
        u["name"],
        u["location"],
        u["id"],
        u["description"],
        u["type"],
        u["img"],
        u["start"],
        u["end"],
        u["employees"],
        u["gender"],
        u["working"]);
    stores.add(store);
  }
  // // print(stores);
  return stores;
}

Future getSingleStore(var storeid) async {
  // print(storeid);
  var response =
      await http.get(Uri.parse('${apidomain}store/store/get/$storeid'));
  var jsonData = jsonDecode(response.body);
  // print(jsonData);
  List<Store> stores = [];
  for (var u in jsonData) {
    Store store = Store(
        u["_id"],
        u["name"],
        u["location"],
        u["id"],
        u["description"],
        u["type"],
        u["img"],
        u["start"],
        u["end"],
        u["employees"],
        u["gender"],
        u["working"]);
    stores.add(store);
  }
  // print(stores);
  return stores;
}

Future getUserBookings() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  var userid = pref.getString("userid");

  var response =
      await http.get(Uri.parse('${apidomain}booking/viewall/$userid'));
  var jsonData = jsonDecode(response.body);
  // print("object");
  // print(jsonData);

  List<GetBookingModel> bookings = [];
  for (var u in jsonData) {
    GetBookingModel booking = GetBookingModel(
      u["_id"],
      u["start"],
      u["end"],
      u["storeid"],
      u["serviceid"],
      u["userid"],
      u["bookingid"],
      u["price"],
      u["date"],
      u["servicename"],
      u["storename"],
      u["img"],
      u["username"],
    );

    bookings.add(booking);
  }
  // print(bookings);
  return bookings;
}

Future getTimeSlots(var serviceid, var date) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // print(serviceid);

  var userid = pref.getString("userid");

  var response = await http
      .get(Uri.parse('${apidomain}booking/timeslots/$serviceid/$date'));
  var jsonData = jsonDecode(response.body);
  // print(jsonData);

  List<TimeSlots> slots = [];
  for (var u in jsonData) {
    TimeSlots slot = TimeSlots(u["start"], u["end"], u["date"]);

    slots.add(slot);
  }
  // print(slots);
  return slots;
}

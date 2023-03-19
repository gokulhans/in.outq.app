import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:outq/Backend/models/owner_models.dart';
import 'package:outq/Backend/models/user_models.dart';
import 'package:outq/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getOwnerStore() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var ownerid = pref.getString("ownerid");
  var response = await http.get(Uri.parse('${apidomain}store/$ownerid'));
  var jsonData = jsonDecode(response.body);
  pref.setString("storeid", jsonData[0]["type"]);
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

Future getStoreServices() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var storeid = pref.getString("storeid");
  var response = await http.get(Uri.parse('${apidomain}service/get/$storeid'));
  var jsonData = jsonDecode(response.body);
  List<GetServiceModel> services = [];

  for (var u in jsonData) {
    GetServiceModel service = GetServiceModel(
      u["_id"],
      u["name"],
      u["description"],
      u["price"],
      u["ogprice"],
      u["img"],
      u["storeid"],
      u["ownerid"],
      u["duration"],
      u["start"],
      u["end"],
      u["storename"],
      u["id"],
    );
    // print("service");
    services.add(service);
  }
  // print(services);
  return services;
}

Future getSingleStoreServices(var storeid) async {
  var response = await http.get(Uri.parse('${apidomain}service/get/$storeid'));
  var jsonData = jsonDecode(response.body);
  List<GetServiceModel> services = [];

  for (var u in jsonData) {
    GetServiceModel service = GetServiceModel(
      u["_id"],
      u["name"],
      u["description"],
      u["price"],
      u["ogprice"],
      u["img"],
      u["storeid"],
      u["ownerid"],
      u["duration"],
      u["start"],
      u["end"],
      u["storename"],
      u["id"],
    );
    services.add(service);
  }
  return services;
}

Future getSingleServiceDetails(var serviceid) async {
  var response =
      await http.get(Uri.parse('${apidomain}service/getservice/$serviceid'));
  var jsonData = jsonDecode(response.body);
  print(jsonData);
  List<GetServiceModel> services = [];

  for (var u in jsonData) {
    GetServiceModel service = GetServiceModel(
      u["_id"],
      u["name"],
      u["description"],
      u["price"],
      u["ogprice"],
      u["img"],
      u["storeid"],
      u["ownerid"],
      u["duration"],
      u["start"],
      u["end"],
      u["storename"],
      u["id"],
    );
    services.add(service);
  }
  print(services);
  return services;
}

Future deleteService(var serviceid) async {
  var response =
      await http.get(Uri.parse('${apidomain}service/del/$serviceid'));
  return true;
}

Future getStoreServiceBooking() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var storeid = pref.getString("storeid");
  // print(storeid);
  var response =
      await http.get(Uri.parse('${apidomain}booking/view/store/$storeid'));
  var jsonData = jsonDecode(response.body);
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
  // print("bookings");
  // print(bookings);
  return bookings;
}

Future getOwnerOrders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  var storeid = pref.getString("storeid");

  var response =
      await http.get(Uri.parse('${apidomain}order/view/store/$storeid'));
  var jsonData = jsonDecode(response.body);
  // print(jsonData);

  List<GetOrderModel> orders = [];
  for (var u in jsonData) {
    GetOrderModel order = GetOrderModel(
      u["_id"],
      u["start"],
      u["end"],
      u["storeid"],
      u["serviceid"],
      u["userid"],
      u["price"],
      u["date"],
      u["servicename"],
      u["storename"],
      u["status"],
      u["orderid"],
    );
    orders.add(order);
  }
  // print(orders);
  return orders;
}

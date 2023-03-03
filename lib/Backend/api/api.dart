import 'package:http/http.dart' as http;
import 'package:outq/Backend/models/owner_models.dart';
import 'dart:convert';
import 'package:outq/Backend/models/user_models.dart';

// {"name":"govind","pswd":"1234"}

Future getUsers() async {
  var response =
      await http.get(Uri.parse('http://192.168.137.1:3001/test/api/reg'));
  var jsonData = jsonDecode(response.body);

  List<Users> users = [];

  for (var u in jsonData) {
    Users user = Users(u["name"], u["pswd"]);
    users.add(user);
  }
  return users;
}

Future getOwnerId(var response) async {
  var jsonData = jsonDecode(response.body);

  List<idModel> ids = [];

  for (var u in jsonData) {
    idModel id = idModel(u["id"]);
    ids.add(id);
  }
  return ids;
}

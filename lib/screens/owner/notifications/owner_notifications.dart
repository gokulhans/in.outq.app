import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:outq/screens/owner/service/edit/edit_service.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerNotifications extends StatefulWidget {
  const OwnerNotifications({super.key});

  @override
  State<OwnerNotifications> createState() => _OwnerNotificationsState();
}

class _OwnerNotificationsState extends State<OwnerNotifications> {
  var storeid;
  late Future<http.Response> _future;
  void onload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    storeid = pref.getString("storeid");
    setState(() {
      _future =
          http.get(Uri.parse('${apidomain}notification/create/s/$storeid'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OwnerAppBarWithBack(
          title: "Notifications",
        ),
      ),
      body: Container(
        color: ColorConstants.appbgclr,
        child: FutureBuilder<http.Response>(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data!.body);
              print(data);
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: const Icon(
                                Icons.notifications,
                                size: 30,
                                color: Colors.blue,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[i]["title"],
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    data[i]["message"],
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasData) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: PlaceholderLong());
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';

class OwnerNotifications extends StatelessWidget {
  const OwnerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OwnerAppBarWithBack(
          title: "Notifications",
        ),
      ),
      body: Center(
        child: Text("Owner Notifications"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerSingleBookingInfoPage extends StatefulWidget {
  const OwnerSingleBookingInfoPage({super.key});

  @override
  State<OwnerSingleBookingInfoPage> createState() =>
      _OwnerSingleBookingInfoPageState();
}

class _OwnerSingleBookingInfoPageState
    extends State<OwnerSingleBookingInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OwnerAppBarWithBack(
          title: "Appoinment Details",
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/userImage.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Hero(
                    tag: 'userProfile',
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'johndoe@example.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            addVerticalSpace(20),
          ],
        ),
      ),
    );
  }
}

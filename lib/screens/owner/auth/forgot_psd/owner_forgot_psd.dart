import 'dart:math';
import 'package:flutter/material.dart';
import 'package:outq/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/sizes.dart';
import 'package:outq/utils/widget_functions.dart';

class OwnerForgotPsdPage extends StatefulWidget {
  const OwnerForgotPsdPage({super.key});

  @override
  State<OwnerForgotPsdPage> createState() => _OwnerForgotPsdPageState();
}

class _OwnerForgotPsdPageState extends State<OwnerForgotPsdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: OwnerAppBarWithBack(
          title: "",
        ),
      ),
      floatingActionButton: Container(
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
            child: Text(
          "Continue",
          style: Theme.of(context).textTheme.headline6,
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forgot Password?',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      'Select which contact details should we use to reset your password.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(20),
              Container(
                width: 350,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x115A6CEA),
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                      blurRadius: 50,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: const Icon(
                            Icons.message,
                            color: Colors.green,
                            size: 42,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'View SMS',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              '+919876451230',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(20),
              Container(
                width: 350,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x115A6CEA),
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                      blurRadius: 50,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: const Icon(
                            Icons.mail,
                            color: Colors.green,
                            size: 42,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'View Email',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'gmail@gmail.com',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

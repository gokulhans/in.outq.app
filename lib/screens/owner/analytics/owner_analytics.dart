import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/components/placeholders/placeholder.dart';
import 'package:outq/screens/owner/analytics/appoinment_analytics.dart';
import 'package:outq/screens/owner/analytics/customers_analytics.dart';
import 'package:outq/screens/owner/analytics/employee_analytics.dart';
import 'package:outq/screens/owner/analytics/followers_analytics.dart';
import 'package:outq/screens/owner/analytics/profile_view_analytics.dart';
import 'package:outq/screens/owner/analytics/service_view_analytics.dart';
import 'package:outq/screens/owner/analytics/service_wise_analytics.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OwnerStoreAnalyticsPage extends StatelessWidget {
  const OwnerStoreAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appbgclr,
      body: ChartDashBoard(),
    );
  }
}

class ChartDashBoard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartDashBoard({Key? key}) : super(key: key);

  @override
  ChartDashBoardState createState() => ChartDashBoardState();
}

class ChartDashBoardState extends State<ChartDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpace(20),
            Text('Shop Analytics',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: ColorConstants.textclrw)),
            addVerticalSpace(20),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => ServiceWiseAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Wise Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => ProfileViewAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop View Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => FollowersAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Followers Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => AppoinmentAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Appoinment Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => CustomersAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customers Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => EmployeeAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Employee Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.appbgclr2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => Get.to(() => ServiceViewAnalytics()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Click Analytics",
                      style: GoogleFonts.montserrat(
                        color: ColorConstants.textclr,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHorizontalSpace(15),
                    Text(
                      "view",
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 16,
                        // height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}

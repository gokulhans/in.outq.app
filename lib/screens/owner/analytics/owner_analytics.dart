import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/utils/widget_functions.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class OwnerStoreAnalyticsPage extends StatelessWidget {
  const OwnerStoreAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today Appoinments',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 14,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(10),
                Text(
                  '13',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF09041B),
                    fontSize: 32,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            addVerticalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YesterDay Appoinments',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 14,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(10),
                Text(
                  '10',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF09041B),
                    fontSize: 32,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            addVerticalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Growth',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 14,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(10),
                Text(
                  '30 % +',
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 32,
                    // height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //Initialize the chart widget
            // Expanded(
            //   flex: 3,
            //   child: SfCartesianChart(
            //     primaryXAxis: CategoryAxis(),
            //     // Chart title
            //     title: ChartTitle(text: 'Last Month Total Sales'),
            //     // Enable legend
            //     legend: Legend(isVisible: true),
            //     // Enable tooltip
            //     tooltipBehavior: TooltipBehavior(enable: true),
            //     series: <ChartSeries<_SalesData, String>>[
            //       LineSeries<_SalesData, String>(
            //           dataSource: data,
            //           xValueMapper: (_SalesData sales, _) => sales.year,
            //           yValueMapper: (_SalesData sales, _) => sales.sales,
            //           name: 'Sales',
            //           // Enable data label
            //           dataLabelSettings: DataLabelSettings(isVisible: true))
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 2,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     //Initialize the spark charts widget
            //     child: SfSparkLineChart.custom(
            //       //Enable the trackball
            //       trackball: SparkChartTrackball(
            //           activationMode: SparkChartActivationMode.tap),
            //       //Enable marker
            //       marker: SparkChartMarker(
            //           displayMode: SparkChartMarkerDisplayMode.all),
            //       //Enable data label
            //       labelDisplayMode: SparkChartLabelDisplayMode.all,
            //       xValueMapper: (int index) => data[index].year,
            //       yValueMapper: (int index) => data[index].sales,
            //       dataCount: 5,
            //     ),
            //   ),
            // )
          ]),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

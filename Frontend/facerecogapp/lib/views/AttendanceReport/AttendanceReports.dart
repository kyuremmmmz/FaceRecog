import 'dart:convert';
import 'dart:typed_data';

import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/utils/AdaptiveFontSize.dart';
import 'package:facerecogapp/widgets/NavigationDrawer/Drawers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Attendancereports extends StatefulWidget {
  const Attendancereports({super.key});

  @override
  State<Attendancereports> createState() => _AttendancereportsState();
}

class _AttendancereportsState extends State<Attendancereports> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> monthlyData = [
    {'month': 'January', 'attended': 15, 'total': 20, 'year': 2024},
    {'month': 'February', 'attended': 18, 'total': 20, 'year': 2024},
    {'month': 'March', 'attended': 14, 'total': 20, 'year': 2024},
    {'month': 'April', 'attended': 17, 'total': 20, 'year': 2024},
    {'month': 'May', 'attended': 19, 'total': 20, 'year': 2024},
    {'month': 'June', 'attended': 20, 'total': 20, 'year': 2024},
    {'month': 'July', 'attended': 16, 'total': 20, 'year': 2024},
    {'month': 'August', 'attended': 18, 'total': 20, 'year': 2024},
    {'month': 'September', 'attended': 15, 'total': 20, 'year': 2024},
    {'month': 'October', 'attended': 20, 'total': 20, 'year': 2024},
    {'month': 'November', 'attended': 18, 'total': 20, 'year': 2024},
    {'month': 'December', 'attended': 19, 'total': 20, 'year': 2024},
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authcontroller>(context);
    Uint8List? image;
    String? base64 = provider.user?.imagePath;

    try {
      if (base64 != null && base64.isNotEmpty) {
        String clean = base64.replaceFirst('data:image/jpeg;base64,', '');
        image = base64Decode(clean);
      }
    } catch (e) {
      print('Error decoding image: $e');
      image = null;
    }

    // Prepare data for charts
    List<FlSpot> lineChartData = [];
    List<BarChartGroupData> barChartData = [];

    for (int i = 0; i < monthlyData.length; i++) {
      lineChartData
          .add(FlSpot(i.toDouble(), monthlyData[i]['attended'].toDouble()));
      barChartData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: monthlyData[i]['attended'].toDouble(),
              color: Colors.blue,
              width: 20,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: image != null ? MemoryImage(image) : null,
            ),
            onTap: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          )
        ],
      ),
      endDrawer: CustomDrawer(
        username: provider.user?.email,
        name: provider.user?.firstName,
        profilePicture: image,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              image != null && image.isNotEmpty
                  ? Center(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: MemoryImage(image),
                                  ),
                                  const SizedBox(width: 13),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${provider.user?.firstName} ${provider.user?.lastName}',
                                        style: TextStyle(
                                          fontSize:
                                              AdaptiveFontSize.getFontSize(
                                                  context, 12),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        '${provider.user?.email}',
                                        style: TextStyle(
                                          fontSize:
                                              AdaptiveFontSize.getFontSize(
                                                  context, 9),
                                          color: const Color.fromARGB(
                                              255, 96, 196, 209),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
              Text(
                'Attendance Reports (${monthlyData.first['year']})',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AdaptiveFontSize.getFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Monthly Attendance (Bar Chart)',
                      style: TextStyle(
                        fontSize: AdaptiveFontSize.getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    monthlyData[value.toInt()]['month']
                                        .substring(0, 3),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) => Text(
                                  '${value.toInt()}',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: barChartData,
                          gridData: FlGridData(show: true),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Attendance Trend (Line Chart)',
                      style: TextStyle(
                        fontSize: AdaptiveFontSize.getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: lineChartData,
                              isCurved: true,
                              color: Colors.green,
                              barWidth: 3,
                              isStrokeCapRound: true,
                            ),
                          ],
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    monthlyData[value.toInt()]['month']
                                        .substring(0, 3),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) => Text(
                                  '${value.toInt()}',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: true),
                        ),
                      ),
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

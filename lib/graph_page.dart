// ignore_for_file: prefer_const_constructors

import 'package:envidual_coding_challenge/db/levels_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'model/level.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  late List<Level> levels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05, top: 30),
          child: Row(
            children: [
              category("Puls"),
              category("Watt"),
              category("Level"),
              category("Geschwindigkeit"),
              category("Umdrehungen")
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        graph(),
        Padding(
          padding: EdgeInsets.only(
            left: 50,
          ),
          child: Row(
            children: [
              insights("9", "Durchschnitt", null),
              SizedBox(
                width: 40,
              ),
              insights("12", "Maximum", Icons.arrow_circle_up_rounded)
            ],
          ),
        )
      ],
    );
  }

  Widget insights(String value, String name, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FittedBox(
              child: icon == null
                  ? SvgPicture.asset(
                      "assets/null.svg",
                      width: 25,
                      height: 25,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      icon,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
            Text(
              " $name",
              style: TextStyle(color: Color(0xFFbdbec0), fontSize: 14),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              "  Level",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        )
      ],
    );
  }

  Widget category(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.height * 0.045,
          decoration: BoxDecoration(
              color: name == "Level"
                  ? Theme.of(context).primaryColor
                  : const Color(0xff323643),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: FittedBox(
              child: Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )),
    );
  }

  Widget graph() {
    return FutureBuilder<List<Level>>(
        future: LevelsDatabase.instance.readAll(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SpinKitCircle(
                color: Theme.of(context).primaryColor,
                size: 30,
              );
            default:
              //error handling
              if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                    child: Text(
                  "Error occured. Try to reload.",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ));
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 10, bottom: 10),
                    child: LineChart(LineChartData(
                        gridData: FlGridData(
                            show: true,
                            horizontalInterval: 4,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color(0xFF707070).withOpacity(0.2),
                                strokeWidth: 1,
                              );
                            }),
                        lineTouchData: LineTouchData(
                          enabled: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 8,
                              getTitlesWidget: leftTitleWidgets,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        minX: 0,
                        maxX: 29,
                        minY: 0,
                        maxY: 24,
                        lineBarsData: [
                          LineChartBarData(
                              //convert the level to flspot
                              spots: snapshot.data!
                                  .map((level) => FlSpot(level.time.toDouble(),
                                      level.level.toDouble()))
                                  .toList(),
                              isCurved: true,
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF1DB954).withOpacity(0.2),
                                    Color(0xFF1DB954).withOpacity(0.15),
                                    Color(0xFF1DB954).withOpacity(0.001)
                                  ],
                                ),
                              ),
                              dotData: FlDotData(
                                show: false,
                              ),
                              color: const Color(0xFF1DB954))
                        ])),
                  ),
                );
              }
          }
        }));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFFbdbec0),
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    return Text(
      value.toInt().toString(),
      style: style,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * 0.43,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 70, 60, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Workout - Zusammenfassung",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Watt - Programm - 110 Watt - 5 min.",
                      style: TextStyle(
                          color: Color(0xff52dce6),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.close_rounded,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: const TabBar(
                  indicatorColor: Color(0xff6af6ff),
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        'ZUSAMMENFASSUNG',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'DETAILS',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ])),
          Expanded(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconAndInfo(Icons.route, "1.35", "km"),
                          iconAndInfo(Icons.timer_outlined, "3", "Minuten"),
                          iconAndInfo(
                              Icons.local_fire_department, "28.0", "kcal")
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          showRecord("94", "RPM", "Neuer Umdrehungen-Rekord!"),
                          const SizedBox(
                            height: 14,
                          ),
                          showRecord(
                              "94", "km/h", "Neuer Geschwindigkeits-Rekord!")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //separte widget for the icon and the corresponging value
  Widget iconAndInfo(IconData icon, String info, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FittedBox(
            child: Icon(
              icon,
              color: const Color(0xff6af6ff),
              size: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: FittedBox(
            child: RichText(
                text: TextSpan(
                    text: "$info ",
                    style: const TextStyle(fontSize: 45),
                    children: [
                  TextSpan(
                      text: unit,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xffb8d2d8)))
                ])),
          ),
        )
      ],
    );
  }

  //the widget shows the record
  Widget showRecord(String value, String unit, String description) {
    return Expanded(
      child: Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff1f9095)),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: SvgPicture.asset(
                  "assets/trophy.svg",
                  color: const Color(0xff6fcf97),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Text(
                  "$value $unit",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xffb8d2d8)),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

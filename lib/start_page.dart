import 'package:envidual_coding_challenge/graph_page.dart';
import 'package:envidual_coding_challenge/info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff20232f),
        body: SingleChildScrollView(
          child: Column(
            children: const [InfoPage(), GraphPage()],
          ),
        ),
      ),
    );
  }
}

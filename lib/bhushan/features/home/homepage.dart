import 'package:flutter/material.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/presentation/screen/dynamic_form_page.dart';
import 'package:mobile_security/bhushan/features/rd_calculator/rdCalculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(width: 0),
          title: Text('Home Page'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [Tab(text: 'RD Calculator'), Tab(text: 'Dynamic Form')],
          ),
        ),
        body: TabBarView(children: [RDCalculatorScreen(), DynamicFormPage()]),
      ),
    );
  }
}

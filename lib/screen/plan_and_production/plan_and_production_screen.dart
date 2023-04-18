import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/plan/plan_screen.dart';
import 'package:sartex/screen/production/production_widget.dart';

class PlanAndProductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.vertical, child: Column(
      children: [
        PlanScreen(),
        const SizedBox(width: 30),
        //ProductionWidget()
      ],
    ));
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/screen/plan/plan_bloc.dart';
import 'package:sartex/screen/plan/plan_screen.dart';
import 'package:sartex/screen/plan_and_production/pp_bloc.dart';
import 'package:sartex/screen/plan_and_production/pp_model.dart';
import 'package:sartex/screen/production/production_widget.dart';
import 'package:sartex/utils/translator.dart';

class PlanAndProductionScreen extends App {
  PlanAndProductionScreen({super.key}) : super(title: L.tr('Production'), model: PPModel());

  @override
  Widget body(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PPBloc>(create: (_) => PPBloc(PPIdle())),
          BlocProvider<PlanBloc>(
              create: (_) =>
              PlanBloc(PlanSRefresh(null))..add(PlanERefresh(null)))
        ],
        child: BlocBuilder<PPBloc, PPState>(
            buildWhen: (previouse, current) => current is PSRefresh,
            builder: (context, state) {
              return Column(
                children: [
                  PlanScreen(),
                  const SizedBox(width: 10),
                  ProductionWidget(line: '')
                ],
              );
            }));
  }
}

import 'package:fitter_fit/Common_Widgets/drawer_widget.dart';
import 'package:fitter_fit/View/Programme_view/new_workout_button.dart';
import 'package:flutter/material.dart';

class ProgrammeView extends StatefulWidget {
  @override
  _ProgrammeViewState createState() => _ProgrammeViewState();
}

class _ProgrammeViewState extends State<ProgrammeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      floatingActionButton: newWorkoutButton(context),
      body: Container(),
    );
  }
}

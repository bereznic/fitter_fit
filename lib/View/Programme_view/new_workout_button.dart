import 'package:fitter_fit/Common_Widgets/invite_dialog.dart';
import 'package:fitter_fit/View/Programme_view/new_workout_dialog.dart';
import 'package:flutter/material.dart';

Widget newWorkoutButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () async {
      showDialog(
        context: context,
        builder: (_) => NewWorkoutDialog(),
      );
    },
    backgroundColor: Colors.green,
    child: Icon(Icons.add),
  );
}

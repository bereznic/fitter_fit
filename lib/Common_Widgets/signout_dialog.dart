import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sign out?"),
      content: Text("Confirm sign out."),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No")),
        FlatButton(
            onPressed: () {
              final authService =
                  Provider.of<FireBaseAuthService>(context, listen: false);
              Navigator.pop(context);
              authService.logout();
            },
            child: Text("Yes"))
      ],
    );
  }
}

import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeUser extends StatefulWidget {
  @override
  _WelcomeUserState createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {
  @override
  Widget build(BuildContext context) {
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    final authService =
        Provider.of<FireBaseAuthService>(context, listen: false);
    return FutureBuilder(
      future: authService.getCurrentUser(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasError)
          return Text(
            "Welcome",
            style: TextStyle(fontSize: height(context) * 0.03),
          );
        if (userSnapshot.connectionState == ConnectionState.waiting)
          return Container();
        return Column(
          children: [
            Text(
              "Welcome ${userSnapshot.data.name}",
              style: TextStyle(fontSize: height(context) * 0.03),
            ),
            if (userSnapshot.data.userType != trainer)
              RaisedButton(
                onPressed: () async {
                  await fireStoreService.makeTrainer(currentUserId);
                },
                child: Text("Upgrade to trainer!"),
              )
          ],
        );
      },
    );
  }
}

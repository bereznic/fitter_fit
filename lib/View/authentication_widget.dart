import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_fit/View/home_view.dart';
import 'package:fitter_fit/View/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireBaseUser = context.watch<User>();
    if (fireBaseUser != null) return HomeView();
    return LoginView();
  }
}

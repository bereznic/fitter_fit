import 'package:fitter_fit/View/Invitations_view/invitations_chooser_view.dart';
import 'package:fitter_fit/View/authentication_widget.dart';
import 'package:fitter_fit/View/clients_view.dart';
import 'package:fitter_fit/View/home_view.dart';
import 'package:fitter_fit/View/login_view.dart';
import 'package:fitter_fit/View/register_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final String args = settings.arguments;

    switch (settings.name) {
      case 'AuthWidget':
        return MaterialPageRoute(builder: (_) => AuthWidget());
      case 'LoginView':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'RegisterView':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case 'HomeView':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'ClientsView':
        return MaterialPageRoute(builder: (_) => ClientsView());
      case 'InvitationsView':
        return MaterialPageRoute(builder: (_) => InvitationsChooserView());
    }
  }
}

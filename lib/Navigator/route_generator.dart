import 'package:fitter_fit/View/Invitations_view/invitations_chooser_view.dart';
import 'package:fitter_fit/View/Authentication_view/authentication_widget.dart';
import 'package:fitter_fit/View/Clients_view/clients_view.dart';
import 'package:fitter_fit/View/Home_view/home_view.dart';
import 'package:fitter_fit/View/Authentication_view/login_view.dart';
import 'package:fitter_fit/View/Authentication_view/register_view.dart';
import 'package:fitter_fit/View/Clients_view/single_client_view.dart';
import 'package:fitter_fit/View/Programme_view/programe_view.dart';
import 'package:fitter_fit/View/Schedule_view/schedule_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  // ignore: missing_return
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
      case 'ScheduleView':
        return MaterialPageRoute(builder: (_) => ScheduleView());
      case 'ProgrammeView':
        return MaterialPageRoute(builder: (_) => ProgrammeView());
      case 'SingleClientView':
        return MaterialPageRoute(builder: (_) => SingleClientView());
    }
  }
}

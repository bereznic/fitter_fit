import 'package:firebase_core/firebase_core.dart';
import 'package:fitter_fit/Services/firebase_auth_service.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/Services/invitations_service.dart';
import 'package:fitter_fit/Services/Schedule_service/schedule_service.dart';
import 'package:fitter_fit/Navigator/route_generator.dart';
import 'package:fitter_fit/Services/Schedule_service/multi_select_clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FireBaseAuthService>(
          create: (_) => FireBaseAuthService(),
        ),
        Provider<FireStoreService>(
          create: (_) => FireStoreService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FireBaseAuthService>().onAuthStateChanged,
        ),
        Provider<InvitationsService>(
          create: (_) => InvitationsService(),
        ),
        Provider<ScheduleService>(
          create: (_) => ScheduleService(),
        ),
        ChangeNotifierProvider(
          create: (_) => MultiSelectClients(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'AuthWidget',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

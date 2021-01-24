import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsamAssignment/services/connectivity_service.dart';
import 'package:tatsamAssignment/viewmodels/country_view_model.dart';
import 'package:tatsamAssignment/views/home_page.dart';

ConnectivityResult connectivity;
StreamSubscription subscription;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountryProvider>(
      create: (_) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.orange,
            appBarTheme: AppBarTheme(color: Colors.orange, elevation: 0)),
        home: StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionController.stream,
            child: HomePage()),
      ),
    );
  }
}

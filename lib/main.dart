import 'package:flutter/material.dart';
import 'package:bbts_flutter/pages/Calendars.dart';
import 'package:bbts_flutter/pages/eventos/Events.dart';
import 'package:bbts_flutter/pages/ListEvents.dart';
import 'package:bbts_flutter/pages/eventos/Event.dart';
import 'package:bbts_flutter/pages/ListEmployees.dart';
import 'package:bbts_flutter/pages/funcionario/Employer.dart';
import 'package:bbts_flutter/pages/funcionario/Employees.dart';
import 'package:bbts_flutter/pages/login/Login.dart';

import 'package:bbts_flutter/pages/Menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{
        "/Menu": (BuildContext context) => Menu(),
        "/ListEvents": (BuildContext context) => ListEvents(),
        "/Event": (BuildContext context) => Event(),
        "/ListEmployees": (BuildContext context) => ListEmployees(),
        "/Employer": (BuildContext context) => Employer(),
        "/Calendars": (BuildContext context) =>
            Calendars(),
            // Calendars(title: 'Flutter Calendar Carousel Example'),
        "/InsertEmployerPessoal": (BuildContext context) =>
            InsertEmployerPessoal(),
        "/InsertEmployerCorporativo": (BuildContext context) =>
            InsertEmployerCorporativo(),
        "/InsertEmployer": (BuildContext context) => InsertEmployer(),
        "/InsertEvents": (BuildContext context) => InsertEvent(),
        "/Login": (BuildContext context) => Login(),
      },
    );
  }
}

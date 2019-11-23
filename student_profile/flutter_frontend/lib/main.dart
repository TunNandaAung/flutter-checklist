import 'package:flutter/material.dart';
import 'package:flutter_frontend/profile_page.dart';
import 'data/profile_api_service.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => ProfileApiService.create(),
      dispose: (_, ProfileApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Student Profile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProfilePage(),
      ),
    );
  }
}

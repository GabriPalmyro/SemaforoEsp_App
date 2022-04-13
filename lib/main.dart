import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';

import 'App/view/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //!COMMON
        ChangeNotifierProvider(
          create: (_) => ThemeConfigs(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: "App Semaforo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

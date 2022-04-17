import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';
import 'package:semaforo_app/App/view/listaMultas/lista_multas.dart';

import 'App/controller/firebase_messaging_controller.dart';
import 'App/model/multa.dart';
import 'App/model/styles.dart';
import 'App/view/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //!COMMON
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => PushNotificationManager(),
          lazy: false,
        )
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
            title: "Semaforo ESP",
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            // ThemeData(
            //   appBarTheme: const AppBarTheme(
            //     elevation: 0,
            //   ),
            //   scaffoldBackgroundColor: Colors.white,
            //   visualDensity: VisualDensity.adaptivePlatformDensity,
            // ),
            initialRoute: '/home',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/home':
                  return MaterialPageRoute(builder: (_) => HomeScreen());
                case '/lista-multas':
                  return MaterialPageRoute(
                      builder: (_) => ListaMultasScreen(
                            novasMultas: settings.arguments as List<Multa>,
                          ));
                default:
                  return null;
              }
            });
      }),
    );
  }
}

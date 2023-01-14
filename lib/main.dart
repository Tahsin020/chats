
import 'package:chats/views/home_view.dart';
import 'package:chats/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';


//global object for accessing device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    await Firebase.initializeApp(); 
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IŞIK CHAT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
          backgroundColor: Colors.transparent,
        ),
        primaryColor: Colors.black,
        errorColor: Colors.red,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.pink,
          onPrimary: Colors.white,
          secondary: Colors.cyan,
          onSecondary: Colors.grey,
          error: Colors.red,
          onError: Colors.purple,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.yellow,
          onSurface: Colors.green
        ),
        ),
        home: const SplashView());
  }
}


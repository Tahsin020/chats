import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../api/api.dart';
import 'home_view.dart';
import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
           SystemUiOverlayStyle(systemNavigationBarColor: Theme.of(context).colorScheme.onPrimary, statusBarColor: Theme.of(context).colorScheme.onPrimary));
      if (API.auth.currentUser != null) {
        log('\nUser: ${API.auth.currentUser}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginView()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: mq.height * .15, right: mq.width * .25, width: mq.width * .5, child: Image.asset('images/icon.png')),
      ]),
    );
  }
}

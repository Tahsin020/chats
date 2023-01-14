import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../main.dart';
import '../api/api.dart';
import '../helper/dialog.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await API.userExists())) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
        } else {
          await API.createUser().then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await API.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Internet Bağlantını kontrol et.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'IŞIK CHAT',
          style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        _loginImage(),
        _loginButton(),
      ]),
    );
  }

  AnimatedPositioned _loginImage() {
    return AnimatedPositioned(
        top: mq.height * .15,
        right: _isAnimate ? mq.width * .25 : -mq.width * .5,
        width: mq.width * .5,
        duration: const Duration(seconds: 1),
        child: Image.asset('images/icon.png'));
  }

  Positioned _loginButton() {
    return Positioned(
        bottom: mq.height * .15,
        left: mq.width * .05,
        width: mq.width * .9,
        height: mq.height * .06,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, shape: const StadiumBorder(), elevation: 1),
            onPressed: () {
              _handleGoogleBtnClick();
            },
            icon: Image.asset('images/google.png', height: mq.height * .03),
            label: RichText(
              text: TextSpan(
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                  children: const [
                    TextSpan(text: 'Google', style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(text: ' ile giriş yap '),
                  ]),
            )));
  }
}

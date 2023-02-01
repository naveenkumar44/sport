import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport/c.home.dart';
import 'package:sport/p.home.dart';
import 'package:sport/spalsh.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((
        context,
        FirebaseAuth,
      ) {
        if (FirebaseAuth.hasData) {
          return const PartiWel();
        } else if (FirebaseAuth.hasData) {
          return const CreaterHome();
        } else {
          return const SplashScreen2();
        }
      }),
    ));
  }
}

class Auth1 extends StatefulWidget {
  const Auth1({Key? key}) : super(key: key);

  @override
  State<Auth1> createState() => _Auth1State();
}

class _Auth1State extends State<Auth1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((
        context,
        snapshot1,
      ) {
        if (snapshot1.hasData) {
          return const CreaterHome();
        } else {
          return const SplashScreen2();
        }
      }),
    ));
  }
}

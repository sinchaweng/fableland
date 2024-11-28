import 'package:fableland_application/fable001.dart';
import 'package:fableland_application/fable002.dart';
import 'package:fableland_application/fable003.dart';
import 'package:fableland_application/fable004.dart';
import 'package:fableland_application/fable005.dart';
import 'package:fableland_application/fable01.dart';
import 'package:fableland_application/fable02.dart';
import 'package:fableland_application/fable04.dart';
import 'package:fableland_application/fable05.dart';
import 'package:fableland_application/fable5.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'menu.dart';
import 'home.dart';
import 'fable1.dart';
import 'fable2.dart';
import 'fable3.dart';
import 'fable4.dart';
import 'fable5.dart';
import 'fable01.dart';
import 'fable02.dart';
import 'fable03.dart';
import 'fable04.dart';
import 'fable05.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '....',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(239, 245, 188, 2)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WaitScreen(),
        '/menu': (context) => menu(),
        '/home': (context) => home(),
        '/fable1': (context) => fable01(),
        '/fable2': (context) => fable02(),
        '/fable3': (context) => fable03(),
        '/fable4': (context) => fable04(),
        '/fable5': (context) => fable05(),
        '/fable01': (context) => fable001(),
        '/fable02': (context) => fable002(),
        '/fable03': (context) => fable003(),
        '/fable04': (context) => fable004(),
        '/fable05': (context) => fable005(),
        '/fable001': (context) => fable0001(),
        '/fable002': (context) => fable0002(),
        '/fable003': (context) => fable0003(),
        '/fable004': (context) => fable0004(),
        '/fable005': (context) => fable0005(),
      },
    );
  }
}

class WaitScreen extends StatefulWidget {
  @override
  State<WaitScreen> createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, '/menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E4FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/logo.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              '',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

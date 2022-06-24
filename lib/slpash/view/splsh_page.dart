import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration(seconds: 3),()=>Navigator.of(context).pushReplacementNamed())
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

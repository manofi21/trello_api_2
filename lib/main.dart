import 'package:flutter/material.dart';

import 'homes.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Homes(),
      ),
    );
  }
}
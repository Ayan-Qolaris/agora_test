import 'package:agora_test/pages/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agora",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const IndexPage(),
    );
  }
}

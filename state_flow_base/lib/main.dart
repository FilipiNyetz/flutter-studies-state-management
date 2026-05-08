import 'package:flutter/material.dart';
import 'package:state_flow_base/state_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Semáforos de estado",
      home: const StateFlowApp(),
    );
  }
}

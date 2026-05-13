import 'package:flutter/material.dart';
import 'package:mini_cart_setstate/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const CartScreen(),
    );
  }
}

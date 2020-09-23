import 'package:calculadora/calculadora_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => CalculadoraView(),
    },
  ));
}

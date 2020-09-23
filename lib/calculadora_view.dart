import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculadoraView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.red),
      home: TelaCalculadora(),
    );
  }
}

class TelaCalculadora extends StatefulWidget {
  @override
  _TelaCalculadoraState createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  String equacao = "0";
  String resultado = "0";
  String expressao = "";
  double equacaoFontSize = 38;
  double resultadoFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equacao = "0";
        resultado = "0";
        equacaoFontSize = 38;
        resultadoFontSize = 48;
      } else if (buttonText == "⌫") {
        equacaoFontSize = 38;
        resultadoFontSize = 48;
        equacao = equacao.substring(0, equacao.length - 1);
        if (equacao == "") {
          equacao = "0";
        }
      } else if (buttonText == "=") {
        equacaoFontSize = 38;
        resultadoFontSize = 48;

        expressao = equacao;
        expressao = expressao.replaceAll('×', '*');
        expressao = expressao.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expressao);
          ContextModel cm = ContextModel();
          resultado = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          resultado = "Erro";
        }
      } else {
        equacaoFontSize = 48;
        resultadoFontSize = 38;
        if (equacao == "0") {
          equacao = buttonText;
        } else {
          equacao = equacao + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color: Colors.black, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                equacao,
                style: TextStyle(fontSize: equacaoFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Text(
                resultado,
                style: TextStyle(fontSize: resultadoFontSize),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('⌫', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue)
                      ]),
                      TableRow(children: [
                        buildButton('7', 1, Colors.grey[300]),
                        buildButton('8', 1, Colors.grey[300]),
                        buildButton('9', 1, Colors.grey[300])
                      ]),
                      TableRow(children: [
                        buildButton('4', 1, Colors.grey[300]),
                        buildButton('5', 1, Colors.grey[300]),
                        buildButton('6', 1, Colors.grey[300])
                      ]),
                      TableRow(children: [
                        buildButton('1', 1, Colors.grey[300]),
                        buildButton('2', 1, Colors.grey[300]),
                        buildButton('3', 1, Colors.grey[300])
                      ]),
                      TableRow(children: [
                        buildButton('.', 1, Colors.grey[300]),
                        buildButton('0', 1, Colors.grey[300]),
                        buildButton('00', 1, Colors.grey[300])
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton('×', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('-', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('+', 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton('=', 2, Colors.redAccent),
                      ])
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}

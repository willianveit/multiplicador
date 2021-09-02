import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle _textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static final NumberFormat formatoDoReal =
      NumberFormat.simpleCurrency(locale: 'pt_BR');
  double _investimentoMensal = 0;
  int _anosInvestindo = 0;
  double _rentabilidadeAnual = 0;
  double _resultado = 0;
  double _valorInvestido = 0;

  atualizarResultado() {
    setState(() {
      _resultado = (_investimentoMensal *
              (pow(1 + (_rentabilidadeAnual / 12 / 100),
                      (_anosInvestindo * 12)) -
                  1)) /
          (_rentabilidadeAnual / 12 / 100);
    });
  }

  atualizarValorInvestido() {
    setState(() {
      _valorInvestido = _investimentoMensal * (_anosInvestindo * 12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            'Juros compostos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 36),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Investimento mensal', style: _textStyle),
                        Spacer(),
                        Text(
                          '${formatoDoReal.format(_investimentoMensal)}',
                          style: _textStyle,
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: _investimentoMensal,
                    min: 0,
                    max: 1000,
                    activeColor: Colors.green.shade700,
                    inactiveColor: Colors.green.shade100,
                    divisions: 20,
                    onChanged: (double value) {
                      setState(() {
                        _investimentoMensal = value;
                      });
                      atualizarResultado();
                      atualizarValorInvestido();
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Tempo investindo', style: _textStyle),
                        Spacer(),
                        Text(_anosInvestindo.toInt().toString() + ' anos',
                            style: _textStyle),
                      ],
                    ),
                  ),
                  Slider(
                    value: _anosInvestindo.toDouble(),
                    min: 0,
                    max: 50,
                    divisions: 25,
                    activeColor: Colors.green.shade700,
                    inactiveColor: Colors.green.shade100,
                    onChanged: (double value) {
                      setState(() {
                        _anosInvestindo = value.toInt();
                      });
                      atualizarResultado();
                      atualizarValorInvestido();
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Rentabilidade anual', style: _textStyle),
                        Spacer(),
                        Text(_rentabilidadeAnual.toInt().toString() + ' %',
                            style: _textStyle),
                      ],
                    ),
                  ),
                  Slider(
                    value: _rentabilidadeAnual,
                    min: 0,
                    max: 20,
                    divisions: 20,
                    activeColor: Colors.green.shade700,
                    inactiveColor: Colors.green.shade100,
                    onChanged: (double value) {
                      setState(() {
                        _rentabilidadeAnual = value;
                      });
                      atualizarResultado();
                      atualizarValorInvestido();
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Resultado', style: _textStyle),
                      Text('${formatoDoReal.format(_resultado)}',
                          style: _textStyle),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Valor investido',
                      ),
                      Text(
                        '${formatoDoReal.format(_valorInvestido)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:calculator/bmi/bmi_titles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class BmiForm extends StatefulWidget {
  @override
  _BmiFormState createState() => _BmiFormState();
}

class _BmiFormState extends State<BmiForm> {
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  bool show_outp = false;
  double result = 0;

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  String _validate(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter number';
    }
    return null;
  }

  Widget _inputHeight() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your height, cm',
          ),
          validator: _validate,
          controller: heightController,
        ));
  }

  Widget _inputWeight() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your weight, kg',
          ),
          validator: _validate,
          controller: weightController,
        ));
  }

  Widget _btn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            double weight = double.parse(weightController.text);
            double height = double.parse(heightController.text) / 100;
  
            setState(() {
              result = weight / pow(height, 2);
              show_outp = true;
            });
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget _output() {
    if (show_outp) {
      BmiTitles bmiTitles = BmiTitles(result);
      return Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Text(
            "Ваш индекс ${result.toStringAsFixed(2)}\n${bmiTitles.get_title()}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ));
    }
    return Container(child: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _inputHeight(),
              _inputWeight(),
              _btn(),
              _output()
            ],
          )
        ]));
  }
}

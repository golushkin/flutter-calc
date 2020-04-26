import 'package:flutter/material.dart';
import 'dart:math';
import './calories.dart';

class CaloriesForm extends StatefulWidget {
  @override
  _CaloriesFormState createState() => _CaloriesFormState();
}

class _CaloriesFormState extends State<CaloriesForm> {
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();

  SingingCharacter _character = SingingCharacter.male;
  bool show_outp = false;
  String result = "";
  String dropdownFormula = METHODS[0];
  String dropdownActivity = ACTIVITIES[0];

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  String _validate(value) {
    if (value.isEmpty) {
      return 'Введите текст';
    }
    if (int.tryParse(value) == null) {
      return 'Введите число';
    }
    if (int.parse(value) <= 0) {
      return 'Введите число больше 0';
    }
    return null;
  }

  Widget _inputHeight() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Введите ваш рост, см',
          ),
          validator: _validate,
          controller: heightController,
        ));
  }

  Widget _inputWeight() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Введите ваш вес, кг',
          ),
          validator: _validate,
          controller: weightController,
        ));
  }

  Widget _inputAge() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Введите ваш возвраст',
          ),
          validator: _validate,
          controller: ageController,
        ));
  }

  Widget _inputRadioBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Мужчина'),
            Radio(
              value: SingingCharacter.male,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Женщина'),
            Radio(
              value: SingingCharacter.female,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _dropDownItemsFormuls() {
    List<DropdownMenuItem<String>> arr1 = List();
    METHODS.forEach((item) {
      arr1.add(DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      ));
    });
    return arr1;
  }

  Widget _dropDownBtnFormuls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: DropdownButton<String>(
            value: dropdownFormula,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blueGrey,
            ),
            onChanged: (String newValue) {
              if (newValue == METHODS[1]) {
                this.dropdownActivity = null;
              }
              setState(() {
                dropdownFormula = newValue;
              });
            },
            items: _dropDownItemsFormuls(),
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> _dropDownItemsActivities() {
    List<DropdownMenuItem<String>> arr1 = List();
    ACTIVITIES.forEach((item) {
      arr1.add(DropdownMenuItem<String>(
          value: item,
          child: Container(
              width: 250.0,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ))));
    });
    return arr1;
  }

  Widget _dropDownBtnActivities() {
    if (this.dropdownFormula != METHODS[0]) {
      return SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: DropdownButton<String>(
            value: dropdownActivity,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blueGrey,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownActivity = newValue;
              });
            },
            items: _dropDownItemsActivities(),
          ),
        )
      ],
    );
  }

  Widget _btn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Calories calories = Calories(
                this._character,
                double.parse(this.heightController.text),
                double.parse(this.weightController.text),
                this.dropdownFormula,
                this.dropdownActivity,
                int.parse(this.ageController.text),
              );

              setState(() {
                result = calories.calculate();
                show_outp = true;
              });
            }
          },
          child: Text('Рассчитать'),
        ),
      ),
    );
  }

  Widget _output() {
    if (show_outp) {
      return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
              child: Text(
        this.result,
        style: TextStyle(fontSize: 18),
      )));
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          _inputHeight(),
          _inputWeight(),
          _inputAge(),
          _inputRadioBtn(),
          _dropDownBtnFormuls(),
          _dropDownBtnActivities(),
          _btn(),
          _output()
        ]));
  }
}

import 'package:flutter/material.dart';
import 'categorization_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController tbsaController = TextEditingController();
  TextEditingController fluidController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  String selectedPatientType = 'Adult';
  String selectedDropFactor = '15 drops = 1 mL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Input Page'),
        ),
        body: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                TextField(
                controller: weightController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Body Weight (kg)'),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text('Select Patient Type'),
                  SizedBox(width: 100.0),
                  DropdownButton<String>(
                    value: selectedPatientType,
                    items: ['Adult', 'Child']
                        .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPatientType = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: fluidController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Fluid Already Given (mL)'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: tbsaController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'TBSA (%)'),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: hoursController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Hours Since Burn'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      controller: minutesController,
                      keyboardType: TextInputType.phone,
                      decoration:
                      InputDecoration(labelText: 'Minutes Since Burn'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: selectedDropFactor,
                items: ['15 drops = 1 mL', '60 drops = 1 mL']
                    .map((factor) => DropdownMenuItem<String>(
                  value: factor,
                  child: Text(factor),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDropFactor = value!;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Drop Factor for IV Cannula Set'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
              onPressed: () {
          // Validation for Body Weight
          double bodyWeight =
          double.tryParse(weightController.text) ?? 0.0;
              if (bodyWeight <= 0) {
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Body Weight of the patient must be greater than zero!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
                );
                return; // Prevent further execution
              }

              // Validation for Fluid Already Given
              double fluidAlreadyGiven =
          double.tryParse(fluidController.text) ?? 0.0;
              if (fluidAlreadyGiven < 0) {
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Fluid Already Given must be greater than or equal to zero!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
                );
                return; // Prevent further execution
              }

              // Validation for TBSA%
              double tbsaPercentage =
          double.tryParse(tbsaController.text) ?? 0.0;
              if (tbsaPercentage < 0 || tbsaPercentage > 100) {
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('TBSA% cannot be less than zero or greater than 100!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
                );
                return; // Prevent further execution
              }

              double timeSinceBurn = double.parse(hoursController.text) +
          double.parse(minutesController.text) / 60;

              if (timeSinceBurn < 0) {
                showDialog(
            context: context,
            builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Error'),
              content: Text('Time cannot be negative.'),
              actions: <Widget>[
              TextButton(
              onPressed: () {
            Navigator.of(context).pop();
          },
                child: Text('OK'),
              ),
              ],
          );
            },
                );
                return; // Prevent further execution
              }

          int dropFactor =
          (selectedDropFactor == '15 drops = 1 mL') ? 15 : 60;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorizationPage(
                weight: bodyWeight,
                tbsa: tbsaPercentage,
                fluidGiven: fluidAlreadyGiven,
                selectedPatientType: selectedPatientType,
                timeSinceBurn: timeSinceBurn,
                dropFactor: dropFactor,
              ),
            ),
          );
              },
                child: Text('Calculate'),
              ),
                ],
              ),
          ),
        ),
    );
  }
}



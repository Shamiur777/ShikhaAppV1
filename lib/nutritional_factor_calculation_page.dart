import 'package:flutter/material.dart';

class NutritionalFactorCalculationPage extends StatefulWidget {
  @override
  _NutritionalFactorCalculationPageState createState() => _NutritionalFactorCalculationPageState();
}

class _NutritionalFactorCalculationPageState extends State<NutritionalFactorCalculationPage> {
  TextEditingController tbsaController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String selectedPatientType = 'Adult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutritional Factor Calculation Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: tbsaController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'TBSA%'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Body Weight (kg)'),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
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
                decoration: InputDecoration(labelText: 'Patient Type'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  calculateNutritionalFactor();
                },
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateNutritionalFactor() {
    double tbsa = double.tryParse(tbsaController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    // Validate TBSA%
    if (tbsa < 0 || tbsa > 100) {
      showAlertDialog('Error', 'TBSA% cannot be less than zero or greater than 100!');
      return;
    }

    // Validate Body Weight
    if (weight <= 0) {
      showAlertDialog('Error', 'Body Weight of the patient must be greater than zero!');
      return;
    }

    double requiredCalorieSupport;

    // Perform calculations based on conditions
    if (tbsa < 20) {
      showAlertDialog('Result', 'Patient may not need calorie support. Please use clinical judgement to proceed further.');
    } else {
      if (selectedPatientType == 'Adult') {
        requiredCalorieSupport = 25 * weight + (40 * tbsa);
      } else {
        requiredCalorieSupport = 60 * weight + (35 * tbsa);
      }

      showAlertDialog('Result', 'Required Calorie Support: ${requiredCalorieSupport.round()} kcal');
    }
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
  }
}

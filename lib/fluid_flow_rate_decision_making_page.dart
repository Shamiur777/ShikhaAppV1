import 'package:flutter/material.dart';
import 'home_page.dart';

class FluidFlowRateDecisionMakingPage extends StatefulWidget {
  @override
  _FluidFlowRateDecisionMakingPageState createState() =>
      _FluidFlowRateDecisionMakingPageState();
}

class _FluidFlowRateDecisionMakingPageState
    extends State<FluidFlowRateDecisionMakingPage> {
  String selectedUrineOutput = '0.5 – 1 mL/hour/kg';
  String selectedDropFactor = '15 drops = 1 mL';
  TextEditingController weightController = TextEditingController();
  TextEditingController urineOutputController = TextEditingController();
  TextEditingController previousFlowRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluid Flow Rate Decision Making'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: selectedUrineOutput,
                items: ['0.5 – 1 mL/hour/kg', '1 – 2 mL/hour/kg']
                    .map((output) => DropdownMenuItem<String>(
                  value: output,
                  child: Text(output),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUrineOutput = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Target Urine Output',
                ),
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
                  labelText: 'Drop Factor for IV Cannula Set',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Body Weight (kg)',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: urineOutputController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Urine Output (mL/hour)',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: previousFlowRateController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Previous Flow Rate (mL/hour)',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  calculateFlowRate();
                },
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateFlowRate() {
    // Validation for Body Weight
    double bodyWeight = double.tryParse(weightController.text) ?? 0.0;
    if (bodyWeight <= 0) {
      showErrorMessage('Body Weight of the patient must be greater than zero!');
      return;
    }

    // Validation for Urine Output
    double urineOutput = double.tryParse(urineOutputController.text) ?? 0.0;
    if (urineOutput < 0) {
      showErrorMessage('Urine Output of the patient must be greater than zero!');
      return;
    }

    // Validation for Previous Flow Rate
    double previousFlowRate =
        double.tryParse(previousFlowRateController.text) ?? 0.0;
    if (previousFlowRate < 0) {
      showErrorMessage('Previous Flow Rate must be greater than zero!');
      return;
    }

    double lowerLimit = selectedUrineOutput.startsWith('0.5') ? 0.5 : 1;
    double upperLimit = selectedUrineOutput.startsWith('0.5') ? 1 : 2;

    double newFlowRate;

    if (urineOutput < lowerLimit * bodyWeight) {
      newFlowRate = previousFlowRate * 4 / 3;
    } else if (urineOutput > upperLimit * bodyWeight) {
      newFlowRate = previousFlowRate * 2 / 3;
    } else {
      newFlowRate = previousFlowRate;
    }

    // Display the result
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(
              'New Flow Rate: ${newFlowRate.round()} mL/hour or ${(newFlowRate * getDropFactorValue(selectedDropFactor) / 60).round()} drops/minute'),
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

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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

  int getDropFactorValue(String factor) {
    return factor.startsWith('15') ? 15 : 60;
  }
}

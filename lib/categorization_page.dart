import 'package:flutter/material.dart';
import 'fluid_calculation_page.dart';

class CategorizationPage extends StatelessWidget {
  final double weight;
  final double tbsa;
  final String selectedPatientType;
  final double fluidGiven;
  final double timeSinceBurn;
  final int dropFactor;

  CategorizationPage({
    required this.weight,
    required this.tbsa,
    required this.selectedPatientType,
    required this.fluidGiven,
    required this.timeSinceBurn,
    required this.dropFactor,
  });

  String categorizePatient() {
    if ((selectedPatientType == 'Adult' && tbsa < 15) ||
        (selectedPatientType == 'Child' && tbsa < 10)) {
      return 'OUTPATIENT';
    } else if ((selectedPatientType == 'Adult' && tbsa >= 15 && tbsa <= 30) ||
        (selectedPatientType == 'Child' && tbsa >= 10 && tbsa <= 25)) {
      return 'INPATIENT FOR ROUTINE CARE';
    } else if ((selectedPatientType == 'Adult' && tbsa > 30 && tbsa <= 50) ||
        (selectedPatientType == 'Child' && tbsa > 25 && tbsa <= 50)) {
      return 'CRITICAL BUT SALVAGEABLE. MAY NEED ICU OR HDU';
    } else if (tbsa > 50 && tbsa < 70) {
      return 'CRITICAL BUT UNPREDICTABLE INCOME. MAY NEED HDU';
    } else if (tbsa >= 70) {
      return 'UNSALVAGEABLE, COMFORT CARE';
    } else {
      return 'Uncategorized';
    }
  }

  @override
  Widget build(BuildContext context) {
    String category = categorizePatient();
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Categorization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Category: $category',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (category == 'OUTPATIENT') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FluidCalculationPage(
                        tbsa: tbsa,
                        weight: weight,
                        fluidGiven: fluidGiven,
                        selectedPatientType: selectedPatientType,
                        dropFactor: dropFactor,
                        timeSinceBurn: timeSinceBurn,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FluidCalculationPage(
                        weight: weight,
                        tbsa: tbsa,
                        fluidGiven: fluidGiven,
                        selectedPatientType: selectedPatientType,
                        dropFactor: dropFactor,
                        timeSinceBurn: timeSinceBurn,
                      ),
                    ),
                  );
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'fluid_flow_rate_page.dart';
import 'home_page.dart';

class FluidCalculationPage extends StatelessWidget {
  final double weight;
  final double tbsa;
  final double fluidGiven;
  final String selectedPatientType;
  final int dropFactor;
  final double timeSinceBurn;

  FluidCalculationPage({
    required this.weight,
    required this.tbsa,
    required this.fluidGiven,
    required this.selectedPatientType,
    required this.dropFactor,
    required this.timeSinceBurn,
  });

  double fluidRequired = 0.0;
  @override
  Widget build(BuildContext context) {
    String result = calculateFluid();
    return Scaffold(
      appBar: AppBar(
        title: Text('Necessary Fluid Amount Calculation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (fluidRequired <= 0) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false
                  );
                }else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FluidFlowRatePage(
                            timeSinceBurn: timeSinceBurn,
                            dropFactor: dropFactor,
                            fluidRequired: fluidRequired,
                            selectedPatientType: selectedPatientType,
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

  String calculateFluid() {
    if ((tbsa <= 15 && selectedPatientType == 'Adult') ||
        (tbsa <= 10 && selectedPatientType == 'Child')) {
      return 'This patient may not need fluid resuscitation. Please use clinical judgment to proceed further.';
    } else if (tbsa > 15 && selectedPatientType == 'Adult') {
      fluidRequired = 4 * weight * tbsa - fluidGiven;
      if (fluidRequired <= 0) {
        return 'The necessary fluid is already given. Please use clinical judgment to proceed further.';
      } else {
        int fluid_required_Rounded = fluidRequired.round();
        return 'Total Fluid to be given = ${fluid_required_Rounded} mL';
      }
    } else if (tbsa > 10 && weight <= 10 && selectedPatientType == 'Child') {
      double maintenanceFluid = weight * 100;
      fluidRequired = 4 * weight * tbsa - fluidGiven;
      if (fluidRequired <= 0) {
        return 'The necessary fluid is already given. Please use clinical judgment to proceed further.';
      } else {
        int fluid_required_Rounded = fluidRequired.round();
        int maintenanceFluidRounded = maintenanceFluid.round();
        return 'Total Fluid to be given = ${fluid_required_Rounded} mL\nTotal Maintenance Fluid to be given = ${maintenanceFluidRounded} mL';
      }
    } else if (tbsa > 10 && weight > 10 && weight <= 20 && selectedPatientType == 'Child') {
      double maintenanceFluid = 1000 + (weight - 10) * 50;
      fluidRequired = 4 * weight * tbsa - fluidGiven;
      if (fluidRequired <= 0) {
        return 'The necessary fluid is already given. Please use clinical judgment to proceed further.';
      } else {
        int fluid_required_Rounded = fluidRequired.round();
        int maintenanceFluidRounded = maintenanceFluid.round();
        return 'Total Fluid to be given = ${fluid_required_Rounded} mL\nTotal Maintenance Fluid to be given = ${maintenanceFluidRounded} mL';
      }
    } else if (tbsa > 10 && weight > 20 && selectedPatientType == 'Child') {
      double maintenanceFluid = 1500 + (weight - 20) * 20;
      fluidRequired = 4 * weight * tbsa - fluidGiven;
      if (fluidRequired <= 0) {
        return 'The necessary fluid is already given. Please use clinical judgment to proceed further.';
      } else {
        int fluid_required_Rounded = fluidRequired.round();
        int maintenanceFluidRounded = maintenanceFluid.round();
        return 'Total Fluid to be given = ${fluid_required_Rounded} mL\nTotal Maintenance Fluid to be given = ${maintenanceFluidRounded} mL';
      }
    } else {
      return 'Error';
    }
  }
}

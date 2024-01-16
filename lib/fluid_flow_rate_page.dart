import 'package:flutter/material.dart';

import 'home_page.dart';


class FluidFlowRatePage extends StatelessWidget {
  final double timeSinceBurn;
  final int dropFactor;
  final double fluidRequired;
  final String selectedPatientType;

  FluidFlowRatePage({
    required this.timeSinceBurn,
    required this.dropFactor,
    required this.fluidRequired,
    required this.selectedPatientType,
  });

  @override
  Widget build(BuildContext context) {
    double startingFlowRate;
    double flowRateForNextSixteenHours;

    if (timeSinceBurn < 8) {
      startingFlowRate = fluidRequired / (2 * (8 - timeSinceBurn));
      flowRateForNextSixteenHours = fluidRequired / 32;
    } else if (8 <= timeSinceBurn && timeSinceBurn < 24) {
      startingFlowRate = fluidRequired / (24 - timeSinceBurn);
      flowRateForNextSixteenHours = 0.0;
    } else {
      // Display a message if timeSinceBurn > 24
      return Scaffold(
        appBar: AppBar(
          title: Text('Fluid Flow Rate Calculation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The 24 hours golden hour has already passed. Please use clinical judgement to proceed further.',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to HomePage
                },
                child: Text('Finish'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fluid Flow Rate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Starting Flow Rate: ${startingFlowRate.round()} mL/hour '
                  'or ${(startingFlowRate * dropFactor / 60).round()} drops/minute',
              style: TextStyle(fontSize: 18.0),
            ),
            if (flowRateForNextSixteenHours > 0)
              Text(
                'Flow Rate for the Next 16 Hours: ${flowRateForNextSixteenHours.round()} mL/hour '
                    'or ${(flowRateForNextSixteenHours * dropFactor / 60).round()} drops/minute',
                style: TextStyle(fontSize: 18.0),
              ),
            SizedBox(height: 16.0),
            Text(
              'The given flow rate may need to be updated based on urine output. Please use clinical judgement.',
              style: TextStyle(fontSize: 18.0),
            ),
            if (selectedPatientType == 'Child')
              Text(
                'This flow rate is only applicable for Resuscitation fluid. For Maintenance fluid flow rate, please use clinical judgement.',
                style: TextStyle(fontSize: 18.0),
              ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false
                ); // Navigate back to HomePage
              },
              child: Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}

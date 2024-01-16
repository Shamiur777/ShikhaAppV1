import 'package:flutter/material.dart';
import 'input_page.dart';
import 'fluid_flow_rate_decision_making_page.dart';
import 'nutritional_factor_calculation_page.dart'; // Import the new page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shikha App for Burn Patients'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Shikha App Logo.jpg',
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputPage()),
                );
              },
              child: Text('Patient Categorization and Fluid Calculation Segment'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FluidFlowRateDecisionMakingPage()),
                );
              },
              child: Text('Fluid Calculation Decision Making Segment'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NutritionalFactorCalculationPage()), // Navigate to the new page
                );
              },
              child: Text('Nutritional Factor Calculation Segment'),
            ),
          ],
        ),
      ),
    );
  }
}

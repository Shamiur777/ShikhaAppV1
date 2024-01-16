import 'package:flutter/material.dart';

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations Page'),
      ),
      body: Center(
        child: Text(
          'Congratulations',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

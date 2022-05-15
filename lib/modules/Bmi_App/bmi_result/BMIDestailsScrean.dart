import 'package:flutter/material.dart';

class BMIDestailsScrean extends StatelessWidget{

  final int result;
  final bool iSmale;
  final int age;

  BMIDestailsScrean({
    required this.result,
    required this.age,
    required this.iSmale
});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI details"
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result : ${result}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26
              ),
            ),
            Text(
              'Age :${age} ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26
              ),
            ),
            Text(
              'Gender : ${iSmale ? 'Male' : 'female' }',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26
              ),
            ),
          ],
        ),
      ),
    );
  }
}

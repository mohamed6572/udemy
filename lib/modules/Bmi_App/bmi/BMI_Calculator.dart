import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gps_tracker/modules/Bmi_App/bmi_result/BMIDestailsScrean.dart';
import 'package:gps_tracker/shared/components/components.dart';

class BMI_Calc extends StatefulWidget{


  @override
  State<BMI_Calc> createState() => _BMI_CalcState();
}

class _BMI_CalcState extends State<BMI_Calc> {
  bool isMale = true;

  double height = 120.0;
  int weight = 60;
  int age = 20;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator'),),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale =true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isMale ? Colors.blue: Colors.grey[400]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.male,size: 90,),
                            SizedBox(height: 15,),
                            Text('MALE',style: TextStyle(fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale =false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: !isMale ? Colors.blue: Colors.grey[400]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(Icons.female,size: 90,),
                            SizedBox(height: 15,),
                            Text('FEMALE',style: TextStyle(fontSize: 26,
                            fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[400]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HEIGHT',style: TextStyle(fontSize: 26,
                        fontWeight: FontWeight.bold
                    ),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic ,
                      children: [
                        Text('${height.round()}',style: TextStyle(fontSize: 40,
                            fontWeight: FontWeight.w900
                        ),),
                        SizedBox(width: 5,),
                        Text('CM',style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Slider(value: height,
                         max: 220.0,
                        min: 80.0,
                        onChanged:(value) {
                     setState(() {
                       height=value;
                     });

                        }, ),
                  ],
                ),
              ),
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(16),
                         color: Colors.grey[400]
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,

                       children: [
                         Text('Weight',style: TextStyle(fontSize: 25,
                             fontWeight: FontWeight.bold
                         ),),
                         Text('$weight',style: TextStyle(fontSize: 40,
                             fontWeight: FontWeight.w900
                         ),),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,

                           children: [
                             FloatingActionButton(
                               heroTag: 'w-',
                               onPressed: () {
                               setState(() {
                                 weight--;
                               });
                             },
                               mini: true,
                               child: Icon(Icons.remove),
                             ),
                             FloatingActionButton(
                               heroTag: 'w+',
                               onPressed: () {
                               setState(() {
                                 weight++;
                               });
                             },
                               mini: true,
                               child: Icon(Icons.add),
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
                 SizedBox(width: 20,),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(16),
                         color: Colors.grey[400]
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('AGE',style: TextStyle(fontSize: 25,
                             fontWeight: FontWeight.bold
                         ),),
                         Text('$age',style: TextStyle(fontSize: 40,
                             fontWeight: FontWeight.w900
                         ),),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,

                           children: [
                             FloatingActionButton(
                               heroTag: 'a-',
                               onPressed: () {
                               setState(() {
                                 age--;
                               });
                             },
                               mini: true,
                               child: Icon(Icons.remove),
                             ),
                             FloatingActionButton(
                               heroTag: 'a+',
                               onPressed: () {
                               setState(() {
                                 age++;
                               });
                             },
                               mini: true,
                               child: Icon(Icons.add),
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                 ),

                ],
              ),
            )
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            child:MaterialButton(
              height: 50,
              onPressed: () {

                var Result = weight / pow( height / 100, 2);
                navigateTo(
                  context,
                    BMIDestailsScrean(
                        result: Result.round(),
                        age: age,
                        iSmale: isMale)

                );

              },
              child: Text('Calculate',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white70
              ),
              ),
            ) ,
          )
        ],
      ),
    );
  }
}

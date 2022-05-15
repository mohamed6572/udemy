import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/cubit.dart';
import 'Cubit/states.dart';

class Counter_Screan extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit , CounterStates>(
        listener: (context, state) {},
       builder:(context, state) =>  Scaffold(
         appBar: AppBar(
           title: Text('Counter Screan'),
         ),
         body: Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               MaterialButton(onPressed: (){
                 CounterCubit.get(context).minus();
               },

                 color: Colors.blue,
                 child: Icon(Icons.remove),
               ),
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Text("${CounterCubit.get(context).Counter }",
                   style: TextStyle(
                       fontSize: 35
                   ),
                 ),
               ),
               MaterialButton(onPressed: (){
                  CounterCubit.get(context).plus();
               },
                 color: Colors.blue,
                 child: Icon(Icons.add),
               ),

             ],
           ),
         ),
       ),
      ),
    );
  }
}

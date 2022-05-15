import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/shared/Cubit/cubit.dart';
import 'package:gps_tracker/shared/Cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';

class done_tasks extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return
      BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).donetasks;
          return taskBuilder(tasks: tasks, text: 'no Done Tasks Yet , please Add Done Tasks');;
        }
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/News_Layout/Cubit/cubit.dart';
import 'package:gps_tracker/layout/News_Layout/Cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';

class BusinessScrean extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).Business;

        return articaleBuilder(list,context);
      },
    );
  }
}

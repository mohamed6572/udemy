import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/modules/Basics_App/counter_Scarean/Cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int Counter = 1;

  void minus(){
    Counter--;
    emit(CounterMinusState());
  }
  void plus(){
    Counter++;
    emit(CounterPlusState());
  }



}
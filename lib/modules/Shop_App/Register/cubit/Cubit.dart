import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/models/Shop_App/Login_Model.dart';
import 'package:gps_tracker/models/Shop_App/Register_Model.dart';
import 'package:gps_tracker/modules/Shop_App/Login/cubit/States.dart';
import 'package:gps_tracker/modules/Shop_App/Register/Shop_Register_Screan.dart';
import 'package:gps_tracker/modules/Shop_App/Register/cubit/States.dart';
import 'package:gps_tracker/shared/network/end_points.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() :super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late Register_Model registermodel;

  void userRegister({
  required String email,
  required String name,
  required String phone,
  required String password,
})async{
    emit(ShopRegisterLodingState());

    Dio_Helper.postData(
        url: Register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        }
    ).then((value) {

      print(value.data);
      registermodel = Register_Model.fromJson1(value.data);
      print(registermodel.stutes);
      print(registermodel.message);
      print(registermodel.data?.token);

      emit(ShopRegisterSucseslState(registermodel));
    }).catchError((error) {
      print('error when login is ${error.toString()}');
      emit(ShopRegisrtererorState(
        error.toString()
      ));

    });
  }


  IconData suffix =  Icons.visibility;
  bool isPassword= true;
  void ChangePasswordVisibilty(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
emit(ShopRegisterChangePasswordVisibiltyState());
  }
}
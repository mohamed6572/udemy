import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/models/Shop_App/Login_Model.dart';
import 'package:gps_tracker/modules/Shop_App/Login/cubit/States.dart';
import 'package:gps_tracker/shared/network/end_points.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() :super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
 late ShoploginModel loginmodel;

  void userLogin({
  required String email,
  required String password,
})async{
    emit(ShopLoginLodingState());

    Dio_Helper.postData(
        url: LOGIN,
        data: {
          "email": email,
          "password": password,
        }
    ).then((value) {

      print(value.data);
      loginmodel = ShoploginModel.fromJson1(value.data);
      print(loginmodel.stutes);
      print(loginmodel.message);
      print(loginmodel.data?.token);


      emit(ShopLoginSucseslState(loginmodel));
    }).catchError((error) {
      print('error when login is ${error.toString()}');
      emit(ShopLoginerrorState(
        error.toString()
      ));


    });
  }


  IconData suffix =  Icons.visibility;
  bool isPassword= true;
  void ChangePasswordVisibilty(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
emit(ShopChangePasswordVisibiltyState());
  }
}
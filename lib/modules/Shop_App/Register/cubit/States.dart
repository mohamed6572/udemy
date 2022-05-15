import 'package:gps_tracker/models/Shop_App/Login_Model.dart';
import 'package:gps_tracker/models/Shop_App/Register_Model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates{}
class ShopRegisterLodingState extends ShopRegisterStates{}
class ShopRegisterSucseslState extends ShopRegisterStates{
  final Register_Model registermodel;
  ShopRegisterSucseslState(this.registermodel);
}
class ShopRegisrtererorState extends ShopRegisterStates{
  final String Error;
  ShopRegisrtererorState(this.Error);
}
class ShopRegisterChangePasswordVisibiltyState extends ShopRegisterStates{}

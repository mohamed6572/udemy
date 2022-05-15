import 'package:gps_tracker/models/Shop_App/Login_Model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates{}
class ShopLoginLodingState extends ShopLoginStates{}
class ShopLoginSucseslState extends ShopLoginStates{
  late ShoploginModel loginmodel;
  ShopLoginSucseslState(this.loginmodel);
}
class ShopLoginerrorState extends ShopLoginStates{
  final String Error;
  ShopLoginerrorState(this.Error);
}
class ShopChangePasswordVisibiltyState extends ShopLoginStates{}

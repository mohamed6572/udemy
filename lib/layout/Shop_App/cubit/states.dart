import 'package:gps_tracker/models/Shop_App/Login_Model.dart';
import 'package:gps_tracker/models/Shop_App/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomState extends ShopStates{}

class ShopLoadingHomeDatState extends ShopStates{}

class ShopSucssesHomeDatState extends ShopStates{}

class ShopErrorHomeDatState extends ShopStates{
  final String error;
  ShopErrorHomeDatState(this.error);
}

class ShopSucssesCateogriesState extends ShopStates{}

class ShopErrorCateogriesState extends ShopStates{
  final String error;
  ShopErrorCateogriesState(this.error);
}


class ShopChangeFavoritesState extends ShopStates{}
class ShopSucssesChangeFavoritesState extends ShopStates{
   final ChangeFavoritesModel? model;
  ShopSucssesChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSucssesGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingGETProfileState extends ShopStates{}

class ShopSucssesGETProfileState extends ShopStates{
  final ShoploginModel model;
  ShopSucssesGETProfileState(this.model);
}

class ShopErrorGETProfileState extends ShopStates{
  final String error;
  ShopErrorGETProfileState(this.error);
}


class ShopLoadingUpdateProfileState extends ShopStates{}

class ShopSucssesUpdateProfileState extends ShopStates{
  final ShoploginModel model;
  ShopSucssesUpdateProfileState(this.model);
}

class ShopErrorUpdateProfileState extends ShopStates{
  final String error;
  ShopErrorUpdateProfileState(this.error);
}



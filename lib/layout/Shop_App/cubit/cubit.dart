import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/models/Shop_App/Login_Model.dart';
import 'package:gps_tracker/models/Shop_App/cateogries_model.dart';
import 'package:gps_tracker/models/Shop_App/change_favorites_model.dart';
import 'package:gps_tracker/models/Shop_App/favorites_model.dart';
import 'package:gps_tracker/models/Shop_App/home_model.dart';
import 'package:gps_tracker/modules/Shop_App/Settings/SettingsScrean.dart';
import 'package:gps_tracker/modules/Shop_App/cateogries/cateogriesScrean.dart';
import 'package:gps_tracker/modules/Shop_App/favorites/FavoritsScrean.dart';
import 'package:gps_tracker/modules/Shop_App/products/ProductsScrean.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:gps_tracker/shared/network/end_points.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int ShopCurrentIndex = 0;

  List<Widget> ShopScreans = [
    ProductsScrean(),
    CateogriesScrean(),
    FavoritsScrean(),
    SettingsScrean()
  ];
  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Cateogries'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorits'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void shopChangeIndex(int index) {
    ShopCurrentIndex = index;
    emit(ShopChangeBottomState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorits = {};

  void getHomeData() {
    emit(ShopLoadingHomeDatState());
    Dio_Helper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //   print(homeModel?.status);
      // print(homeModel?.data?.products[0].name);

      homeModel?.data?.products.forEach((element) {
        favorits.addAll({element.id ?? 0: element.inFavorites});
      });
      print(favorits.toString());

      emit(ShopSucssesHomeDatState());
    }).catchError((error) {
      print('error when load is ${error.toString()}');
      emit(ShopErrorHomeDatState(error.toString()));
    });
  }

  CateogriesModel? cateogriesmodel;

  void getcateogriesData() {
    Dio_Helper.getData(url: Categories).then((value) {
      cateogriesmodel = CateogriesModel.fromJson(value.data);
      emit(ShopSucssesCateogriesState());
    }).catchError((error) {
      print('error when load is ${error.toString()}');
      emit(ShopErrorCateogriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void ChangeFavorites(int ProductId) {
    favorits[ProductId] = !favorits[ProductId]!;
    emit(ShopChangeFavoritesState());
    Dio_Helper.postData(
      url: FAVORITES,
      data: {'product_id': ProductId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (changeFavoritesModel?.status == false) {
        favorits[ProductId] = !favorits[ProductId]!;
      } else {
        getFavorites();
      }
      emit(ShopSucssesChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorits[ProductId] = !favorits[ProductId]!;
      print('error when load is ${error.toString()}');
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    Dio_Helper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());
      emit(ShopSucssesGetFavoritesState());
    }).catchError((error) {
      print('error when load is ${error.toString()}');
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  ShoploginModel? userModel;

  void getProfile() {
    emit(ShopLoadingGETProfileState());
    Dio_Helper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShoploginModel.fromJson1(value.data);
      print(userModel?.data?.name);

      emit(ShopSucssesGETProfileState(userModel!));
    }).catchError((error) {
      print('error when load is ${error.toString()}');
      emit(ShopErrorGETProfileState(error.toString()));
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    String? image,
  }) {
    emit(ShopLoadingUpdateProfileState());
    Dio_Helper.putData(
        url: Update_PROFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone,'image' : image}).then((value) {
      userModel = ShoploginModel.fromJson1(value.data);

      emit(ShopSucssesUpdateProfileState(userModel!));
    }).catchError((error) {
      print('error when load is ${error.toString()}');
      emit(ShopErrorUpdateProfileState(error.toString()));
    });
  }
}

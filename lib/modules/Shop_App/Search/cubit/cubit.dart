import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/models/Shop_App/search_model.dart';
import 'package:gps_tracker/modules/Shop_App/Search/cubit/states.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:gps_tracker/shared/network/end_points.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit():super(SearchInitialState());


  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void Serach({
  required String text,
}){
    emit(SearchLoadingState());
    Dio_Helper.postData(url: SEARCH,
        token: token,
        data: {
      'text' : text
    }).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccsesState());
    }).catchError((error){
      emit(SearchErrorState());
    });
}


}
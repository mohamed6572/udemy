import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/models/Shop_App/favorites_model.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/colors.dart';

class FavoritsScrean extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BuildCondition(
            condition: state is! ShopLoadingGetFavoritesState,
            builder:(context) =>  ListView.separated(
                itemBuilder: (context, index) => BuildListProduct(
                    ShopCubit.get(context).favoritesModel?.data?.data[index].product,
                  context
                ),
                separatorBuilder: (context, index) =>myDivider(),
                itemCount:  ShopCubit.get(context).favoritesModel?.data?.data.length??0
            ),
            fallback: (context) => Center(child: CupertinoActivityIndicator(),),
          );
        }
    );
  }
}

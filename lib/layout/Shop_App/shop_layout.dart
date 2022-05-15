import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/modules/Shop_App/Login/shop_login_screan.dart';
import 'package:gps_tracker/modules/Shop_App/Search/searchScrean.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';

class Shop_Layout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar:AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, ShopSearchScrean());
              }, icon: Icon(Icons.search))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.ShopCurrentIndex ,
            onTap: (index){
              cubit.shopChangeIndex(index);
            },
            items: cubit.BottomItem
            ,
          ),
          body: cubit.ShopScreans[cubit.ShopCurrentIndex]

        );
      },
    );
  }
}

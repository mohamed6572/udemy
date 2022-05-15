import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/states.dart';
import 'package:gps_tracker/models/Shop_App/cateogries_model.dart';
import 'package:gps_tracker/shared/components/components.dart';

class CateogriesScrean extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
         return ListView.separated(
        itemBuilder: (context, index) => BuildCatItem(
       ShopCubit.get(context).cateogriesmodel?.data?.data[index]),
        separatorBuilder: (context, index) =>myDivider(),
        itemCount:   ShopCubit.get(context).cateogriesmodel?.data?.data.length ?? 0);
      }
    );
  }

  Widget BuildCatItem (DataModel? model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image:  NetworkImage('${model?.image}'),
          height: 88.0,
          width: 88.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20,),
        Text(
          '${model?.name}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}

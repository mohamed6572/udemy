import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/modules/Shop_App/Search/cubit/cubit.dart';
import 'package:gps_tracker/modules/Shop_App/Search/cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';

class ShopSearchScrean extends StatelessWidget{
  var formkey = GlobalKey<FormState>();
   var textControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    defultFormField(
                        type: TextInputType.text,
                        controller: textControler,
                        label: 'Search',
                        prefix: Icons.search,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'search must not be null';
                          }
                        },
                      onSubmeted: (text){
                          ShopSearchCubit.get(context).Serach(text: text);
                      },
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(state is SearchSuccsesState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => BuildListProduct(
                              ShopSearchCubit.get(context).searchModel?.data?.data[index],
                              context,
                            isOldPrice: false
                          ),
                          separatorBuilder: (context, index) =>myDivider(),
                          itemCount:  ShopSearchCubit.get(context).searchModel?.data?.data.length??0
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

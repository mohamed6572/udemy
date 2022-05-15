import 'package:flutter/material.dart';
import 'package:gps_tracker/layout/News_Layout/Cubit/cubit.dart';
import 'package:gps_tracker/shared/components/components.dart';

class Search_Screan extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).Search;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: defultFormField(
                  type: TextInputType.text,
                  controller: searchController,
                  label: 'search',
                  prefix: Icons.search,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'search must not be empty';
                    }

                  },
                onChanged: (String value){
                    NewsCubit.get(context).getSearch(value);

                },



              ),
            ),
            Expanded(child: articaleBuilder(list, context,isSearch: true)),
          ],
        ),

      ),
    );
  }
}

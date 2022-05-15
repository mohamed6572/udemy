import 'package:flutter/material.dart';
import 'package:gps_tracker/layout/News_Layout/Cubit/cubit.dart';
import 'package:gps_tracker/modules/News_App/search/search.dart';
import 'package:gps_tracker/shared/Cubit/cubit.dart';
import 'package:gps_tracker/shared/components/components.dart';

class News_Layout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
    var cubit1 = AppCubit.get(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(onPressed: (){
            navigateTo(context, Search_Screan());
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            cubit1.ChangeAppMode();
          }, icon: Icon(Icons.brightness_4_outlined)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.NewsCurrentIndex,
          onTap: (index){
            cubit.NewsChangeCurrentIndex(index);

          },
          items: cubit.NewsBottomItems

      ),


      body: cubit.NewsScreans[cubit.NewsCurrentIndex],
    );


  }
}

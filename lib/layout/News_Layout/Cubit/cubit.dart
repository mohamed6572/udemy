import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/News_Layout/Cubit/states.dart';
import 'package:gps_tracker/modules/News_App/Business/Business.dart';
import 'package:gps_tracker/modules/News_App/Science/science.dart';
import 'package:gps_tracker/modules/News_App/Sports/Sports.dart';

import 'package:gps_tracker/shared/network/local/casheHelper.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() :super(NewsInitialeState());

  static NewsCubit get(context) =>BlocProvider.of(context);

int NewsCurrentIndex =0;

List<Widget> NewsScreans = [
  BusinessScrean(),
  SportsScrean(),
  ScienceScrean(),
];

List<BottomNavigationBarItem> NewsBottomItems = [
  BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
  BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
  BottomNavigationBarItem(icon: Icon(Icons.science),label: 'science'),
  BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
];

void NewsChangeCurrentIndex( int index) {
  NewsCurrentIndex = index;
  // if(index==1)
  //   getSports();
  // if(index==2)
  //   getScience();
  emit(NewsChangeBottoNavBarState());

}

List<dynamic> Business = [];

void getBusiness (){
  emit(NewsGetBusinessLoadingState());
  Dio_Helper.getData(
      url:  'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '1beaef5108684a84ad7e3b73dbd2860c',
      }
  ).then((value) {
    // print(value?.data['articles'][0]['title']);
    Business = value.data['articles'];
    print(Business[0]['title']);
    print(Business.length);
    emit(NewsGetBusinessSucsesState());
  }).catchError((error){
    print('the error ${error.toString()}');
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}


  List<dynamic> Sports = [];

  void getSports (){
    emit(NewsGetSportsLoadingState());
   if(Sports.length==0){
     Dio_Helper.getData(
         url:  'v2/top-headlines',
         query: {
           'country': 'eg',
           'category': 'Sports',
           'apiKey': '1beaef5108684a84ad7e3b73dbd2860c',
         }
     ).then((value) {
       // print(value?.data['articles'][0]['title']);
       Sports = value.data['articles'];
       print(Sports[0]['title']);
       emit(NewsGetSportsSucsesState());
     }).catchError((error){
       print('the error ${error.toString()}');
       emit(NewsGetSportsErrorState(error.toString()));
     });
   }else
     {
       emit(NewsGetScienceSucsesState());
     }
  }


  List<dynamic> Science = [];

  void getScience (){
    emit(NewsGetScienceLoadingState());
    if(Science.length == 0){
      Dio_Helper.getData(
          url:  'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'Science',
            'apiKey': '1beaef5108684a84ad7e3b73dbd2860c',
          }
      ).then((value) {
        // print(value?.data['articles'][0]['title']);
        Science = value.data['articles'];
        print(Science[0]['title']);
        emit(NewsGetScienceSucsesState());
      }).catchError((error){
        print('the error ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });

    }
    else {
      emit(NewsGetScienceSucsesState());
    }

  }

  List<dynamic> Search = [];

  void getSearch (String q){
    emit(NewsGetSearchLoadingState());


    Dio_Helper.getData(
        url:  'v2/everything',
        query: {
          'q': '$q',
          'apiKey': '1beaef5108684a84ad7e3b73dbd2860c',
        }
    ).then((value) {
      // print(value?.data['articles'][0]['title']);
      Search = value.data['articles'];
      print(Search[0]['title']);
      emit(NewsGetSearchSucsesState());
    }).catchError((error){
      print('the error ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }




}
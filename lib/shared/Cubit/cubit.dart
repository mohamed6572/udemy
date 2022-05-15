import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/modules/ToDo_App/archived_tasks/archived_tasks.dart';
import 'package:gps_tracker/modules/ToDo_App/done_tasks/done_tasks.dart';
import 'package:gps_tracker/modules/ToDo_App/new_tasks/new_tasks.dart';
import 'package:gps_tracker/shared/Cubit/states.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit () :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;
  List<Widget> BottomItem = [
    new_tasks(),
    done_tasks(),
    archived_tasks(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottmNavBarState());
  }

  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void createDatabase ()
  {
   openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (db, version) {
        // ID INTEGER
        // title String
        //time String
        //date String
        //status

        db.execute('CREATE TABLE TASKS ( id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT )').then((value) {
          print('data created');

        }).catchError((error){
          print('Error when creating database ${error.toString()  }');
        });

      },
      onOpen: (db) {
        getDataFromDataBase(db);
        print('data opend');
      },
    ).then((value) {
     database = value;
     emit(AppCreateDateBaseState());
   }) ;
  }
  ////////////////insert To DataBase////////////////////////////////////////////
   insertToDatabase({
    required String title,
    required String time,
    required String date,
  })async
  {
      await database.transaction((txn)
    {
     return txn.rawInsert('INSERT INTO TASKS (title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value inserted sucssefully');
        emit(AppInsertDateBaseState());

        getDataFromDataBase(database);



      }).catchError((error){
        print('error when iserting ${error.toString()}');
      });



    });

  }

void getDataFromDataBase(database)
{
  newtasks= [];
  donetasks= [];
  archivetasks= [];
    emit(AppGetDateBaseLodingState());
     database.rawQuery('SELECT * FROM TASKS').then((value) {
       value.forEach((element) {
         if(element['status'] == 'new')
           newtasks.add(element);
         else if(element['status'] == 'done')
           donetasks.add(element);
         else archivetasks.add(element);

       });

       emit(AppGetDateBaseState());
     });

  }

  void UpdateData({
    required String status,
    required int id
}) async
  {

     database.rawUpdate(
        'UPDATE TASKS SET status = ? WHERE id = ?',
        ['$status', id]
     ).then((value) {
       getDataFromDataBase(database);
       emit(AppUpdateDateBaseState());
     });

  }

  void deleteData({
    required int id
}) async
  {

     database.rawUpdate(
         'DELETE FROM TASKS WHERE id = ?', [id]
     ).then((value) {
       getDataFromDataBase(database);
       emit(AppDeleteDateBaseState());
     });

  }

  bool isBotomSheet =false;
  IconData fabIocn = Icons.edit ;

  void ChangeBottomSheetIcon({
  required bool isShow ,
  required IconData icon ,
}){

    isBotomSheet = isShow;
    fabIocn = icon;
    emit(AppChangeBottmSheetState());
  }


  bool isDark = false;

  void ChangeAppMode({ bool? fromSared}){
    if(fromSared != null)
    {
      isDark = fromSared;
      emit(AppChangeModeState());

    }
    else
      isDark = !isDark;
    casheHelper.putBoolen(key: 'isDark', value: isDark).then((value) =>   emit(AppChangeModeState())
    );
  }


}
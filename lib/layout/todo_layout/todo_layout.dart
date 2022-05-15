import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gps_tracker/shared/Cubit/cubit.dart';
import 'package:gps_tracker/shared/Cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';

import 'package:intl/intl.dart';


// 1- create database
// 2- create table
// 3- opren database
// 4- insert to database
// 5- get from database
// 6- upgrade database
// 7- delete from database

class HomeLayout extends StatelessWidget
{
  /////////////////////////variables////////////////////////////////////////////


  var scafoldKey = GlobalKey<ScaffoldState>();
  var fromKey = GlobalKey<FormState>();

  var titleControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  //////////////////list////////////////////////////////////////////////////////

  /////////////////////initState////////////////////////////////////////////////
  @override

////////////build///////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener:(context, state){
          if(state is AppInsertDateBaseState){
            Navigator.pop(context);
          }
        } ,
        builder:(context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
          key: scafoldKey,
          appBar: AppBar(
            title: Text(
                cubit.titles[cubit.currentIndex]
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(cubit.isBotomSheet){
                if(fromKey.currentState?.validate() == true){
                 cubit.insertToDatabase(
                   title: titleControler.text,
                   time: timeControler.text,
                   date: dateControler.text,
                 );

                }
              }
              else{
                scafoldKey.currentState?.showBottomSheet(
                      (context) => Container(

                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: fromKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defultFormField(
                              type: TextInputType.text,
                              controller: titleControler,
                              label: 'Task Title',
                              prefix: Icons.title,
                              validator: (value){
                                if(value!.isEmpty){
                                  return('title must not be impty');
                                }
                                return null;
                              },),
                            SizedBox(height: 15,),
                            defultFormField(
                                type: TextInputType.datetime,
                                controller: timeControler,
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return('time must not be impty');
                                  }
                                  return null;
                                },
                                onTap: (){
                                  showTimePicker(

                                      context: context,
                                      initialTime: TimeOfDay.now()
                                  ).then((value) {
                                    timeControler.text = value!.format(context).toString();
                                  });
                                }),
                            SizedBox(height: 15,),
                            defultFormField(
                                type: TextInputType.datetime,
                                controller: dateControler,
                                label: 'Task Date',
                                prefix: Icons.calendar_today,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return('date must not be impty');
                                  }
                                  return null;
                                },
                                onTap: (){
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-03-08'),
                                  ).then((value) {
                                    dateControler.text = DateFormat.yMMMd().format(value!);


                                  });
                                }),
                          ],
                        ),
                      ),
                    ),

                  ),
                  elevation: 20.0,
                ).closed.then((value) {
                  cubit.ChangeBottomSheetIcon(
                    isShow: false,
                    icon: Icons.edit
                  );
                });
                cubit.ChangeBottomSheetIcon(
                    isShow: true,
                    icon: Icons.add
                );
              }
            },
            child: Icon(cubit.fabIocn),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.ChangeIndex(index);


            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived'
              ),
            ],
          ),
          body: state is! AppGetDateBaseLodingState
              ? cubit.BottomItem[cubit.currentIndex]
              :Center(child: CircularProgressIndicator()

          ),
          );

          } ,

      ),
    );
  }

//////////////////careate DataBase//////////////////////////////////////////////

}





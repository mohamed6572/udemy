
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/modules/Social_app/newpost/NewPost.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, New_Post_Screan());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.CurrentIndex]),
            actions: [
              Icon(IconBroken.Notification),
              SizedBox(width: 9,),
              Icon(IconBroken.Search),
            ],
          ),
          body: cubit.Screans[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (index){
              cubit.ChangeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.User),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
/*
BuildCondition(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      color: Colors.amber.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text('please verify your email'),
                            ),
                            defultTextButtton(
                                text: 'Send',
                                function: () {
                                  FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification()
                                      .then((value) {
                                        showToast(text: 'show your mail', state: ToastStates.SUCSSES);
                                  })
                                      .catchError((error) {});
                                }),
                          ],
                        ),
                      ),
                    )
                ],
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
 */
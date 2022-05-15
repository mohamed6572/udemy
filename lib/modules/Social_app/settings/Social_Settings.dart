import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/modules/Social_app/edit_Profile/Edit_Profile_Screan.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

class Social_Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: EdgeInsets.all(8),
          child:  Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,

                      child: Container(

                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              topLeft: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${userModel?.cover}',),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel?.image}'                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),

              Text(  '${userModel?.name}',style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(height: 5,),
              Text(  '${userModel?.bio}',style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.subtitle2,),
                            SizedBox(height: 5,),

                            Text('Post',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('290',style: Theme.of(context).textTheme.subtitle2,),
                            SizedBox(height: 5,),

                            Text('Photos',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('10k',style: Theme.of(context).textTheme.subtitle2,),
                            SizedBox(height: 5,),

                            Text('Followers',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('90',style: Theme.of(context).textTheme.subtitle2,),
                            SizedBox(height: 5,),

                            Text('Followings',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(
                    child: Text('Add Photo'), onPressed: () { },),
                  ),
                  SizedBox(width: 5,),
                  OutlinedButton(
                    child: Icon(IconBroken.Edit,size: 16,), onPressed: () {
                      navigateTo(context, Edit_Profile_Screan());
                  },),
                ],
              )
            ],
          ),
        );
      },

    );
  }
}

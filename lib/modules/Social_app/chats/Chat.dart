import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/models/social_app/social_user_model.dart';
import 'package:gps_tracker/modules/Social_app/chat_details/Chat_Details_Screan.dart';
import 'package:gps_tracker/shared/components/components.dart';

class Chat_Screan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
         listener: (context, state) {},
      builder: (context, state) {
           return BuildCondition(
             condition: SocialCubit.get(context).users.length >0,
             builder: (context) => ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) =>BuildChatItem(SocialCubit.get(context).users[index],context) ,
                 separatorBuilder: (context, index) => myDivider(),
                 itemCount: SocialCubit.get(context).users.length
             ),
             fallback: (context) =>Center(child: CircularProgressIndicator()),
           );
      }
    );
  }
  Widget BuildChatItem(SocialUserModel model,context)=>  InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScrean(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
              '${model.name}',

          ),
        ],
      ),
    ),
  );
}

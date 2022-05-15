import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/models/social_app/message_model.dart';
import 'package:gps_tracker/models/social_app/post_model.dart';
import 'package:gps_tracker/shared/components/components.dart';

class CreateComment extends StatelessWidget {
  var commentController = TextEditingController();
String postsId;
  CreateComment(  this.postsId,);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComment(postId: postsId);


        return  BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: defultAppBar(context: context, title: 'Comments', actions: [
                defultTextButtton(
                    text: 'Add',
                    function: () {
                      SocialCubit.get(context).CommentPost(
                          comment: commentController.text,
                          postId: postsId,
                          dateTime: DateTime.now().toString());
                    })
              ]),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // if(FirebaseFirestore.instance.collection('posts').doc(postsId).collection('comments')==null)
                    //   Expanded(child: Column()),
                    //
                    //   if(FirebaseFirestore.instance.collection('posts').doc(postsId).collection('comments')!=null)
                     Expanded(
                       child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildCommentItem(context,SocialCubit.get(context).commentss[index]),
                          separatorBuilder: (context ,index)=>SizedBox(height: 8,),
                          itemCount: SocialCubit.get(context).commentss.length
                    ),
                     ),

                    TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                          hintText: 'write your commment',
                          border: InputBorder.none),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },

    );
  }

  Widget buildCommentItem(context, CommentModel model) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel?.image}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${SocialCubit.get(context).userModel?.name}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
}

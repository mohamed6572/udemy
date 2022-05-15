import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/models/social_app/post_model.dart';
import 'package:gps_tracker/modules/Social_app/comments/createComment.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/colors.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

class Feeds_Screan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.get(context).posts.length >0 && SocialCubit.get(context).userModel != null ,
          builder: (context) =>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(context,SocialCubit.get(context).posts[index],index,),
                    separatorBuilder: (context ,index)=>SizedBox(height: 8,),
                    itemCount: SocialCubit.get(context).posts.length
                ),
                SizedBox(height: 8,)
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }


    );
  }
  Widget buildPostItem(context,PostModel model,index)=>   Card(
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
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}'
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}'
                          ,
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: DefultColor,
                          size: 16,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}'
                      ,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 19,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
              '${model.text}'
,
              style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10.0,top: 5.0 ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               child: Text(
          //                 '#Software',
          //                 style: Theme.of(context).textTheme.caption?.copyWith(
          //                     color: DefultColor
          //                 ),
          //               ),
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               child: Text(
          //                 '#flttuer',
          //                 style: Theme.of(context).textTheme.caption?.copyWith(
          //                     color: DefultColor
          //                 ),
          //               ),
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //             ),
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 15.0),
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                         // likemodel.like == true?
                         //  Icon(
                         //        IconBroken.Home,
                         //    size: 16.0, color: Colors.red,):
                              Icon(  IconBroken.Heart,size: 16.0,color: Colors.red,)

                          ,


                          SizedBox(width: 5,),
                          Text(
                              '${SocialCubit.get(context).Likes[index]}'
                            ,style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,size: 16.0, color: Colors.amber,),
                          SizedBox(width: 5,),
                          Text('${SocialCubit.get(context).commnetsNumber[index]} comments',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                      //${SocialCubit.get(context).commnetsNumber[index]}
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap:(){
                   navigateTo(context, CreateComment(SocialCubit.get(context).postsId[index]));

                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel?.image}'
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          'write a comment ...',
                          style: Theme.of(context)
                              .textTheme
                              .caption

                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).LikePost(SocialCubit.get(context).postsId[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart,size: 16.0, color: Colors.red,),
                      SizedBox(width: 5,),
                      Text('Like',style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    ),
  );

}

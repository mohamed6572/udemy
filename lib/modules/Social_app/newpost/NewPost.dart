import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

class New_Post_Screan extends StatelessWidget {

  var textController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccsesState)
          Navigator.pop(context);
      },
      builder: (context , state){
        return Scaffold(
          appBar: defultAppBar(context: context, title: 'Create Post', actions: [
            defultTextButtton(text: 'Post', function: () {
              var now = DateTime.now();

              print(now);
              if(SocialCubit.get(context).postImage == null){
                SocialCubit.get(context).createPost(dateTime: now.toString(), text: textController.text);
              }else{
                SocialCubit.get(context).UploadPostImage(dateTime: now.toString(), text: textController.text);

              }
            }),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10,),

                  Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Mohamed Hany',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'what is on your mind ...',
                          border: InputBorder.none),
                      controller: textController,
                    )),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage!=null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image:  FileImage(SocialCubit.get(context).postImage!) as ImageProvider,
                              fit: BoxFit.cover)),
                    ),
                    IconButton(
                        onPressed: () {
                          SocialCubit.get(context).RemovePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: Text('# tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );

      },
    );
  }
}

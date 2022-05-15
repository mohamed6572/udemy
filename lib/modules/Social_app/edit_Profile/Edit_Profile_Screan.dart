import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/shared/components/components.dart';
import 'package:gps_tracker/shared/styles/icon_broken.dart';

class Edit_Profile_Screan extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileimage;
        var CoverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel?.name ?? '';
        bioController.text = userModel?.bio ?? '';
        phoneController.text = userModel?.phone ?? '';

        return Scaffold(
          appBar:
              defultAppBar(context: context, title: 'Edit Profile', actions: [
            defultTextButtton(text: 'Update', function: () {

              SocialCubit.get(context).UpdateUser(
                phone: phoneController.text,
                name: nameController.text,
                Bio: bioController.text,


              );
            }),
            SizedBox(
              width: 15,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialuserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialuserUpdateLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                    height: 210,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4.0),
                                      topLeft: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        image: CoverImage ==null ?
                                        NetworkImage(
                                          '${userModel?.cover}',
                                        ): FileImage(CoverImage) as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel?.image}')
                                    : FileImage(
                                        profileImage,
                                      ) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).profileimage !=null || SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileimage !=null)
                      Expanded(child: Column(
                        children: [
                          defultButton(text: 'upload Profile ', function: (){
                            SocialCubit.get(context).uploadProfileImage(
                              phone: phoneController.text,
                              name: nameController.text,
                              Bio: bioController.text,


                            );
                          }),
                          SizedBox(height: 5,),
                          if(state is SocialuserUpdateLoadingState)

                            LinearProgressIndicator(),

                        ],
                      )),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).coverImage !=null)
                      Expanded(child:
                      Column(
                        children: [
                          defultButton(text: 'upload Cover ', function: (){
                            SocialCubit.get(context).uploadCoverImage(
                              phone: phoneController.text,
                              name: nameController.text,
                              Bio: bioController.text,


                            );
                          }),
                          SizedBox(height: 5,),
                          if(state is SocialuserUpdateLoadingState)

                            LinearProgressIndicator(),

                        ],
                      )),
                    ],
                  ),
                  if(SocialCubit.get(context).profileimage !=null || SocialCubit.get(context).coverImage != null)

                    SizedBox(
                    height: 20,
                  ),
                  defultFormField(
                      type: TextInputType.name,
                      controller: nameController,
                      label: 'name',
                      prefix: IconBroken.User,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must be not empty';
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  defultFormField(
                      type: TextInputType.text,
                      controller: bioController,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bio must be not empty';
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  defultFormField(
                      type: TextInputType.phone,
                      controller: phoneController,
                      label: 'phone',
                      prefix: IconBroken.Call,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must be not empty';
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

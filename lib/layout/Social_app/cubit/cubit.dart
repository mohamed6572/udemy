import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Social_app/cubit/states.dart';
import 'package:gps_tracker/models/social_app/message_model.dart';
import 'package:gps_tracker/models/social_app/post_model.dart';
import 'package:gps_tracker/models/social_app/social_user_model.dart';
import 'package:gps_tracker/modules/Social_app/chats/Chat.dart';
import 'package:gps_tracker/modules/Social_app/feeds/Feeds.dart';
import 'package:gps_tracker/modules/Social_app/newpost/NewPost.dart';
import 'package:gps_tracker/modules/Social_app/settings/Social_Settings.dart';
import 'package:gps_tracker/modules/Social_app/users/Users.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialgetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialgetUserSucsesState());
    }).catchError((error) {
      emit(SocialgetUserErrorState(error.toString()));
    });
  }

  List<Widget> Screans = [
    Feeds_Screan(),
    Chat_Screan(),
    New_Post_Screan(),
    Users_Screan(),
    Social_Settings()
  ];
  List<String> titles = [
    'Home',
    'Chat',
    'Post',
    'Users',
    'Settings',
  ];

  int CurrentIndex = 0;

  void ChangeIndex(index) {
    if (index == 1) getAllUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      CurrentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileimage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String Bio,
  }) {
    emit(SocialuserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage?.path ?? '').pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateUser(Bio: Bio, phone: phone, name: name, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String Bio,
  }) {
    emit(SocialuserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage?.path ?? '').pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        UpdateUser(Bio: Bio, phone: phone, name: name, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void UpdateUser({
    required String name,
    required String phone,
    required String Bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model1 = SocialUserModel(
      name: name,
      bio: Bio,
      phone: phone,
      email: userModel?.email,
      uId: userModel?.uId,
      cover: cover ?? userModel?.cover,
      image: image ?? userModel?.image,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model1.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialuserUpdateErrorState());
    });
  }

  File? postImage;

  void RemovePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccsessState());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void UploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage?.path ?? '').pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(text: text, dateTime: dateTime, Postimage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? Postimage,
  }) {
    PostModel model = PostModel(
        name: userModel?.name,
        uId: userModel?.uId,
        image: userModel?.image,
        text: text,
        dateTime: dateTime,
        postImage: Postimage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toJson())
        .then((value) {
      emit(SocialCreatePostSuccsesState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<commentModel> comm = [];
  List<int> Likes = [];
  List<int> commnetsNumber = [];

  void getPosts() {



    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').snapshots().listen((event) {
      postsId = [];
      posts=[];

      Likes = [];
      commnetsNumber = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          Likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
        element.reference.collection('comments')
            .get().then((value) {
          commnetsNumber.add(value.docs.length);
        }).catchError((error){});

      });
      emit(SocialgetPostSucsesState());


      });



    //     .get().then((value) {
    //   value.docs.forEach((element) {
    //     element.reference.collection('likes').get().then((value) {
    //       Likes.add(value.docs.length);
    //       postsId.add(element.id);
    //       posts.add(PostModel.fromJson(element.data()));
    //     }).catchError((error) {});
    //     element.reference.collection('comments').get().then((value) {
    //       commnetsNumber.add(value.docs.length);
    //     }).catchError((error){});
    //   });
    //   emit(SocialgetPostSucsesState());
    // }).catchError((error) {
    //   emit(SocialgetPostErrorState(error.toString()));
    // });
    //

  }

  void LikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSucsesState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

//
// void getComment(String postId){
//   FirebaseFirestore.instance
//       .collection('posts')
//       .doc(postId)
//       .collection('comments')
//       .get().then((value) {
//
//     value.docs.forEach((element) {
//          comm.add(commentModel.fromJson(element.data()));
//       });
//
//     emit(SocialgetCommentSucsesState());
//   }).catchError((error) {
//     emit(SocialgetCommentErrorState(error.toString()));
//   });
// }

  void CommentPost({required String postId, required String comment,required String dateTime}) {


    CommentModel model = CommentModel(
        dateTime: dateTime,
        text: comment,
        senderId: userModel?.uId);
// set my chats

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
    .doc(userModel?.uId)
        .set(model.toJson())
        .then((value) {
      emit(SocialCommentPostSucsesState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });


    //
    // FirebaseFirestore.instance
    //     .collection('posts')
    //     .doc(postId)
    //     .collection('comments')
    //     .doc(userModel?.uId)
    //     .set({'comment': '$comment'}).then((value) {
    //   emit(SocialCommentPostSucsesState());
    // }).catchError((error) {
    //   emit(SocialCommentPostErrorState(error.toString()));
    // });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel?.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialgetAllUsersSucsesState());
      }).catchError((error) {
        emit(SocialgetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        dateTime: dateTime,
        text: text,
        receiverId: receiverId,
        senderId: userModel?.uId);
// set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SocialSendMessageSucsesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
// set reseiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SocialSendMessageSucsesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages(
      {
        required String reseiverId
      })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(reseiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
          event.docs.forEach((element) {

            messages.add(MessageModel.fromJson(element.data()));

          });
          emit(SocialgetMessageSucsesState());

    });

  }




  List<CommentModel> commentss = [];

  void getComment(
      {
        required String postId
      })
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
          commentss=[];
      event.docs.forEach((element) {

        commentss.add(CommentModel.fromJson(element.data()));

      });
      emit(SocialgetMessageSucsesState());

    });

  }
}

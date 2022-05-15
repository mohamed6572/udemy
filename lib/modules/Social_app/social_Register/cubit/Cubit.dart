import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/models/social_app/social_user_model.dart';
import 'package:gps_tracker/modules/Social_app/social_Register/cubit/States.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterIntialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLodingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

      createUser(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,

      );

    }).catchError((error) {
      emit(SocialRegisterErerorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,

  }) {
    SocialUserModel model =
        SocialUserModel(name: name, email: email, phone: phone, uId: uId,isEmailVerified: false,
          bio: 'write your bio ...',
          cover: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
          image: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',

        );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
          emit(SocialCreateUserSucseslState());
    })
        .catchError((error) {
          emit(SocialCreateUserErerorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void ChangePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibiltyState());
  }
}

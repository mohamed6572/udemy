
abstract class SocialLoginStates {}

class SocialLoginIntialState extends SocialLoginStates {}

class SocialLoginLodingState extends SocialLoginStates {}

class SocialLoginSucsesState extends SocialLoginStates {
  final String? uId;

  SocialLoginSucsesState(this.uId);
}

class SocialLoginerrorState extends SocialLoginStates {
  final String Error;

  SocialLoginerrorState(this.Error);
}

class SocialChangePasswordVisibiltyState extends SocialLoginStates {}

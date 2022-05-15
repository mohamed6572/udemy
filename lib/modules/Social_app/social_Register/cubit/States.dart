abstract class SocialRegisterStates {}

class SocialRegisterIntialState extends SocialRegisterStates {}

class SocialRegisterLodingState extends SocialRegisterStates {}

class SocialRegisterSucseslState extends SocialRegisterStates {}

class SocialRegisterErerorState extends SocialRegisterStates {
  final String Error;

  SocialRegisterErerorState(this.Error);
}


class SocialCreateUserLodingState extends SocialRegisterStates {}

class SocialCreateUserSucseslState extends SocialRegisterStates {}

class SocialCreateUserErerorState extends SocialRegisterStates {
  final String Error;

  SocialCreateUserErerorState(this.Error);
}

class SocialRegisterChangePasswordVisibiltyState extends SocialRegisterStates {}

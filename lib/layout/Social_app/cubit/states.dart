abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialgetUserLoadingState extends SocialStates {}

class SocialgetUserSucsesState extends SocialStates {}

class SocialgetUserErrorState extends SocialStates {
  final String error;

  SocialgetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccsessState extends SocialStates {}
class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccsessState extends SocialStates {}
class SocialCoverImagePickedErrorState extends SocialStates {}


class SocialUploadProfileImageSuccsessState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {}


class SocialUploadCoverImageSuccsessState extends SocialStates {}
class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialuserUpdateErrorState extends SocialStates {}
class SocialuserUpdateLoadingState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccsesState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}


class SocialPostImagePickedSuccsessState extends SocialStates {}
class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}


class SocialgetPostLoadingState extends SocialStates {}

class SocialgetPostSucsesState extends SocialStates {}

class SocialgetPostErrorState extends SocialStates {
  final String error;

  SocialgetPostErrorState(this.error);
}




class SocialLikePostSucsesState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSucsesState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}
class SocialgetCommentSucsesState extends SocialStates {}

class SocialgetCommentErrorState extends SocialStates {
  final String error;

  SocialgetCommentErrorState(this.error);
}


class SocialgetAllUsersLoadingState extends SocialStates {}

class SocialgetAllUsersSucsesState extends SocialStates {}

class SocialgetAllUsersErrorState extends SocialStates {
  final String error;

  SocialgetAllUsersErrorState(this.error);
}



class SocialSendMessageSucsesState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;

  SocialSendMessageErrorState(this.error);
}


class SocialgetMessageSucsesState extends SocialStates {}


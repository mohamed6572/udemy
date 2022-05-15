class SocialUserModel {
   String? name;
   String? email;
   String? phone;
   String? uId;
   String? image;
   String? cover;
   String? bio;
   bool? isEmailVerified;

  SocialUserModel({
     this.name,
     this.email,
     this.phone,
     this.uId,
     this.image,
     this.cover,
     this.bio,
     this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    bio = json['bio'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'cover': cover,
      'uId': uId,
      'bio': bio,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}

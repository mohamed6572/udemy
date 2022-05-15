class PostModel {
   String? name;
   String? uId;
   String? image;
   String? postImage;
   String? dateTime;
   String? text;

  PostModel({
     this.name,
     this.uId,
     this.image,
     this.postImage,
     this.dateTime,
     this.text,

  });

  PostModel.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,

    };
  }
}

class commentModel {
  String? comment;


  commentModel({
    this.comment,


  });

  commentModel.fromJson(Map<String, dynamic> json) {

    comment = json['comment'];

  }

  Map<String, dynamic> toJson(){
    return {
      'comment': comment,


    };
  }
}
class likeModel {
  bool? like;


  likeModel({
    this.like,


  });

  likeModel.fromJson(Map<String, dynamic> json) {

    like = json['like'];

  }

  Map<String, dynamic> toJson(){
    return {
      'like': like,


    };
  }
}

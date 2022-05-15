class MessageModel {
   String? text;
   String? senderId;
   String? receiverId;
   String? dateTime;


  MessageModel({
     this.text,
     this.senderId,
     this.receiverId,
     this.dateTime,


  });

  MessageModel.fromJson(Map<String, dynamic> json) {

    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toJson(){
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,


    };
  }
}
class CommentModel {
   String? text;
   String? senderId;
   String? dateTime;


   CommentModel({
     this.text,
     this.senderId,
     this.dateTime,


  });

   CommentModel.fromJson(Map<String, dynamic> json) {

    text = json['text'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toJson(){
    return {
      'text': text,
      'senderId': senderId,
      'dateTime': dateTime,


    };
  }
}

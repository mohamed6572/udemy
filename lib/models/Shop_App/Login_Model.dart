class ShoploginModel{
  bool stutes = true;
  String? message;
  UserData? data;
  ShoploginModel.fromJson1(Map<String , dynamic> json){
    stutes = json['status'];
    message = json['message'];
    data =  UserData.fromJson(json['data']);
    //json['data'] != null ? : null!;

  }

}

class UserData{
   int? id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late  int points;
  late int credit;
  late String token ;
  UserData.fromJson(Map<dynamic , dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
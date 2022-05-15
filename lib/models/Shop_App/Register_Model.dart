class Register_Model{
  bool stutes = true;
  String? message;
  UserData? data;
  Register_Model.fromJson1(Map<String , dynamic> json){
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
  late String token ;
  UserData.fromJson(Map<dynamic , dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
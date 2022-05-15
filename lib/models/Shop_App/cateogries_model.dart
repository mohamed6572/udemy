class CateogriesModel
{
  bool? status;
  cateogriesDataModel? data;
  CateogriesModel.fromJson(Map<String , dynamic> json)

  {
    status = json["status"];
    data=  cateogriesDataModel.fromJson(json['data']);
  }
}

class cateogriesDataModel
{
  int? CurrentPage;
    List<DataModel> data =[];

    cateogriesDataModel.fromJson(Map<String, dynamic> json)
  {
    CurrentPage = json["current_page"];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });

  }
}

class DataModel{
   int? id;
   String? image;
   String? name;
   DataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}

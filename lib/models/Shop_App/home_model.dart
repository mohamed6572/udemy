class HomeModel
{
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String , dynamic> json)

  {
    status = json["status"];
    data=  HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
    List<BannerModel> banners =[];
   List<productModel> products =[];
  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(productModel.fromJson(element));
    });
  }
}

class BannerModel{
   int? id;
   String? image;
   BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class productModel{
   int? id;
  late dynamic  price;
  late dynamic  oldPrice;
  late dynamic  discount;
  late String  image;
  late String  name;
  late bool  inFavorites;
  late bool  inCart;
  productModel.fromJson(Map<dynamic, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];

  }
}
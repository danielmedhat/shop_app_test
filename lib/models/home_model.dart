

class HomeModel {
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
     data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners =[];
  List<ProductsModel> products = [];

   HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add( BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  int id;
  String image;
  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  String name;
  String image;
  dynamic discount;
  bool inFavorite;
  bool inCart;
  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    inCart = json['in_cart'];
    inFavorite = json['in_favorites'];
  }
}

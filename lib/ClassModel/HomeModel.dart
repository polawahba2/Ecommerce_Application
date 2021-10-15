class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  late List banners = [];
  late List products = [];
  int id = 0;
  String image = '';

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });
  }
}

// class BannerModel {
//   int? id;
//   String? image;
//   BannerModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }

// class ProductModel {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String image = '';
//   String name = '';
//   bool? inFavorite;
//   bool? inCart;
//   ProductModel.fromJson(Map<String, dynamic> json) {  
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     inFavorite = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
// }
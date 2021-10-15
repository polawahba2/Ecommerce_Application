class GetFavoritesModel {
  bool? status;
  dynamic? message;
  Data? data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int currentPage = 0;
  List data = [];
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((value) {
      data.add(value);
    });
  }
}

class DataOfProduct {
  int produtctId = 0;
  // ProductInfo? productInfo;
  DataOfProduct.fromJson(Map<String, dynamic> json) {
    produtctId = json['id'];
    // productInfo = json['product'];
  }
}

// class ProductInfo {
//   int id = 0;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String image = '';
//   String name = '';
//   ProductInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//   }
// }
////////////////////////////////////////////////////////////////////


// class Data {
//   int? currentPage;
//   List<FavoritesData> data = [];
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;

//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = new List<Data>();
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
// }

// class FavoritesData {
//   int? id;
//   Product? product;

//   FavoritesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//         json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
// }

// class Product {
//   int? id;
//   int? price;
//   int? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
// }




// // class GetFavoritesModel {
// //   bool Status = false;
// //   String? message;
// //   Data? data;
// //   GetFavoritesModel.fromJson(Map<String, dynamic> json) {
// //     Status = json['status'];
// //     message = json['message'];
// //     data = Data.fromJson(json['data']);
// //   }
// // }

// // class Data {
// //   int? currentPage;
// //   List<FavoritesData> favoritesData = [];
// //   Data.fromJson(Map<String, dynamic> json) {
// //     currentPage = json['current_page'];
// //     json['data'].forEatch((element) {
// //       favoritesData.add(FavoritesData.fromJson(element));
// //     });
// //   }
// // }

// // class FavoritesData {
// //   int? favoriteId;
// //   Product? products;
// //   FavoritesData.fromJson(Map<String, dynamic> json) {
// //     favoriteId = json['id'];
// //     products = Product.fromJson(json['product']);
// //   }
// // }

// // class Product {
// //   int? productId;
// //   String image = '';
// //   dynamic price;
// //   dynamic oldPrice;
// //   dynamic discount;
// //   Product.fromJson(Map<String, dynamic> json) {
// //     productId = json['id'];
// //     image = json['image'];
// //     price = json['price'];
// //     oldPrice = json['old_price'];
// //     discount = json['discount'];
// //   }
// // }

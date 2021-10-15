class SearchModel {
  bool? status;
  dynamic? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
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

class Product {
  int? productId;
  String image = '';
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  Product.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
  }
}

class Getshoplistmodel {
  String? status;
  String? message;
  List<ShopLists>? shopLists;

  Getshoplistmodel({this.status, this.message, this.shopLists});

  Getshoplistmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['shopLists'] != null) {
      shopLists = <ShopLists>[];
      json['shopLists'].forEach((v) {
        shopLists!.add(new ShopLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopLists != null) {
      data['shopLists'] = this.shopLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopLists {
  String? id;
  String? serviceName;
  String? price;
  String? shopId;
  String? category;
  String? saloonName;
  String? ownerId;
  String? image;

  ShopLists(
      {this.id,
        this.serviceName,
        this.price,
        this.shopId,
        this.category,
        this.saloonName,
        this.ownerId,
        this.image});

  ShopLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    price = json['price'];
    shopId = json['shop_id'];
    category = json['category'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['price'] = this.price;
    data['shop_id'] = this.shopId;
    data['category'] = this.category;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    return data;
  }
}

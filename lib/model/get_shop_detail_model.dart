class Getshopdetailmodel {
  String? status;
  String? message;
  ShopDetails? shopDetails;
  List<ShopServiceList>? shopServiceList;

  Getshopdetailmodel(
      {this.status, this.message, this.shopDetails, this.shopServiceList});

  Getshopdetailmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopDetails = json['shopDetails'] != null
        ? new ShopDetails.fromJson(json['shopDetails'])
        : null;
    if (json['shopServiceList'] != null) {
      shopServiceList = <ShopServiceList>[];
      json['shopServiceList'].forEach((v) {
        shopServiceList!.add(new ShopServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopDetails != null) {
      data['shopDetails'] = this.shopDetails!.toJson();
    }
    if (this.shopServiceList != null) {
      data['shopServiceList'] =
          this.shopServiceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDetails {
  String? shopId;
  String? saloonName;
  String? ownerId;
  String? image;

  ShopDetails({this.shopId, this.saloonName, this.ownerId, this.image});

  ShopDetails.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    return data;
  }
}

class ShopServiceList {
  String? id;
  String? serviceName;
  String? price;
  String? shopId;

  ShopServiceList({this.id, this.serviceName, this.price, this.shopId});

  ShopServiceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    price = json['price'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['price'] = this.price;
    data['shop_id'] = this.shopId;
    return data;
  }
}

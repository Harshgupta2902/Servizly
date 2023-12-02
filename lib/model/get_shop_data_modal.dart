class GetShopDataModal {
  String? status;
  String? message;
  ShopData? shopData;
  List<ShopTiming>? shopTiming;

  GetShopDataModal({this.status, this.message, this.shopData, this.shopTiming});

  GetShopDataModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopData = json['ShopData'] != null
        ? new ShopData.fromJson(json['ShopData'])
        : null;
    if (json['ShopTiming'] != null) {
      shopTiming = <ShopTiming>[];
      json['ShopTiming'].forEach((v) {
        shopTiming!.add(new ShopTiming.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopData != null) {
      data['ShopData'] = this.shopData!.toJson();
    }
    if (this.shopTiming != null) {
      data['ShopTiming'] = this.shopTiming!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopData {
  String? shopId;
  String? saloonName;
  String? ownerId;
  String? image;
  String? address;

  ShopData(
      {this.shopId, this.saloonName, this.ownerId, this.image, this.address});

  ShopData.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}

class ShopTiming {
  String? id;
  String? shopId;
  String? days;
  String? timing;

  ShopTiming({this.id, this.shopId, this.days, this.timing});

  ShopTiming.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    days = json['days'];
    timing = json['timing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['days'] = this.days;
    data['timing'] = this.timing;
    return data;
  }
}


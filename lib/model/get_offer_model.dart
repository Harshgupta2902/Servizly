class GetOfferModel {
  String? status;
  String? message;
  List<ShopList>? shopList;

  GetOfferModel({this.status, this.message, this.shopList});

  GetOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['shopList'] != null) {
      shopList = <ShopList>[];
      json['shopList'].forEach((v) {
        shopList!.add(new ShopList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopList != null) {
      data['shopList'] = this.shopList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopList {
  String? shopId;
  String? saloonName;
  String? ownerId;
  String? image;
  String? address;
  String? offerId;
  String? offer;
  String? description;
  String? rating;

  ShopList(
      {this.shopId,
        this.saloonName,
        this.ownerId,
        this.image,
        this.address,
        this.offerId,
        this.offer,
        this.description,
        this.rating});

  ShopList.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
    address = json['address'];
    offerId = json['offer_id'];
    offer = json['offer'];
    description = json['description'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    data['address'] = this.address;
    data['offer_id'] = this.offerId;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['rating'] = this.rating;
    return data;
  }
}

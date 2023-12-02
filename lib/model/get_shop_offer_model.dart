class GetShopOfferModel {
  String? status;
  String? message;
  List<OfferList>? offerList;

  GetShopOfferModel({this.status, this.message, this.offerList});

  GetShopOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['offerList'] != null) {
      offerList = <OfferList>[];
      json['offerList'].forEach((v) {
        offerList!.add(new OfferList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.offerList != null) {
      data['offerList'] = this.offerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferList {
  String? offerId;
  String? offer;
  String? description;
  String? image;
  String? shopId;
  String? offerOff;
  String? off;

  OfferList(
      {this.offerId,
        this.offer,
        this.description,
        this.image,
        this.shopId,
        this.offerOff,
        this.off});

  OfferList.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offer = json['offer'];
    description = json['description'];
    image = json['image'];
    shopId = json['shop_id'];
    offerOff = json['offer_off'];
    off = json['off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['image'] = this.image;
    data['shop_id'] = this.shopId;
    data['offer_off'] = this.offerOff;
    data['off'] = this.off;
    return data;
  }
}


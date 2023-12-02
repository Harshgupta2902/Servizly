class GetCartDetailsModel {
  String? status;
  String? message;
  List<CartData>? cartData;
  String? totalServices;
  List<String>? serviceList;
  List<String>? servicePrice;
  String? totalAmount;
  String? couponApplied;
  String? totalDiscount;
  String? totalTax;
  String? sum;
  Coupons? coupons;

  GetCartDetailsModel(
      {this.status,
        this.message,
        this.cartData,
        this.totalServices,
        this.serviceList,
        this.servicePrice,
        this.totalAmount,
        this.couponApplied,
        this.totalDiscount,
        this.totalTax,
        this.sum,
        this.coupons});

  GetCartDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['cartData'] != null) {
      cartData = <CartData>[];
      json['cartData'].forEach((v) {
        cartData!.add(new CartData.fromJson(v));
      });
    }
    totalServices = json['totalServices'];
    serviceList = json['serviceList'].cast<String>();
    servicePrice = json['servicePrice'].cast<String>();
    totalAmount = json['totalAmount'];
    couponApplied = json['couponApplied'];
    totalDiscount = json['totalDiscount'];
    totalTax = json['totalTax'];
    sum = json['sum'];
    coupons =
    json['coupons'] != null ? new Coupons.fromJson(json['coupons']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartData != null) {
      data['cartData'] = this.cartData!.map((v) => v.toJson()).toList();
    }
    data['totalServices'] = this.totalServices;
    data['serviceList'] = this.serviceList;
    data['servicePrice'] = this.servicePrice;
    data['totalAmount'] = this.totalAmount;
    data['couponApplied'] = this.couponApplied;
    data['totalDiscount'] = this.totalDiscount;
    data['totalTax'] = this.totalTax;
    data['sum'] = this.sum;
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.toJson();
    }
    return data;
  }
}

class CartData {
  String? cartId;
  String? userId;
  String? shopId;
  String? serviceId;
  String? timestamp;
  String? coupon;
  ServiceDetails? serviceDetails;

  CartData(
      {this.cartId,
        this.userId,
        this.shopId,
        this.serviceId,
        this.timestamp,
        this.coupon,
        this.serviceDetails});

  CartData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    serviceId = json['service_id'];
    timestamp = json['timestamp'];
    coupon = json['coupon'];
    serviceDetails = json['serviceDetails'] != null
        ? new ServiceDetails.fromJson(json['serviceDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['service_id'] = this.serviceId;
    data['timestamp'] = this.timestamp;
    data['coupon'] = this.coupon;
    if (this.serviceDetails != null) {
      data['serviceDetails'] = this.serviceDetails!.toJson();
    }
    return data;
  }
}

class ServiceDetails {
  String? id;
  String? serviceName;
  String? price;
  String? shopId;
  String? category;
  String? serviceId;

  ServiceDetails(
      {this.id,
        this.serviceName,
        this.price,
        this.shopId,
        this.category,
        this.serviceId});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    price = json['price'];
    shopId = json['shop_id'];
    category = json['category'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['price'] = this.price;
    data['shop_id'] = this.shopId;
    data['category'] = this.category;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class Coupons {
  String? offerId;
  String? offer;
  String? description;
  String? image;
  String? shopId;
  String? offerOff;

  Coupons(
      {this.offerId,
        this.offer,
        this.description,
        this.image,
        this.shopId,
        this.offerOff});

  Coupons.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offer = json['offer'];
    description = json['description'];
    image = json['image'];
    shopId = json['shop_id'];
    offerOff = json['offer_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['image'] = this.image;
    data['shop_id'] = this.shopId;
    data['offer_off'] = this.offerOff;
    return data;
  }
}

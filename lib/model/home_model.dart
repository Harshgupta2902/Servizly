class HomeModel {
  String? status;
  String? message;
  List<Booking>? booking;
  List<Services>? services;
  List<Offers>? offers;
  String? totalAmount;
  ShopDetails? shopDetails;
  List<TopSaloon>? topSaloon;
  String? serviceCount;
  String? unconfirmedBooking;

  HomeModel(
      {this.status,
        this.message,
        this.booking,
        this.services,
        this.offers,
        this.totalAmount,
        this.shopDetails,
        this.topSaloon,
        this.serviceCount,
        this.unconfirmedBooking});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
    if (json['Services'] != null) {
      services = <Services>[];
      json['Services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['Offers'] != null) {
      offers = <Offers>[];
      json['Offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    shopDetails = json['shopDetails'] != null
        ? new ShopDetails.fromJson(json['shopDetails'])
        : null;
    if (json['TopSaloon'] != null) {
      topSaloon = <TopSaloon>[];
      json['TopSaloon'].forEach((v) {
        topSaloon!.add(new TopSaloon.fromJson(v));
      });
    }
    serviceCount = json['serviceCount'];
    unconfirmedBooking = json['unconfirmedBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['Services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['Offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = this.totalAmount;
    if (this.shopDetails != null) {
      data['shopDetails'] = this.shopDetails!.toJson();
    }
    if (this.topSaloon != null) {
      data['TopSaloon'] = this.topSaloon!.map((v) => v.toJson()).toList();
    }
    data['serviceCount'] = this.serviceCount;
    data['unconfirmedBooking'] = this.unconfirmedBooking;
    return data;
  }
}

class Booking {
  String? cartId;
  String? userId;
  String? shopId;
  String? serviceId;
  String? timestamp;
  String? coupon;

  Booking(
      {this.cartId,
        this.userId,
        this.shopId,
        this.serviceId,
        this.timestamp,
        this.coupon});

  Booking.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    serviceId = json['service_id'];
    timestamp = json['timestamp'];
    coupon = json['coupon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['service_id'] = this.serviceId;
    data['timestamp'] = this.timestamp;
    data['coupon'] = this.coupon;
    return data;
  }
}

class Services {
  String? serviceId;
  String? services;
  String? images;

  Services({this.serviceId, this.services, this.images});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    services = json['services'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['services'] = this.services;
    data['images'] = this.images;
    return data;
  }
}

class Offers {
  String? offerId;
  String? offer;
  String? description;
  String? image;
  String? shopId;
  String? offerOff;
  String? saloonName;
  String? address;
  String? shopImage;

  Offers(
      {this.offerId,
        this.offer,
        this.description,
        this.image,
        this.shopId,
        this.offerOff,
        this.saloonName,
        this.address,
        this.shopImage});

  Offers.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    offer = json['offer'];
    description = json['description'];
    image = json['image'];
    shopId = json['shop_id'];
    offerOff = json['offer_off'];
    saloonName = json['saloon_name'];
    address = json['address'];
    shopImage = json['shop_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['image'] = this.image;
    data['shop_id'] = this.shopId;
    data['offer_off'] = this.offerOff;
    data['saloon_name'] = this.saloonName;
    data['address'] = this.address;
    data['shop_image'] = this.shopImage;
    return data;
  }
}

class ShopDetails {
  String? shopId;
  String? saloonName;
  String? ownerId;
  String? image;
  String? address;
  String? agentId;

  ShopDetails(
      {this.shopId,
        this.saloonName,
        this.ownerId,
        this.image,
        this.address,
        this.agentId});

  ShopDetails.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
    address = json['address'];
    agentId = json['agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    data['address'] = this.address;
    data['agent_id'] = this.agentId;
    return data;
  }
}

class TopSaloon {
  String? id;
  String? shopId;
  String? duration;
  String? timestamp;
  String? saloonName;
  String? address;
  String? shopImage;

  TopSaloon(
      {this.id,
        this.shopId,
        this.duration,
        this.timestamp,
        this.saloonName,
        this.address,
        this.shopImage});

  TopSaloon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    duration = json['duration'];
    timestamp = json['timestamp'];
    saloonName = json['saloon_name'];
    address = json['address'];
    shopImage = json['shop_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['duration'] = this.duration;
    data['timestamp'] = this.timestamp;
    data['saloon_name'] = this.saloonName;
    data['address'] = this.address;
    data['shop_image'] = this.shopImage;
    return data;
  }
}

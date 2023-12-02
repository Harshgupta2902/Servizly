class GetPortfolio {
  String? status;
  String? message;
  List<Portfolio>? portfolio;

  GetPortfolio({this.status, this.message, this.portfolio});

  GetPortfolio.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['portfolio'] != null) {
      portfolio = <Portfolio>[];
      json['portfolio'].forEach((v) {
        portfolio!.add(new Portfolio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Portfolio {
  String? galleryId;
  String? image;
  String? shopId;

  Portfolio({this.galleryId, this.image, this.shopId});

  Portfolio.fromJson(Map<String, dynamic> json) {
    galleryId = json['gallery_id'];
    image = json['image'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gallery_id'] = this.galleryId;
    data['image'] = this.image;
    data['shop_id'] = this.shopId;
    return data;
  }
}

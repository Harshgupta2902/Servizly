class GetReviewModel {
  String? status;
  String? message;
  List<UserReviews>? userReviews;

  GetReviewModel({this.status, this.message, this.userReviews});

  GetReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['userReviews'] != null) {
      userReviews = <UserReviews>[];
      json['userReviews'].forEach((v) {
        userReviews!.add(new UserReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userReviews != null) {
      data['userReviews'] = this.userReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserReviews {
  String? id;
  String? rating;
  String? comment;
  String? shopId;
  String? userId;
  String? saloonName;
  String? ownerId;
  String? image;

  UserReviews(
      {this.id,
        this.rating,
        this.comment,
        this.shopId,
        this.userId,
        this.saloonName,
        this.ownerId,
        this.image});

  UserReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    shopId = json['shop_id'];
    userId = json['user_id'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['shop_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    return data;
  }
}

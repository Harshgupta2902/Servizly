class ReviewModal {
  String? status;
  String? message;
  List<ReviewList>? reviewList;
  String? averageRating;
  String? totalReview;

  ReviewModal(
      {this.status,
        this.message,
        this.reviewList,
        this.averageRating,
        this.totalReview});

  ReviewModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['ReviewList'] != null) {
      reviewList = <ReviewList>[];
      json['ReviewList'].forEach((v) {
        reviewList!.add(new ReviewList.fromJson(v));
      });
    }
    averageRating = json['AverageRating'];
    totalReview = json['totalReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reviewList != null) {
      data['ReviewList'] = this.reviewList!.map((v) => v.toJson()).toList();
    }
    data['AverageRating'] = this.averageRating;
    data['totalReview'] = this.totalReview;
    return data;
  }
}

class ReviewList {
  String? reviewId;
  String? rating;
  String? comment;
  String? userId;
  String? shopId;
  String? image;
  String? timestamp;
  String? serviceComment;
  String? name;

  ReviewList(
      {this.reviewId,
        this.rating,
        this.comment,
        this.userId,
        this.shopId,
        this.image,
        this.timestamp,
        this.serviceComment,
        this.name});

  ReviewList.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    rating = json['rating'];
    comment = json['comment'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    image = json['image'];
    timestamp = json['timestamp'];
    serviceComment = json['serviceComment'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['image'] = this.image;
    data['timestamp'] = this.timestamp;
    data['serviceComment'] = this.serviceComment;
    data['name'] = this.name;
    return data;
  }
}

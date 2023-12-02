class GetCardDetailsModel {
  String? status;
  String? message;
  List<CardDetails>? cardDetails;

  GetCardDetailsModel({this.status, this.message, this.cardDetails});

  GetCardDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['cardDetails'] != null) {
      cardDetails = <CardDetails>[];
      json['cardDetails'].forEach((v) {
        cardDetails!.add(new CardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cardDetails != null) {
      data['cardDetails'] = this.cardDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetails {
  String? cardId;
  String? cardnumber;
  String? holderName;
  String? expiryDate;
  String? userId;

  CardDetails(
      {this.cardId,
        this.cardnumber,
        this.holderName,
        this.expiryDate,
        this.userId});

  CardDetails.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    cardnumber = json['cardnumber'];
    holderName = json['holderName'];
    expiryDate = json['expiryDate'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['cardnumber'] = this.cardnumber;
    data['holderName'] = this.holderName;
    data['expiryDate'] = this.expiryDate;
    data['user_id'] = this.userId;
    return data;
  }
}

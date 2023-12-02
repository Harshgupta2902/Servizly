class GetBookTotal {
  String? status;
  String? message;
  String? bookingFound;
  String? bookingID;
  List<String>? price;
  List<String>? servicesBooked;
  String? serviceCount;
  String? amount;

  GetBookTotal(
      {this.status,
        this.message,
        this.bookingFound,
        this.bookingID,
        this.price,
        this.servicesBooked,
        this.serviceCount,
        this.amount});

  GetBookTotal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingFound = json['bookingFound'];
    bookingID = json['booking_ID'];
    price = json['price'].cast<String>();
    servicesBooked = json['servicesBooked'].cast<String>();
    serviceCount = json['serviceCount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['bookingFound'] = this.bookingFound;
    data['booking_ID'] = this.bookingID;
    data['price'] = this.price;
    data['servicesBooked'] = this.servicesBooked;
    data['serviceCount'] = this.serviceCount;
    data['amount'] = this.amount;
    return data;
  }
}

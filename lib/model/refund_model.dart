class RefundModel {
  String? status;
  String? message;
  List<BookingList>? bookingList;

  RefundModel({this.status, this.message, this.bookingList});

  RefundModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['bookingList'] != null) {
      bookingList = <BookingList>[];
      json['bookingList'].forEach((v) {
        bookingList!.add(new BookingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.bookingList != null) {
      data['bookingList'] = this.bookingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingList {
  String? bookingId;
  String? shopId;
  String? service;
  String? timestamp;
  String? appointmentDate;
  String? time;
  String? isApproved;
  String? isCancelled;
  String? amount;
  String? isCompleted;
  String? userId;
  String? cancelReason;
  String? rescheduleReason;
  String? userConfirmed;
  String? servicePrice;
  String? note;
  String? saloonName;
  String? image;

  BookingList(
      {this.bookingId,
        this.shopId,
        this.service,
        this.timestamp,
        this.appointmentDate,
        this.time,
        this.isApproved,
        this.isCancelled,
        this.amount,
        this.isCompleted,
        this.userId,
        this.cancelReason,
        this.rescheduleReason,
        this.userConfirmed,
        this.servicePrice,
        this.note,
        this.saloonName,
        this.image});

  BookingList.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    shopId = json['shop_id'];
    service = json['service'];
    timestamp = json['timestamp'];
    appointmentDate = json['AppointmentDate'];
    time = json['time'];
    isApproved = json['is_approved'];
    isCancelled = json['is_cancelled'];
    amount = json['amount'];
    isCompleted = json['is_completed'];
    userId = json['user_id'];
    cancelReason = json['cancelReason'];
    rescheduleReason = json['rescheduleReason'];
    userConfirmed = json['userConfirmed'];
    servicePrice = json['servicePrice'];
    note = json['note'];
    saloonName = json['saloon_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['shop_id'] = this.shopId;
    data['service'] = this.service;
    data['timestamp'] = this.timestamp;
    data['AppointmentDate'] = this.appointmentDate;
    data['time'] = this.time;
    data['is_approved'] = this.isApproved;
    data['is_cancelled'] = this.isCancelled;
    data['amount'] = this.amount;
    data['is_completed'] = this.isCompleted;
    data['user_id'] = this.userId;
    data['cancelReason'] = this.cancelReason;
    data['rescheduleReason'] = this.rescheduleReason;
    data['userConfirmed'] = this.userConfirmed;
    data['servicePrice'] = this.servicePrice;
    data['note'] = this.note;
    data['saloon_name'] = this.saloonName;
    data['image'] = this.image;
    return data;
  }
}

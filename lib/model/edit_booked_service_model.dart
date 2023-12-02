class EditBookedServiceModel {
  String? status;
  String? message;
  BookingDetails? bookingDetails;
  List<String>? servicesBooked;
  List<String>? price;

  EditBookedServiceModel(
      {this.status,
        this.message,
        this.bookingDetails,
        this.servicesBooked,
        this.price});

  EditBookedServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingDetails = json['bookingDetails'] != null
        ? new BookingDetails.fromJson(json['bookingDetails'])
        : null;
    servicesBooked = json['servicesBooked'].cast<String>();
    price = json['price'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.bookingDetails != null) {
      data['bookingDetails'] = this.bookingDetails!.toJson();
    }
    data['servicesBooked'] = this.servicesBooked;
    data['price'] = this.price;
    return data;
  }
}

class BookingDetails {
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
  String? coupon;
  String? location;
  String? address;
  String? saloonName;
  String? ownerId;
  String? image;

  BookingDetails(
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
        this.coupon,
        this.location,
        this.address,
        this.saloonName,
        this.ownerId,
        this.image});

  BookingDetails.fromJson(Map<String, dynamic> json) {
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
    coupon = json['coupon'];
    location = json['location'];
    address = json['address'];
    saloonName = json['saloon_name'];
    ownerId = json['owner_id'];
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
    data['coupon'] = this.coupon;
    data['location'] = this.location;
    data['address'] = this.address;
    data['saloon_name'] = this.saloonName;
    data['owner_id'] = this.ownerId;
    data['image'] = this.image;
    return data;
  }
}

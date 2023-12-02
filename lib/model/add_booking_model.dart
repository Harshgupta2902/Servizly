class AddBookingModel {
  String? status;
  String? message;
  int? bookingId;

  AddBookingModel({this.status, this.message, this.bookingId});

  AddBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['booking_id'] = this.bookingId;
    return data;
  }
}

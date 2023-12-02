class BookingConfirmedModel {
  String? status;
  String? message;

  BookingConfirmedModel({this.status, this.message});

  BookingConfirmedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

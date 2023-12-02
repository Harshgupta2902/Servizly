class EditModel {
  String? status;
  String? message;
  Data? data;

  EditModel({this.status, this.message, this.data});

  EditModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? phone;
  String? email;
  String? deviceToken;
  String? image;
  String? otp;
  String? isVerified;
  String? isActive;

  Data(
      {this.userId,
        this.name,
        this.phone,
        this.email,
        this.deviceToken,
        this.image,
        this.otp,
        this.isVerified,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    deviceToken = json['device_token'];
    image = json['image'];
    otp = json['otp'];
    isVerified = json['isVerified'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['device_token'] = this.deviceToken;
    data['image'] = this.image;
    data['otp'] = this.otp;
    data['isVerified'] = this.isVerified;
    data['is_active'] = this.isActive;
    return data;
  }
}

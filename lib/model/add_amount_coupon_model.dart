class AddAmountCouponModel {
  String? status;
  String? message;

  AddAmountCouponModel({this.status, this.message});

  AddAmountCouponModel.fromJson(Map<String, dynamic> json) {
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

class GetAddressModel {
  String? status;
  String? message;
  List<AddressList>? addressList;

  GetAddressModel({this.status, this.message, this.addressList});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['addressList'] != null) {
      addressList = <AddressList>[];
      json['addressList'].forEach((v) {
        addressList!.add(new AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.addressList != null) {
      data['addressList'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  String? id;
  String? userId;
  String? flatNumber;
  String? landmark;
  String? type;
  String? contact;

  AddressList(
      {this.id,
        this.userId,
        this.flatNumber,
        this.landmark,
        this.type,
        this.contact});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    flatNumber = json['flatNumber'];
    landmark = json['landmark'];
    type = json['type'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['flatNumber'] = this.flatNumber;
    data['landmark'] = this.landmark;
    data['type'] = this.type;
    data['contact'] = this.contact;
    return data;
  }
}

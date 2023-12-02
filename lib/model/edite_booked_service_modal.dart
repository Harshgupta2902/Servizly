class EditeBookedService {
  String? data;
  String? message;

  EditeBookedService({this.data, this.message});

  EditeBookedService.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}

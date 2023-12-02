class GetServicelistModel {
  String? status;
  String? message;
  List<ServicesList>? servicesList;

  GetServicelistModel({this.status, this.message, this.servicesList});

  GetServicelistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['servicesList'] != null) {
      servicesList = <ServicesList>[];
      json['servicesList'].forEach((v) {
        servicesList!.add(new ServicesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.servicesList != null) {
      data['servicesList'] = this.servicesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesList {
  String? serviceId;
  String? services;
  String? images;

  ServicesList({this.serviceId, this.services, this.images});

  ServicesList.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    services = json['services'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['services'] = this.services;
    data['images'] = this.images;
    return data;
  }
}

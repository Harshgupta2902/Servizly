class AboutModel {
  String? status;
  String? message;
  List<About>? about;

  AboutModel({this.status, this.message, this.about});

  AboutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['About'] != null) {
      about = <About>[];
      json['About'].forEach((v) {
        about!.add(new About.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.about != null) {
      data['About'] = this.about!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class About {
  String? id;
  String? about;

  About({this.id, this.about});

  About.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    return data;
  }
}

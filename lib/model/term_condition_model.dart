class TermConditionModel {
  String? status;
  String? message;
  List<Terms>? terms;

  TermConditionModel({this.status, this.message, this.terms});

  TermConditionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Terms'] != null) {
      terms = <Terms>[];
      json['Terms'].forEach((v) {
        terms!.add(new Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.terms != null) {
      data['Terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Terms {
  String? id;
  String? terms;

  Terms({this.id, this.terms});

  Terms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['terms'] = this.terms;
    return data;
  }
}

class DateAndTime {
  String? status;
  String? message;
  List<DatesList>? datesList;
  CurrentDate? currentDate;

  DateAndTime({this.status, this.message, this.datesList, this.currentDate});

  DateAndTime.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['DatesList'] != null) {
      datesList = <DatesList>[];
      json['DatesList'].forEach((v) {
        datesList!.add(new DatesList.fromJson(v));
      });
    }
    currentDate = json['CurrentDate'] != null
        ? new CurrentDate.fromJson(json['CurrentDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datesList != null) {
      data['DatesList'] = this.datesList!.map((v) => v.toJson()).toList();
    }
    if (this.currentDate != null) {
      data['CurrentDate'] = this.currentDate!.toJson();
    }
    return data;
  }
}

class DatesList {
  String? date;
  String? day;
  String? newFormat;

  DatesList({this.date, this.day, this.newFormat});

  DatesList.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    day = json['day'];
    newFormat = json['newFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['day'] = this.day;
    data['newFormat'] = this.newFormat;
    return data;
  }
}

class CurrentDate {
  String? date;
  String? day;
  String? newFormat;

  CurrentDate({this.date, this.day, this.newFormat});

  CurrentDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    newFormat = json['newFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['newFormat'] = this.newFormat;
    return data;
  }
}

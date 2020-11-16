class FligtsMapModel {
  String country;
  double lat;
  double long;

  FligtsMapModel({this.country, this.lat, this.long});

  FligtsMapModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
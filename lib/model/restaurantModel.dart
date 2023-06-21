class Resturant {
  var resId;
  String? resName;
  String? resDes;
  String? resImage;
  String? resPrice;
  String? resProfile;

  Resturant(
      {this.resId,
      this.resName,
      this.resDes,
      this.resImage,
      this.resPrice,
      this.resProfile});

  Resturant.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    resName = json['res_name'];
    resDes = json['res_des'];
    resImage = json['res_image'];
    resPrice = json['res_price'];
    resProfile = json['res_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['res_name'] = this.resName;
    data['res_des'] = this.resDes;
    data['res_image'] = this.resImage;
    data['res_price'] = this.resPrice;
    data['res_profile'] = this.resProfile;
    return data;
  }
}

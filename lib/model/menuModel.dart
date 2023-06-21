class MenuModel {
  var foodId;
  String? foodName;
  String? foodDes;
  String? foodImage;
  var foodPrice;
  var foodBigPrice;
  var resId;

  MenuModel(
      {this.foodId,
      this.foodName,
      this.foodDes,
      this.foodImage,
      this.foodPrice,
      this.foodBigPrice,
      this.resId});

  MenuModel.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    foodName = json['food_name'];
    foodDes = json['food_des'];
    foodImage = json['food_image'];
    foodPrice = json['food_price'];
    foodBigPrice = json['food_big_price'];
    resId = json['res_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_id'] = this.foodId;
    data['food_name'] = this.foodName;
    data['food_des'] = this.foodDes;
    data['food_image'] = this.foodImage;
    data['food_price'] = this.foodPrice;
    data['food_big_price'] = this.foodBigPrice;
    data['res_id'] = this.resId;
    return data;
  }
}

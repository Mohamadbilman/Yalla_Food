class SearchModel {
  var foodprice;
  var countfood;
  var cardId;
  var cardUser;
  var cardFood;
  var cardOrder;
  var foodId;
  String? foodName;
  String? foodDes;
  String? foodImage;
  String? foodPrice;
  var resid;
  var resId;
  String? resName;
  String? resDes;
  String? resImage;
  String? resTel;
  String? resPrice;
  String? resProfile;

  SearchModel(
      {this.foodprice,
      this.countfood,
      this.cardId,
      this.cardUser,
      this.cardFood,
      this.cardOrder,
      this.foodId,
      this.foodName,
      this.foodDes,
      this.foodImage,
      this.foodPrice,
      this.resid,
      this.resId,
      this.resName,
      this.resDes,
      this.resImage,
      this.resTel,
      this.resPrice,
      this.resProfile});

  SearchModel.fromJson(Map<String, dynamic> json) {
    foodprice = json['foodprice'];
    countfood = json['countfood'];
    cardId = json['card_id'];
    cardUser = json['card_user'];
    cardFood = json['card_food'];
    cardOrder = json['card_order'];
    foodId = json['food_id'];
    foodName = json['food_name'];
    foodDes = json['food_des'];
    foodImage = json['food_image'];
    foodPrice = json['food_price'];
    resid = json['resid'];
    resId = json['res_id'];
    resName = json['res_name'];
    resDes = json['res_des'];
    resImage = json['res_image'];
    resTel = json['res_tel'];
    resPrice = json['res_price'];
    resProfile = json['res_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodprice'] = this.foodprice;
    data['countfood'] = this.countfood;
    data['card_id'] = this.cardId;
    data['card_user'] = this.cardUser;
    data['card_food'] = this.cardFood;
    data['card_order'] = this.cardOrder;
    data['food_id'] = this.foodId;
    data['food_name'] = this.foodName;
    data['food_des'] = this.foodDes;
    data['food_image'] = this.foodImage;
    data['food_price'] = this.foodPrice;
    data['resid'] = this.resid;
    data['res_id'] = this.resId;
    data['res_name'] = this.resName;
    data['res_des'] = this.resDes;
    data['res_image'] = this.resImage;
    data['res_tel'] = this.resTel;
    data['res_price'] = this.resPrice;
    data['res_profile'] = this.resProfile;
    return data;
  }
}

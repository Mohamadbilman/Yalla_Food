class CardModel {
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

  CardModel(
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
      this.resid});

  CardModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

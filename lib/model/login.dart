class LoginModel {
  var userId;
  String? userName;
  String? userEmail;
  String? userPass;

  LoginModel({this.userId, this.userName, this.userEmail, this.userPass});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPass = json['user_pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_pass'] = this.userPass;
    return data;
  }
}

class UserModel {

  String id = "";
  String email = "";
  String displayName = "";

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        displayName = json["displayName"],
        id = json["id"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "displayName": displayName
  };

}
class LoginModel {
  bool status;
  String message;
  UserData data;
  LoginModel.fromJson(Map<String,dynamic>Json){
    status=Json['status'];
    message=Json['message'];
    data=Json['data']!=null?UserData.fromJson(Json['data']):null;
    

  }
}
class UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int credit;
  int points;
  String token;
   UserData.fromJson(Map<String,dynamic>Json){
    id=Json['id'];
    name=Json['name'];
    email=Json['email'];
    phone=Json['phone'];
    image=Json['image'];
    credit=Json['credit'];
    points=Json['points'];
    token=Json['token'];
    

  }

}
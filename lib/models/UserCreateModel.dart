class CreateUserModel{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  CreateUserModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.uid,

  });

  CreateUserModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    password=json['pass'];
    phone=json['phone'];
    uid=json['uid'];
  }
  Map<String,dynamic> tojson(){
    return {
      'name' : name,
      'email' : email,
      'pass' : password,
      'phone' : phone,
      'uid' : uid,
    };
  }
}
class CreateUserModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  String? image;
  String? ImageBackGround;
  String? bio;

  CreateUserModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.uid,
    this.image,
    this.ImageBackGround,
    this.bio,
  });

  CreateUserModel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    password = json?['pass'];
    phone = json?['phone'];
    uid = json?['uid'];
    image = json?['image'];
    ImageBackGround = json?['ImageBackGround'];
    bio = json?['bio'];
  }

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'email': email,
      'pass': password,
      'phone': phone,
      'uid': uid,
      'image': image,
      'ImageBackGround': ImageBackGround,
      'bio': bio,
    };
  }
}

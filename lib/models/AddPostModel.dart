class AddPostModel {
  String? MyImage;
  String? MyText;
  String? PostImage;
  String? MyName;
  String? Time;
  String? uid;
  int? postindex;

  AddPostModel(
      {this.MyImage,
      this.MyName,
      this.Time,
      this.MyText,
      this.PostImage,
      this.uid,
      this.postindex,
      });

  AddPostModel.fromjson(Map<String, dynamic>? json) {
    MyImage = json?['MyImage'];
    MyName = json?['MyName'];
    Time = json?['Time'];
    MyText = json?['MyText'];
    PostImage = json?['PostImage'];
    uid = json?['uid'];
    postindex = json?['postindex'];
  }
  Map<String, dynamic> tojson() {
    return {
      'MyImage': MyImage,
      'MyName': MyName,
      'Time': Time,
      'MyText': MyText,
      'PostImage': PostImage,
      'uid': uid,
      'postindex': postindex,
    };
  }
}

class MessageModel {
  String? SenderId;
  String? ReceiverId;
  String? DateTime;
  String? Text;
  String? Image;

  MessageModel({
    this.SenderId,
    this.ReceiverId,
    this.DateTime,
    this.Text,
    this.Image,
  });

  MessageModel.fromjson(Map<String, dynamic>? json) {
    SenderId = json?['SenderId'];
    ReceiverId = json?['ReceiverId'];
    DateTime = json?['DateTime'];
    Text = json?['Text'];
    Image = json?['Image'];
  }

  Map<String, dynamic> tojson() {
    return {
      'SenderId': SenderId,
      'ReceiverId': ReceiverId,
      'DateTime': DateTime,
      'Text': Text,
      'Image': Image,
    };
  }
}

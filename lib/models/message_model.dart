class MessageModel {
  String? SenderId;
  String? ReceiverId;
  String? DateTime;
  String? Text;

  MessageModel({
    this.SenderId,
    this.ReceiverId,
    this.DateTime,
    this.Text,

  });

  MessageModel.fromjson(Map<String, dynamic>? json) {
    SenderId = json?['SenderId'];
    ReceiverId = json?['ReceiverId'];
    DateTime = json?['DateTime'];
    Text = json?['Text'];

  }
  Map<String, dynamic> tojson() {
    return {
      'SenderId': SenderId,
      'ReceiverId': ReceiverId,
      'DateTime': DateTime,
      'Text': Text,

    };
  }
}

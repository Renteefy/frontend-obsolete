class Message {
  String message;
  String sender;
  String receiver;
  String time;
  String chatID;

  Message({this.message, this.sender, this.receiver, this.time, this.chatID});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sender = json['sender'];
    receiver = json['receiver'];
    time = json['time'];
    chatID = json['chatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['time'] = this.time;
    return data;
  }
}

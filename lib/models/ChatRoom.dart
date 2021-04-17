class ChatRoom {
  String user1;
  String user2;
  String chatID;

  ChatRoom({this.user1, this.user2, this.chatID});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    user1 = json['user1'];
    user2 = json['user2'];
    chatID = json['chatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user1'] = this.user1;
    data['user2'] = this.user2;
    data['chatID'] = this.chatID;
    return data;
  }
}

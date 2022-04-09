class Message {
  static const String collectionname='messages';
  String id;
  String content;
  DateTime dateTime;
  String senderid;
  String sendername;

  Message({required this.id,required this.content,required this.dateTime,required this.senderid,required this.sendername});
  Message.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    content: json['content'] as String,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
    senderid: json['senderid'] as String,
    sendername: json['sendername'] as String,);
  Map<String, dynamic> toJson() {
    return{
      'id':id,
      'content':content,
      'dateTime':dateTime.microsecondsSinceEpoch,
      'senderid':senderid,
      'sendername':sendername

    };
  }
}
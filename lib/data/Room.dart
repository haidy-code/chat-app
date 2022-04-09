class Room{
  static const String collectionname='room';
  String id;
  String roomname;
  String roomdesc;
  String categoryid;

  Room({required this.id,required this.roomname,required this.roomdesc,required this.categoryid});
  Room.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'] as String,
      roomname: json['roomname'] as String,
      roomdesc: json['roomdesc'] as String,
      categoryid: json['categoryid'] as String,);
  Map<String, dynamic> toJson() {
    return{
      'id':id,
      'roomname':roomname,
      'roomdesc':roomdesc,
      'categoryid':categoryid

    };
  }



}
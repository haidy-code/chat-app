import 'package:chat_project/data/Message.dart';
import 'package:chat_project/data/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'MyUser.dart';

CollectionReference<MyUser>getusercollectionwithconverter(){
  return FirebaseFirestore.instance.collection(MyUser.collectionname).
  withConverter(fromFirestore: ((snapshot, _) =>MyUser.fromJson(snapshot.data()!) ), toFirestore: (MyUser, _)=>MyUser.toJson());
}
CollectionReference<Room>getRoomcollectionwithconverter(){
  return FirebaseFirestore.instance.collection(Room.collectionname).
  withConverter(fromFirestore: ((snapshot, _) =>Room.fromJson(snapshot.data()!) ), toFirestore: (Room, _)=>Room.toJson());
}
CollectionReference<Message>getMessagecollectionwithconverter(String roomid){
  //gbt table bta3 room gbt document mo3ina mn rooms 3amlt tablr mn messages gwa room mo3ina
  return getRoomcollectionwithconverter().doc(roomid).collection(Message.collectionname).
  withConverter(fromFirestore: ((snapshot, _) =>Message.fromJson(snapshot.data()!) ), toFirestore: (Message, _)=>Message.toJson());
}
Future<void> addroomtofirestore(Room room){
  CollectionReference<Room>collectionReference=getRoomcollectionwithconverter();
  var docref=collectionReference.doc();
  room.id=docref.id;
  return docref.set(room);
}
Future<void> addmessagetofirestore(Message message,String roomid){

  var messagedocref=getMessagecollectionwithconverter(roomid).doc(); //3amlt tablr mn messages gwa room mo3ina
  message.id=messagedocref.id;
  return messagedocref.set(message);
}
Future<void> addusertofirestore(MyUser myUser){
  CollectionReference<MyUser>collectionReference=getusercollectionwithconverter();
 return collectionReference.doc(myUser.id).set(myUser);
}
Future<MyUser?> getuserbyid (String id ) async{
  CollectionReference<MyUser>collectionReference=getusercollectionwithconverter();
  var result=await collectionReference.doc(id).get();
  return result.data();
}

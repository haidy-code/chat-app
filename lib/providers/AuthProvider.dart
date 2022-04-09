import 'package:chat_project/data/FirebaseUtils.dart';
import 'package:chat_project/data/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{

  MyUser? user=null;
  void updateuser(MyUser user){
    this.user=user;
    notifyListeners();
  }
  bool isloggedin(){
    if(FirebaseAuth.instance.currentUser!=null)
      return true;
    return false;
  }
  void fetchfirestoreuser() async{
    if(FirebaseAuth.instance.currentUser!=null){
    var fire_user=await getuserbyid(FirebaseAuth.instance.currentUser!.uid);
    user=fire_user;}
  }
  void deleteuser(){
    this.user=null;
    notifyListeners();
  }

  AuthProvider(){
    fetchfirestoreuser();
  }
}
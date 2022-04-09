import 'package:chat_project/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/Message.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  late AuthProvider provider;


  MessageWidget({ required this.message});

  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
    return Container(


      child: message.senderid==provider.user!.id?SentMessage(message.content, DateFormat.jm().format(message.dateTime)):
      RecievedMessage(message.content,DateFormat.jm().format(message.dateTime) , message.sendername),
    );
  }
}
class SentMessage extends StatelessWidget{
  String content;
  String time;

  SentMessage (this.content, this.time);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Row(
      children: [ Expanded(child: Text(time ,textAlign: TextAlign.right,style: TextStyle(color: Colors.black),)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24) ,
              bottomLeft:Radius.circular(24) ,
              topLeft:Radius.circular(24) ,
              bottomRight: Radius.circular(0)
            ),
            color: Theme.of(context).primaryColor
          ),
          child: Text(content,textAlign: TextAlign.right,style: TextStyle(color: Colors.white), ),
        ),

      ],
    );
  }
}
class RecievedMessage extends StatelessWidget{
  String content;
  String time;
  String sendername;

  RecievedMessage(this.content, this.time,this.sendername);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sendername),
        Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24) ,
                        bottomLeft:Radius.circular(24) ,
                        topLeft:Radius.circular(0) ,
                        bottomRight: Radius.circular(24)
                    ),
                    color: Colors.black12
                ),
                child: Text(content,textAlign: TextAlign.right,style: TextStyle(color: Colors.white), ),
              ),
              Expanded(child: Text(time ,textAlign: TextAlign.left,style: TextStyle(color: Colors.black),)),
            ],
          ),
      ],
    );
  }
}

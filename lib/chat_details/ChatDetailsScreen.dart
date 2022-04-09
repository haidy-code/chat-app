import 'package:chat_project/chat_details/MessageWidget.dart';
import 'package:chat_project/data/FirebaseUtils.dart';
import 'package:chat_project/data/Message.dart';
import 'package:chat_project/data/Room.dart';
import 'package:chat_project/providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailsScreen extends StatefulWidget {
  static const String routename='chatdetails';

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late Room room;

  String message='';

  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    room=ModalRoute.of(context)!.settings.arguments as Room;
    provider=Provider.of<AuthProvider>(context);
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image:DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png')
            )
        ),
child: Scaffold(
  appBar: AppBar(title: Text(room.roomname),),
  body: Container(
    padding: EdgeInsets.all(12),
    child: Column(
      children: [
        Expanded(child: Container(
          child: StreamBuilder<QuerySnapshot<Message>>(
            stream: getMessagecollectionwithconverter(room.id).orderBy('dateTime',descending: false).snapshots(),
            builder:(con,snapshot){
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var messagelist =
              snapshot.data?.docs.map((e) => e.data()).toList();
              return Container( height: double.infinity,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, offset: Offset(4, 4))
                    ]),
                child: ListView.builder(itemBuilder: (contex,index){
                  return MessageWidget(message: messagelist![index]);
                },itemCount: messagelist?.length??0,),
              );


            } ,
          ),
        )),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: message),
                onChanged: (text){
                  message=text;
                },
                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12)
                    ),
                    borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid,width: 1)

                  ),
                  hintText: 'enter your message'
                ),
              ),
            ),
            SizedBox(width: 24,),
            ElevatedButton(onPressed: (){sendmessage();},
                child: Row(
                  children: [
                    Text('send'),
                    SizedBox(width: 10,),
                    Icon(Icons.send)
                  ],
                )
            )
          ],
        )
      ],
    ),
  ),
),
      ),
    );
  }

  void sendmessage() async {
    Message m=Message(id: '', content: message, dateTime: DateTime.now(), senderid: provider.user!.id, sendername: provider.user!.user_name);
  var res=await  addmessagetofirestore(m, room.id);

  setState(() {
    message='';//arga3 afady almessage tany
  });
  }
}

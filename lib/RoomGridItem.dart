import 'package:chat_project/chat_details/ChatDetailsScreen.dart';
import 'package:chat_project/Utils.dart';
import 'package:chat_project/data/Room.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoomGridItem extends StatelessWidget {
Room room;


RoomGridItem(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatDetailsScreen.routename,arguments: room);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black26,offset: Offset(4,1))
            ]

          ),
          child: Column(
            children: [
              Image.asset(Categories.fromid(room.categoryid).image),
              Text(
                room.roomname,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

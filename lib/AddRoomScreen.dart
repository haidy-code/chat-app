import 'package:chat_project/CategoriesBottomSheet.dart';
import 'package:chat_project/Utils.dart';
import 'package:chat_project/data/FirebaseUtils.dart';
import 'package:chat_project/data/Room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class AddRoomScreen extends StatefulWidget {
  static const String routename = 'addroom';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  String roomname='';

  String roomdescreption='';

  var formKey = GlobalKey<FormState>();

  Categories selectedcategory=categories_list[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png'))),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat App'),
          ),
          body: Container(
            height: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black26, offset: Offset(4, 4))
                ]),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Create new Room',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                  Image.asset('assets/images/room.png'),
                  Form(key: formKey
                      ,child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 8,),
                      TextFormField(
                        decoration: InputDecoration(labelText:'Room Name' ),
                        onChanged: (text){roomname=text;},
                        validator: (text){
                          if(text==null||text.isEmpty)
                            return 'plese enter room name';
                          return null;
                        },
                      ),
                      SizedBox(height: 4,),
                      TextFormField(
                        maxLines: 4,
                        minLines: 4,
                        decoration: InputDecoration(labelText:'Room Description' ),
                        onChanged: (text){roomdescreption=text;},
                        validator: (text){
                          if(text==null||text.isEmpty)
                            return 'plese enter room descreption';
                                return null;
                        },
                      ),

                      InkWell(
                        onTap: ()=>showCategoriesBottomSheet(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(selectedcategory.image,width: 32,height: 32,),
                              Text(selectedcategory.name)

                          ],),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        createroom();
                      }, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('create'),
                      ))

                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showCategoriesBottomSheet() {
    showModalBottomSheet(context: context, builder: (context){
      return CategoriesBottomSheet(oncategoryselected) ;
    });
  }

   oncategoryselected(Categories category) {
    this.selectedcategory=category;
    setState(() {

    });

   }

  void createroom() async {
    if(formKey.currentState!.validate()){
  try{
    showloading(context);
   var res=await addroomtofirestore(Room(id: '', roomname: roomname, roomdesc: roomdescreption, categoryid: selectedcategory.id));
   hideloading(context);
  }
  catch(e){
    showmessage(context, e.toString());
  }
    }
  }
}

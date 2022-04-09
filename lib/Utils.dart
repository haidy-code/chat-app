import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isvalidemail(String email){
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) ;
}
void showloading(BuildContext context){
showDialog(context: context, builder: (buildcontext){
  return AlertDialog(
   content: Row(
     children: [
       CircularProgressIndicator(),
       SizedBox(
         width: 12,
       ),
       Text('Loading...')
     ],
   ),

  );

},barrierDismissible: false);
}
void showmessage(BuildContext context,String message ){
  showDialog(context: context, builder: (buildcontext){
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('ok'))
      ],
    );
  });
}
void hideloading(BuildContext context){
Navigator.pop(context);
}
class Categories{
  static const String music_id='music';
  static const String sports_id='sports';
  static const String movies_id='movies';
 late String id;
  late String name;
  late String image;

  Categories(this.id, this.name, this.image);
  Categories.fromid(String id){
    if(id==music_id){
      this.id=music_id;
      name='Music';
      image='assets/images/music.png';

    }
    else if(id==sports_id){
      this.id=sports_id;
      name='Sports';
      image='assets/images/sports.png';

    }
    else{
      this.id=movies_id;
      name='Movies';
      image='assets/images/movies.png';

    }
  }
}
List<Categories>categories_list=[
  Categories.fromid(Categories.sports_id),
  Categories.fromid(Categories.movies_id),
  Categories.fromid(Categories.music_id)
];
import 'package:chat_project/Utils.dart';
import 'package:flutter/material.dart';

class CategoriesBottomSheet extends StatelessWidget {
  Function onCategorySelectedCallBack;

  CategoriesBottomSheet(this.onCategorySelectedCallBack);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (buildcontext,index){
      return InkWell(
        onTap: (){
          onCategorySelectedCallBack(categories_list[index]);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(categories_list[index].image,width: 32,height: 32,),
              Text(categories_list[index].name)

            ],),
        ),
      );
    },itemCount: categories_list.length,);
  }
}

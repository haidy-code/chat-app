
import 'package:chat_project/HomeScreen.dart';
import 'package:chat_project/data/FirebaseUtils.dart';
import 'package:chat_project/data/MyUser.dart';
import 'package:chat_project/providers/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils.dart';
//firstname,lastname,username,email,password,createaccount

class RegisterScreen extends StatefulWidget {
static const String routename='register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
String firstname='',lastname='',username='',email='',password='';

var formKey = GlobalKey<FormState>();
late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            title: Text('Create Account'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey
              ,child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .25,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'first name',
                    ),
                    onChanged: (text){
                      firstname=text;
                    },
                    validator:(text){
                      if(text==null||text.trim().isEmpty)
                        return 'please enter firstname';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'last name',
                    ),
                    onChanged: (text){
                      lastname=text;
                    },
                    validator:(text){
                      if(text==null||text.trim().isEmpty)
                        return 'please enter lastname';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'user name',
                    ),
                    onChanged: (text){
                      username=text;
                    },
                    validator:(text){
                      if(text==null||text.trim().isEmpty)
                        return 'please enter username';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email',
                    ),
                    onChanged: (text){
                      email=text;
                    },
                    validator:(text){
                      if(text==null||text.trim().isEmpty)
                        return 'please enter email';
                      if(!isvalidemail(text))
                        return 'please enter valid email';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'password',
                    ),
                    onChanged: (text){
                      password=text;
                    },
                    validator:(text){
                      if(text==null||text.trim().isEmpty)
                        return 'please enter password';
                      if(text.length<6)
                        return'password cannot be less than 6 characters';
                      return null;
                    },obscureText: true,//3shan a5ly password msh mtshaf
                  ),
                  ElevatedButton(onPressed: (){
                    if(formKey.currentState!.validate()){
                       createAccountWithFirebaseAuth();

                    }
                  }, child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('Create Account'),
                       Icon(Icons.arrow_right)
                     ],

                    ),
                  ))

                ],
            ),
              ),

            ),
          ),
        ),
      ),
    );
  }

  void createAccountWithFirebaseAuth() async {
try{
  showloading(context);
  var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password);
  if(result!=null){
hideloading(context);
showmessage(context, 'user is authinticated');
//add user to data base and then to provider
  MyUser myUser=MyUser(id: result.user!.uid, first_name: firstname, last_name: lastname, user_name: username, email: email);
addusertofirestore(myUser).then((value){
  //save user in provider
  provider.updateuser(myUser);
  Navigator.pushReplacementNamed(context, HomeScreen.routename);
}).onError((error, stackTrace) {
  showmessage(context, error.toString());
});
  }

  }
  catch(error) {
  hideloading(context);
  showmessage(context, error.toString());

  }
 }
}

import 'package:chat_project/HomeScreen.dart';
import 'package:chat_project/RegisterScreen.dart';
import 'package:chat_project/providers/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils.dart';
import 'data/FirebaseUtils.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String firstname = '',
      lastname = '',
      username = '',
      email = '',
      password = '';

  var formKey = GlobalKey<FormState>();
  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png'))),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'email',
                      ),
                      onChanged: (text) {
                        email = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty)
                          return 'please enter email';
                        if (!isvalidemail(text))
                          return 'please enter valid email';
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'password',
                      ),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty)
                          return 'please enter password';
                        if (text.length < 6)
                          return 'password cannot be less than 6 characters';
                        return null;
                      },
                      obscureText: true, //3shan a5ly password msh mtshaf
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            loginwithfirebaseauth();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('Login'), Icon(Icons.arrow_right)],
                          ),
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterScreen.routename);
                      },
                      child: Text('or Create My Account'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginwithfirebaseauth() async {
  try{
    showloading(context);
    var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);
    if(result!=null){
      hideloading(context);
      //user is authinticated then retrieve user from database
      var firestoreuser = await getuserbyid(result.user!.uid);
      if(firestoreuser!=null){
        //save user in provider
        provider.updateuser(firestoreuser);
        Navigator.pushReplacementNamed(context, HomeScreen.routename);

      }

    }
  }
  catch(error){
    hideloading(context);
    showmessage(context, error.toString());
  }
  }
}

class MyUser{
static const String collectionname='users';
String id;
String first_name;
String last_name;
String user_name;
String email;

MyUser({required this.id,required this.first_name,required this.last_name,required this.user_name,required this.email});
MyUser.fromJson(Map<String, dynamic> json)
    : this(
    id: json['id'] as String,
    user_name: json['username'] as String,
    first_name: json['firstname'] as String,
    last_name: json['lastname'] as String,
    email: json['email'] as String);

Map<String, dynamic> toJson(){
  return{
    'id':id,
    'firstname':first_name,
    'lastname':last_name,
    'username':user_name,
    'email':email
  };
}
}
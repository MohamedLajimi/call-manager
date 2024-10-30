import 'package:call_me_app/models/call.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:equatable/equatable.dart';


class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String picture;


  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.picture,
});

  @override
  List<Object?> get props =>
      [id, name, email, password, phoneNumber, picture, ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
      picture: map['picture'] as String,
    
      
    );
  }
}

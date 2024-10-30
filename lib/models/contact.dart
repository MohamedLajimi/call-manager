import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String userId;
  final String name;
  final String phoneNumber;
  final String picture;

  const Contact(
      {required this.userId,
      required this.name,
      required this.phoneNumber,
      required this.picture});

  @override
  List<Object?> get props => [userId, name, phoneNumber, picture];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'picture': picture,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      userId: map['userId'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      picture: map['picture'] as String,
    );
  }
}

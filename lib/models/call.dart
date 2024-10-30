

import 'package:call_me_app/models/contact.dart';
import 'package:equatable/equatable.dart';


class Call extends Equatable {
  final String id;
  final Contact contact;
  final DateTime callTime;

  const Call({required this.id, required this.contact, required this.callTime});
  
  @override
  List<Object?> get props => [id,contact,callTime];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contact': contact.toMap(),
      'callTime': callTime.millisecondsSinceEpoch,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      id: map['id'] as String,
      contact: Contact.fromMap(map['contact'] as Map<String,dynamic>),
      callTime: DateTime.fromMillisecondsSinceEpoch(map['callTime'] as int),
    );
  }

}

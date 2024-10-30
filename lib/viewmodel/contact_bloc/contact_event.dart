part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class FetchContacts extends ContactEvent {
  final String userId;
  const FetchContacts({required this.userId});
  @override
  List<Object> get props => [userId];
}

class AddContact extends ContactEvent {
  final Contact contact;
  const AddContact(this.contact);
  @override
  List<Object> get props => [contact];
}

class DeleteContact extends ContactEvent {
  final String phoneNumber;
  final List<Contact> contacts;
  const DeleteContact({required this.phoneNumber, required this.contacts});
  @override
  List<Object> get props => [phoneNumber, contacts];
}

class EditContact extends ContactEvent {
  final Contact contact;
  final String oldPhoneNumber;
  const EditContact({required this.contact, required this.oldPhoneNumber});
  @override
  List<Object> get props => [
        contact,
      ];
}

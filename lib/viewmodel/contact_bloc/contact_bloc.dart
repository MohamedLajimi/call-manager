import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final DatabaseHelper _databaseHelper;
  ContactBloc({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper,
        super(ContactInitial()) {
    on<FetchContacts>((event, emit) async {
      final contacts = await _databaseHelper.getContacts(event.userId);
      emit(ContactListLoaded(contacts));
    });

    on<AddContact>((event, emit) async {
      await _databaseHelper.addContact(event.contact);
    });

    on<EditContact>((event, emit) async {
      await _databaseHelper.editContact(event.contact,event.oldPhoneNumber);
    });

    on<DeleteContact>((event, emit) async {
      await _databaseHelper.deleteContact(event.phoneNumber);
      emit(ContactListLoaded(List<Contact>.from(event.contacts)
        ..removeWhere((element) => element.phoneNumber == event.phoneNumber)));
    });
  }
}

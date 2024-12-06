import 'dart:developer';

import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;
  ContactProvider(this._databaseHelper);
  List<Contact> contacts = [];

  void fetchContacts() async {
    const storage = FlutterSecureStorage();
    String? userId = await storage.read(key: 'userId');
    log(userId ?? 'its null');
    contacts = await _databaseHelper.getContacts(userId!);
    notifyListeners();
  }

  void addContact({required Contact contact}) {
    _databaseHelper.addContact(contact);
    contacts.add(contact);
    notifyListeners();
  }

  void editContact({required Contact contact, required String phoneNumber}) {
    _databaseHelper.editContact(contact, phoneNumber);
    contacts
      ..removeWhere(
        (contact) => contact.phoneNumber == phoneNumber,
      )
      ..add(contact);
    notifyListeners();
  }

  void deleteContact({required String phoneNumber}) {
    _databaseHelper.deleteContact(phoneNumber);
    contacts.removeWhere(
      (contact) => contact.phoneNumber == phoneNumber,
    );
    notifyListeners();
  }
}

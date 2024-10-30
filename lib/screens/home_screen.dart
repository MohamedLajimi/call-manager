import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/show_warning_dialog.dart';
import 'package:call_me_app/core/widgets/contact_list_tile.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/viewmodel/auth_bloc/auth_bloc.dart';
import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as UserIsAuthenticated).user;
    return Scaffold(
        appBar: AppBar(
            leading: const SizedBox(),
            actions: [
              Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:
                        DecorationImage(image: FileImage(File(user.picture)))),
              ),
              const SizedBox(
                width: 10,
              )
            ],
            centerTitle: true,
            title: Image.asset(
              'assets/app_logo.png',
              width: 70,
              height: 70,
            )),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppPalette.red,
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              const storage = FlutterSecureStorage();
              storage.delete(key: 'userId');
              context.go('/welcome-screen');
            }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Contacts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.push('/add-contact-screen');
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppPalette.borderColor)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add Contact',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<ContactBloc, ContactState>(
                buildWhen: (previous, current) => current is ContactListLoaded,
                builder: (context, state) {
                  if (state is ContactListLoaded) {
                    final List<Contact> contacts = state.contacts;
                    if (contacts.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 250),
                          child: Text(
                            'NO CONTACTS YET',
                            style: TextStyle(
                                color: AppPalette.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: contacts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return ContactListTile(
                              onEdit: () {
                                context.push('/edit-contact-screen',
                                    extra: contact);
                              },
                              onDelete: () {
                                showWarningDialog(
                                  context: context,
                                  title: 'WARNING',
                                  desc:
                                      'Are you sure you want to delete this contact ?',
                                  btnOkText: 'Delete',
                                  btnCancelText: 'Cancel',
                                  onConfirm: () {
                                    context.read<ContactBloc>().add(
                                        DeleteContact(
                                            phoneNumber: contact.phoneNumber,
                                            contacts: contacts));
                                  },
                                );
                              },
                              contact: contact);
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ));
  }
}

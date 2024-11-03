import 'dart:io';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/show_calls_dialog.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/utils/show_warning_dialog.dart';
import 'package:call_me_app/core/widgets/contact_list_tile.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/models/contact.dart';

import 'package:call_me_app/viewmodel/contact_bloc/contact_bloc.dart';
import 'package:call_me_app/viewmodel/theme_bloc/theme_bloc.dart';
import 'package:call_me_app/viewmodel/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void sendSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          title: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              child: Image.asset(
                width: 80,
                height: 80,
                'assets/app_logo.png',
              )),
          actions: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                bool isDark = state is DarkThemeState;
                return ThemeButton(
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ToggleTheme(isDark ? 'light' : 'dark'));
                  },
                  icon: isDark
                      ? const Icon(
                          Icons.light_mode_outlined,
                          size: 20,
                        )
                      : const Icon(
                          Icons.dark_mode_outlined,
                          size: 20,
                        ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppPalette.red,
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              const storage = FlutterSecureStorage();
              storage.delete(key: 'userId');
              context.go('/login-screen');
            }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contacts',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary),
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
                                color: AppPalette.lightGrey,
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
                              onTap: () {
                                showCallsDialog(
                                    context: context,
                                    onSendMessage: () {
                                      sendSms('+216${contact.phoneNumber}');
                                    },
                                    onCall: () async {
                                      makePhoneCall(
                                          '+216 ${contact.phoneNumber}');
                                    });
                              },
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
                                    showToast(
                                        message: 'Contact deleted successfully',
                                        context: context,
                                        type: ToastificationType.success);
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

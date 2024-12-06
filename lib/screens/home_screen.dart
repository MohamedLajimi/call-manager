import 'dart:io';
import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/theme/theme.dart';
import 'package:call_me_app/core/utils/show_calls_dialog.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/utils/show_warning_dialog.dart';
import 'package:call_me_app/core/widgets/contact_list_tile.dart';
import 'package:call_me_app/core/widgets/theme_button.dart';
import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/viewmodel/auth_provider.dart';
import 'package:call_me_app/viewmodel/contact_provider.dart';
import 'package:call_me_app/viewmodel/theme_provider.dart';
import 'package:call_me_app/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _fetchContacts() {
    Provider.of<ContactProvider>(context, listen: false).fetchContacts();
  }

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
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => context.push('/profile-screen'),
            child: CircleAvatar(
              backgroundImage: FileImage(File(user.picture)),
            ),
          ),
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
            AppBarButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Provider.of<ThemeProvider>(context).theme == lightTheme
                  ? const Icon(
                      Icons.light_mode_outlined,
                      size: 15,
                    )
                  : const Icon(
                      Icons.dark_mode_outlined,
                      size: 15,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            AppBarButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logoutUser(context: context);
                },
                icon: Icon(
                  Icons.logout,
                  size: 15,
                  color: Theme.of(context).colorScheme.primary,
                )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppPalette.blue,
            child: const Icon(
              Icons.place_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              context.push('/localisation-screen');
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
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  IconButton(
                      onPressed: () {
                        context.push('/add-contact-screen');
                      },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(3))),
                          backgroundColor: WidgetStatePropertyAll(
                              AppPalette.lightGrey.withOpacity(0.4))),
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primary,
                        size: 25,
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<ContactProvider>(builder: (context, contactVM, child) {
                final List<Contact> contacts = contactVM.contacts;
                if (contacts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        'NO CONTACTS YET',
                        style: TextStyle(
                            color: AppPalette.lightGrey,
                            fontSize: 16,
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
                                  sendSms(contact.phoneNumber);
                                },
                                onCall: () async {
                                  makePhoneCall(contact.phoneNumber);
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
                                contactVM.deleteContact(
                                    phoneNumber: contact.phoneNumber);
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
              })
            ],
          ),
        ));
  }
}

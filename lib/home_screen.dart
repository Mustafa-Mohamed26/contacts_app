import 'dart:io';

import 'package:contacts_app/core/app_assets.dart';
import 'package:contacts_app/core/app_color.dart';
import 'package:contacts_app/core/app_style.dart';
import 'package:contacts_app/data/user_model.dart';
import 'package:contacts_app/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contacts = [];

  void _addContact(BuildContext context) async {
    final result = await showModalBottomSheet<ContactModel>(
      context: context,
      backgroundColor: AppColor.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BottomSheetWidget(),
    );

    if (result != null) {
      setState(() {
        contacts.add(result);
      });
    }
  }

  void _editContact(BuildContext context, int index) async {
    final result = await showModalBottomSheet<ContactModel>(
      context: context,
      backgroundColor: AppColor.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BottomSheetWidget(contact: contacts[index]),
    );

    if (result != null) {
      setState(() {
        contacts[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColor.darkBlue,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Image.asset(AppAssets.appBarLogo)),
        body: contacts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.home),
                    SizedBox(height: height * 0.03),
                    const Text(
                      'There is No Contacts Added Here',
                      style: AppStyle.titleMedium,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Card(
                    color: AppColor.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: contact.image != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(
                                File(contact.image!.path),
                              ),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(contact.name, style: AppStyle.titleMedium),
                      subtitle: Text(contact.email),
                      trailing: Text(contact.phone),
                      onTap: () {
                        _editContact(context, index);
                      },
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.gold,
          child: const Icon(Icons.add),
          onPressed: () {
            _addContact(context);
          },
        ),
      ),
    );
  }
}

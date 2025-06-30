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
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return InkWell(
                    onTap: () {
                      _editContact(context, index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Contact image
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: contact.image != null
                                      ? FileImage(File(contact.image!.path))
                                      : const AssetImage(AppAssets.imagePicker),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColor.gold,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      contact.name,
                                      style: AppStyle.cardTitle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.gold,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                                // For email
                                Row(
                                  children: [
                                    Icon(
                                      Icons.mail_rounded,
                                      color: AppColor.darkBlue,
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Expanded(
                                      child: Text(
                                        contact.email,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),

                                // For phone
                                Row(
                                  children: [
                                    Icon(Icons.phone, color: AppColor.darkBlue),
                                    SizedBox(width: width * 0.02),
                                    Expanded(
                                      child: Text(
                                        contact.phone,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        contacts.removeAt(index);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: AppColor.gold,
                                      overlayColor: AppColor.transparentColor,
                                      padding: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: AppStyle.titleMedium,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: width * 0.02),
                                        Text("Delete"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (contacts.isNotEmpty)
              FloatingActionButton(
                backgroundColor: Colors.red,
                heroTag: 'delete',
                child: const Icon(Icons.delete, color: AppColor.gold),
                onPressed: () {
                  if (contacts.isNotEmpty) {
                    setState(() {
                      contacts.removeLast();
                    });
                  }
                },
              ),
            const SizedBox(height: 12),
            if (contacts.length < 6)
              FloatingActionButton(
                backgroundColor: AppColor.gold,
                heroTag: 'add',
                child: const Icon(Icons.add, color: AppColor.darkBlue),
                onPressed: () {
                  _addContact(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}

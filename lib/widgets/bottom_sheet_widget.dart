import 'dart:io';

import 'package:contacts_app/core/app_assets.dart';
import 'package:contacts_app/core/app_color.dart';
import 'package:contacts_app/core/app_style.dart';
import 'package:contacts_app/data/user_model.dart';
import 'package:contacts_app/widgets/custom_elevated_button.dart';
import 'package:contacts_app/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? userName;
  String? email;
  String? phoneNumber;
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a phone number';
    }
    if (!RegExp(r'^\d{7,}$').hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _pickedImage == null
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.gold),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Image.asset(AppAssets.imagePicker),
                        )
                      : null,
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? "User Name",
                        style: AppStyle.titleMedium,
                      ),
                      SizedBox(height: height * 0.01),
                      Divider(color: AppColor.gold, thickness: 2),
                      SizedBox(height: height * 0.01),
                      Text(email ?? "User Email", style: AppStyle.titleMedium),
                      SizedBox(height: height * 0.01),
                      Divider(color: AppColor.gold, thickness: 2),
                      SizedBox(height: height * 0.01),
                      Text(
                        phoneNumber ?? "User Phone",
                        style: AppStyle.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            TextFormFieldWidget(
              controller: nameController,
              hint: 'Enter User Name',
              keyboardType: TextInputType.text,
              validator: _validateName,
            ),
            SizedBox(height: height * 0.01),
            TextFormFieldWidget(
              controller: emailController,
              hint: 'Enter User Email',
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            SizedBox(height: height * 0.01),
            TextFormFieldWidget(
              controller: phoneController,
              hint: 'Enter User Phone',
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
            ),
            SizedBox(height: height * 0.01),
            CustomElevatedButton(
              text: "Enter User",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final contact = ContactModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    image: _pickedImage,
                  );
                  Navigator.pop(context, contact);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

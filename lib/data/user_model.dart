import 'package:image_picker/image_picker.dart';

class ContactModel {
  final String name;
  final String email;
  final String phone;
  final XFile? image;

  ContactModel({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });
}
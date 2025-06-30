import 'package:contacts_app/core/app_assets.dart';
import 'package:contacts_app/core/app_color.dart';
import 'package:contacts_app/core/app_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.darkBlue,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Image.asset(AppAssets.appBarLogo)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.home),
              const SizedBox(height: 16),
              const Text(
                'There is No Contacts Added Here',
                style: AppStyle.titleMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.gold,
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

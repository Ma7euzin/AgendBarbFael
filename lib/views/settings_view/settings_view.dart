import 'package:agendfael/consts/list.dart';
import 'package:agendfael/controller/auth_cotroller.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: AppStrings.settings,
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(AppAssets.imgUser),
            ),
            title: AppStyles.bold(title: "Nome do Usuario"),
            subtitle: AppStyles.normal(title: "user_email@gmail.com"),
          ),
          const Divider(),
          20.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              settingsList.length,
              (index) => ListTile(
                onTap: () async{
                  if (index == 2) {
                    AuthController().signout();
                    Get.offAll(() => const LoginView());
                  }
                },
                leading: Icon(
                  settingsListIcon[index],
                  color: AppColors.primaryColor,
                ),
                title: AppStyles.bold(
                  title: settingsList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

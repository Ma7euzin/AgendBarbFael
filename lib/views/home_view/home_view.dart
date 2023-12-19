import 'dart:math';

import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/consts/list.dart';
import 'package:agendfael/controller/home_controller.dart';
import 'package:agendfael/views/barber_profile_view/barber_profile_view.dart';
import 'package:agendfael/views/category_details_view/category_details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../controller/settings_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var data = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: AppStyles.normal(
          title: "${AppStrings.welcome} ${data.username}",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.imgWelcome,
            width: 300,
          ),
          5.heightBox,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppStyles.bold(
                      title: "Serviços",
                      color: AppColors.textColor,
                      size: AppSizes.size18),
                ),
                10.heightBox,
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(22),
                          margin: const EdgeInsets.only(right: 6),
                          child: Row(
                            children: [
                              Image.asset(
                                IconList[index],
                                width: 80,
                                color: AppColors.whiteColor,
                              ),
                              15.heightBox,
                              AppStyles.normal(
                                  title: IconTitleList[index],
                                  color: AppColors.whiteColor,
                                  size: AppSizes.size20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppStyles.bold(
                      title: "Barbeiros",
                      color: AppColors.textColor,
                      size: AppSizes.size18),
                ),
                10.heightBox,
                FutureBuilder<QuerySnapshot>(
                  future: controller.getbarberList(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var data = snapshot.data?.docs;
                    
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() =>  BarberProfileView(barb: data[index],));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: AppColors.bgDarkColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(right: 8),
                                height: 100,
                                width: 150,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      color: AppColors.primaryColor,
                                      child: Image.asset(
                                        AppAssets.imgUser,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    5.heightBox,
                                    AppStyles.bold(title: data![index]['barbName']),
                                    5.heightBox,
                                    AppStyles.normal(
                                        title: data[index]['barbCategory'],
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }),
                5.heightBox,
                GestureDetector(
                  onTap: () {
                    Get.to(() => const CategoryDetailsView());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppStyles.normal(
                        title: "VER TODOS", color: AppColors.primaryColor),
                  ),
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.imgUser,
                            width: 25,
                            color: AppColors.whiteColor,
                          ),
                          5.heightBox,
                          AppStyles.normal(title: "Lab Test"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

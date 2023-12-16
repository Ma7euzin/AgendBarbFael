import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/views/book_appointment_view/book_appointment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarberProfileView extends StatelessWidget {
  const BarberProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: AppStyles.bold(
          title: "Nome do Barbeiro",
          color: AppColors.whiteColor,
          size: AppSizes.size16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(
                        AppAssets.imgUser,
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles.bold(
                              title: "Nome Barbeiro",
                              color: AppColors.whiteColor,
                              size: AppSizes.size16),
                          AppStyles.bold(
                            title: "Experiência",
                            color: AppColors.whiteColor.withOpacity(0.5),
                            size: AppSizes.size12,
                          ),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value) {},
                            maxRating: 5,
                            count: 5,
                            value: 4,
                            stepInt: true,
                          ),
                        ],
                      ),
                    ),
                    AppStyles.bold(
                        title: "Ver Todos Reviws",
                        color: AppColors.whiteColor,
                        size: AppSizes.size12),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AppStyles.bold(
                          title: "Numero Telefone",
                          color: AppColors.whiteColor),
                      subtitle: AppStyles.normal(
                          title: "+5531992045632",
                          color: AppColors.whiteColor.withOpacity(0.5),
                          size: AppSizes.size14),
                      trailing: Container(
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.yellowColor),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Sobre",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: "isso é a seção sobre o barbeiro",
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Endereço",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: "Endereço do barbeiro",
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Tempo de Trabalho",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: "9:00 AM até 19: PM",
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Serviços",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: "Aqui é a experiencia do barbeiro",
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButtom(
          onTap: () {
            Get.to(()=> const BookAppointmentView());
          },
          buttonText: "Agendar um Horario",
        ),
      ),
    );
  }
}

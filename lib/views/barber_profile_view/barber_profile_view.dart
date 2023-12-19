import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/views/book_appointment_view/book_appointment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BarberProfileView extends StatelessWidget {
  final DocumentSnapshot barb;
  const BarberProfileView({super.key, required this.barb});

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: AppStyles.bold(
          title: "Detalhes do Barbeiro",
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
                              title: barb['barbName'],
                              color: AppColors.whiteColor,
                              size: AppSizes.size16),
                          AppStyles.bold(
                            title: barb['barbCategory'],
                            color: AppColors.whiteColor.withOpacity(0.5),
                            size: AppSizes.size12,
                          ),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value) {},
                            maxRating: 5,
                            count: 5,
                            value: double.parse(barb['barbNivel'].toString()),
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
                          title: barb['barbPhone'],
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
                        title: "Sobre:",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: barb['barbAbout'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Endereço",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: barb['barbAddress'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Horario de Trabalho",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: barb['BarbTiming'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Serviços",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: barb['barbExperiencia'],
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
            Get.to(()=> BookAppointmentView(barbId: barb.id,barbName: barb['barbName'],));
          },
          buttonText: "Agendar um Horario",
        ),
      ),
    );
  }
}

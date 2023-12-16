import 'package:agendfael/views/appointment_details_view/appointment_detail_view.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: AppStyles.bold(
          title: "Agendamentos",
          color: AppColors.whiteColor,
          size: AppSizes.size16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
                Get.to(() => const AppointmentDetailsView());
              },
              leading: CircleAvatar(
                child: Image.asset(AppAssets.imgUser),
              ),
              title: AppStyles.bold(title: "Nome Barbeiro"),
              subtitle: AppStyles.normal(
                title: "Hora Agendamento",
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:agendfael/controller/appointment_controller.dart';
import 'package:agendfael/views/appointment_details_view/appointment_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: AppStyles.bold(
            title: "Agendamentos",
            color: AppColors.whiteColor,
            size: AppSizes.size16,
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: controller.getAppointments(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data?.docs;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Get.to(() => AppointmentDetailsView(
                                doc: data[index],
                              ));
                        },
                        leading: CircleAvatar(
                          child: Image.asset(AppAssets.imgUser),
                        ),
                        title:
                            AppStyles.bold(title: data![index]['appWithName']),
                        subtitle: AppStyles.normal(
                          title:
                              "${data[index]['appDay']} - ${data[index]['appTime']}",
                          color: AppColors.primaryColor.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }
}

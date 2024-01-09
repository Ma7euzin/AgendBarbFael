import 'package:cloud_firestore/cloud_firestore.dart';
import '../../consts/consts.dart';

class AppointmentDetailsView extends StatelessWidget {
  final DocumentSnapshot doc;
  const AppointmentDetailsView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: doc['appWithName'],
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: doc['appDay'], size: AppSizes.size16),
            5.heightBox,
            AppStyles.normal(title: "Selecionar Dia"),
            10.heightBox,
            AppStyles.bold(title: doc['appTime']),
            5.heightBox,
            AppStyles.normal(title: "Selecionar Hora"),
            10.heightBox,
            AppStyles.bold(title: doc['appMobile']),
            5.heightBox,
            AppStyles.normal(title: "Número celular"),
            10.heightBox,
            AppStyles.bold(title: doc['appName']),
            5.heightBox,
            AppStyles.normal(title: "Name"),
            10.heightBox,
            AppStyles.bold(title: doc['appMsg']),
            5.heightBox,
            AppStyles.normal(title: "Messagem"),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
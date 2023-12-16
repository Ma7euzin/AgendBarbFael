import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Nome do Barbeiro",
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Selecione o dia do encontro", size: AppSizes.size16),
            5.heightBox,
            AppStyles.normal(title: "Selecionar Dia"),
            10.heightBox,
            AppStyles.bold(title: "Selecione a hora do encontro"),
            5.heightBox,
            AppStyles.normal(title: "Selecionar Hora"),
            10.heightBox,
            AppStyles.bold(title: "Numero Celular"),
            5.heightBox,
            AppStyles.normal(title: "Número celular"),
            10.heightBox,
            AppStyles.bold(title: "Nome Completo"),
            5.heightBox,
            AppStyles.normal(title: "Name"),
            10.heightBox,
            AppStyles.bold(title: "Menssagem"),
            5.heightBox,
            AppStyles.normal(title: "Messagem"),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
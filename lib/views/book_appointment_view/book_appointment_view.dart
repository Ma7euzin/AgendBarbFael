import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/res/components/custom_textfield.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controller/appointment_controller.dart';

class BookAppointmentView extends StatelessWidget {
  final String barbId;
  final String barbName;
  const BookAppointmentView(
      {super.key, required this.barbId, required this.barbName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: AppStyles.bold(
          title: barbName,
          color: AppColors.whiteColor,
          size: AppSizes.size16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.bold(title: "Selecione o dia do Corte"),
              5.heightBox,
              CustomTextField(
                hint: "Selecione o Dia",
                textControlller: controller.appDayController,
              ),
              10.heightBox,
              AppStyles.bold(title: "Selecione a Hora do Corte"),
              5.heightBox,
              CustomTextField(
                hint: "Selecione Hora",
                textControlller: controller.appTimeController,
              ),
              20.heightBox,
              AppStyles.bold(title: "Numero do Celular"),
              5.heightBox,
               CustomTextField(
                hint: "Digite seu numero de Telefone",
                textControlller: controller.appTelefoneController,
              ),
              10.heightBox,
              AppStyles.bold(title: "Nome Completo"),
              5.heightBox,
               CustomTextField(
                hint: "Digite seu Nome",
                textControlller: controller.appNameController,
              ),
              10.heightBox,
              AppStyles.bold(title: "Mensagem:"),
              5.heightBox,
              CustomTextField(
                hint: "Digite uma Mensagem",
                textControlller: controller.appMessageController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButtom(
                  onTap: () async {
                    await controller.bookAppointment(barbId, barbName, context);
                  },
                  buttonText: "Agendar Um Horario",
                ),
        ),
      ),
    );
  }
}

import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/res/components/custom_textfield.dart';

import '../../consts/consts.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.bold(title: "Selecione o dia do Corte"),
              5.heightBox,
              const CustomTextField(
                hint: "Selecione o Dia",
              ),
              10.heightBox,
              AppStyles.bold(title: "Selecione a Hora do Corte"),
              5.heightBox,
              const CustomTextField(
                hint: "Selecione Hora",
              ),
              20.heightBox,
              AppStyles.bold(title: "Numero do Celular"),
              5.heightBox,
              const CustomTextField(
                hint: "Digite seu numero de Telefone",
              ),
              10.heightBox,
              AppStyles.bold(title: "Nome Completo"),
              5.heightBox,
              const CustomTextField(
                hint: "Digite seu Nome",
              ),
              10.heightBox,
              AppStyles.bold(title: "Mensagem:"),
              5.heightBox,
              const CustomTextField(
                hint: "Digite uma Mensagem",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButtom(
          onTap: () {

          },
          buttonText: "Agendar Um Horario",
        ),
      ),
    );
  }
}

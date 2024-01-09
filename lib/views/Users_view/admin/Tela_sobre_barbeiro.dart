// ignore_for_file: unnecessary_null_comparison, file_names
import 'package:agendfael/consts/consts.dart';

class TelaEditarBarbeiro extends StatefulWidget {
  final Map<String, dynamic> barbeiro;
  final String barbeiroId;
  const TelaEditarBarbeiro(
      {super.key, required this.barbeiro, required this.barbeiroId});

  @override
  State<TelaEditarBarbeiro> createState() => _TelaEditarBarbeiroState();
}

class _TelaEditarBarbeiroState extends State<TelaEditarBarbeiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes do Barbeiro",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                            title: widget.barbeiro['fullname'],
                            color: AppColors.whiteColor,
                            size: AppSizes.size16,
                          ),
                          AppStyles.bold(
                            title: widget.barbeiro['email'],
                            color: AppColors.whiteColor.withOpacity(0.5),
                            size: AppSizes.size12,
                          ),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value) {},
                            maxRating: 5,
                            count: 5,
                            value: double.parse(
                                widget.barbeiro['estrelas'].toString()),
                            stepInt: true,
                          ),
                        ],
                      ),
                    ),
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
                          title: widget.barbeiro['celularBarb'],
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
                        title: widget.barbeiro['sobreBarb'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Endereço",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: widget.barbeiro['enderecoBarb'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Horario de Trabalho",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: widget.barbeiro['horarioBarb'],
                        color: AppColors.whiteColor.withOpacity(0.5),
                        size: AppSizes.size14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

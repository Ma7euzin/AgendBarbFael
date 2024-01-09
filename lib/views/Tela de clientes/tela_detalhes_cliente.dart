
import '../../consts/consts.dart';

class TelaDetalhesCliente extends StatefulWidget {
  final Map<String, dynamic> cliente;
  const TelaDetalhesCliente(
      {super.key, required this.cliente});

  @override
  State<TelaDetalhesCliente> createState() => _TelaDetalhesClienteState();
}

class _TelaDetalhesClienteState extends State<TelaDetalhesCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes do Cliente",
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
                            title: widget.cliente['fullname'],
                            color: AppColors.whiteColor,
                            size: AppSizes.size16,
                          ),
                          AppStyles.bold(
                            title: widget.cliente['email'],
                            color: AppColors.whiteColor.withOpacity(0.5),
                            size: AppSizes.size12,
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
                          title: widget.cliente['celular'],
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
                        title: "Endereço",
                        color: AppColors.whiteColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: widget.cliente['endereco'],
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

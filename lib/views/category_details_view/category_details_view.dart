
import '../../consts/consts.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: AppStyles.bold(
          title: "Nome do serviço",
          color: AppColors.whiteColor,
          size: AppSizes.size16,
        ),
      ),
    );
  }
}
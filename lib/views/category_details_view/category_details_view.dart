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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            //Get.to(() => const BarberProfileView());
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 170,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                //margin: const EdgeInsets.only(right: 8),
                height: 100,
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: AppColors.primaryColor,
                      child: Image.asset(
                        AppAssets.imgUser,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    5.heightBox,
                    AppStyles.normal(title: "Nome Do Barbeiro"),
                    VxRating(
                      selectionColor: AppColors.yellowColor,
                      onRatingUpdate: (value) {},
                      maxRating: 5,
                      count: 5,
                      value: 4,
                      stepInt: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

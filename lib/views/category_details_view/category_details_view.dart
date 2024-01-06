import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/consts.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  const CategoryDetailsView({super.key, required this.catName});

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
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('barbeiros')
                .where('barbCategory', isEqualTo: catName)
                .get(),
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
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 170,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: data?.length ?? 0,
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
                            AppStyles.normal(title: data![index]['barbName']),
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
                );
              }
            }));
  }
}

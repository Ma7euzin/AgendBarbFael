// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/consts/list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login_view/login_view.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _logout(BuildContext context) async {

    final FirebaseAuth auth = FirebaseAuth.instance;
    
    await auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    //var controller = Get.put(HomeController());
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: AppStyles.normal(
          title: 'ola',
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.imgWelcome,
            width: 300,
          ),
          5.heightBox,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppStyles.bold(
                      title: "Serviços",
                      color: AppColors.textColor,
                      size: AppSizes.size18),
                ),
                10.heightBox,
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(22),
                          margin: const EdgeInsets.only(right: 6),
                          child: Row(
                            children: [
                              Image.asset(
                                IconList[index],
                                width: 80,
                                color: AppColors.whiteColor,
                              ),
                              15.heightBox,
                              AppStyles.normal(
                                  title: IconTitleList[index],
                                  color: AppColors.whiteColor,
                                  size: AppSizes.size20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.heightBox,
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.imgUser,
                            width: 25,
                            color: AppColors.whiteColor,
                          ),
                          5.heightBox,
                          AppStyles.normal(title: "Lab Test"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

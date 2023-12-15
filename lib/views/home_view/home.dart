import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/views/barber_profile_view/barber_profile_view.dart';
import 'package:agendfael/views/category_view/category_view.dart';
import 'package:agendfael/views/home_view/home_view.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:agendfael/views/settings_view/settings_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;
  List screenList = [
    const HomeView(),
    const CategoryView(),
    const LoginView(),
    const SettingsView(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.2),
        selectedItemColor: AppColors.whiteColor,
        currentIndex: selectedIndex,
        backgroundColor: AppColors.primaryColor,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          color: AppColors.whiteColor,
        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.whiteColor,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categoria",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Barbeiro",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configurações",
          ),
        ],
      ),
    );
  }
}

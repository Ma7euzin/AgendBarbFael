import 'package:agendfael/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        
        actions: [
          Container(
            child: IconButton(
                onPressed: () {
                  AutheticationRepository.instance.logout();
                },
                icon: Icon(Icons.logout_rounded)),
          )
        ],
      ),
    );
  }
}

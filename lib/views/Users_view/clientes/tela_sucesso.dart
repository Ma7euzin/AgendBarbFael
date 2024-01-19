import 'package:agendfael/views/home_view/home_cliente.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/json/success.json'),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Horario Marcado, Aguarde seu barbeiro confirmar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ElevatedButton(
                child: const Text(
                  'voltar a pagina Inicial',
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeView())),
              ),
            )
          ],
        ),
      ),
    );
  }
}

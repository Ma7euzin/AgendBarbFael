

import 'package:agendfael/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController{
  var isLoading = false.obs;

  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appTelefoneController = TextEditingController();
  var appNameController = TextEditingController();
  var appMessageController = TextEditingController();
  

  bookAppointment(String barbId, String barbName,  context) async {
    isLoading(true);

    var store = FirebaseFirestore.instance.collection('appointments').doc();
    await store.set({

      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appDay': appDayController.text,
      'appTime': appTimeController.text,
      'appMobile': appTelefoneController.text,
      'appName': appNameController.text,
      'appMsg': appMessageController.text,
      'appWith': barbId,
      'appWithName': barbName,
      

    });

    isLoading(false);
    VxToast.show(context, msg: "Agendamento Realizado com sucesso");
    Get.back();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(){
    return FirebaseFirestore.instance.collection('appointments').get();
  }
}
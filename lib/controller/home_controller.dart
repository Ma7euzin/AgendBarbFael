import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var isLoading = false.obs;
  
  Future<QuerySnapshot<Map<String, dynamic>>> getbarberList() async{
    var barbers = await FirebaseFirestore.instance.collection('barbeiros').get();
    return barbers;
  }
}
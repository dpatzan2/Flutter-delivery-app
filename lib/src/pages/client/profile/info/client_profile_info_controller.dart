import 'package:delivery_w_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController{

  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;


  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false); // ESTE METODO ELIMINADA TODO EL HISTORIAL DE PANTALLAS>
  }

  void goToProfilePage(){
    Get.toNamed('/client/profile/update');
  }
}
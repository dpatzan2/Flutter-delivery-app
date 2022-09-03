import 'package:delivery_w_flutter/src/models/response_api.dart';
import 'package:delivery_w_flutter/src/models/user.dart';
import 'package:delivery_w_flutter/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:sn_progress_dialog/progress_dialog.dart';

//CONFIGURAR PERMISOS DE CAMARA Y GALERIA EN D:\Diego\Flutter\ios\Runner EN EL ARCHIVO INFO

class registerController extends GetxController{


  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Passwor ${password}');

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando...');

      User user = User(
          email: email,
          name: name,
          lastnmae: lastname,
          phone: phone,
          password: password,
      );
      //Response response = await usersProvider.create(user);
      //Get.snackbar('Formulario valido', 'Enviando peticion http');

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        print(responseApi.toJson());
        if(responseApi.success == true){
          GetStorage().write('user', responseApi.data); // ALMACENANDO DATOS DEL USUARIO PARA PODER USARLOS DESPUES
          goToHomePage();
        }else{
          Get.snackbar('Ocurrio un erro al crear la cuenta', responseApi.message ?? '');
        }
      });
    }
  }
  void goToHomePage(){
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  bool isValidForm(String email, String name, String lastname, String phone, String password, String confirmPassword){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;

    }

    if(name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if(lastname.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if(phone.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu numero de telefono');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no valida', 'Debes ingresar el password');
      return false;
    }

    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes confirmar tu contraseña');
      return false;
    }

    if(password != confirmPassword){
      Get.snackbar('Formulario no valido', 'Las contraseñas no coindciden');
      return false;
    }

    if(imageFile == null){
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen antes');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource)async{
    XFile? image = await picker.pickImage(source: imageSource);

    if(image != null){
      imageFile = File(image.path);
      update();
    }
  }


  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'Galeria',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'Camara',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}
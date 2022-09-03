import 'package:delivery_w_flutter/src/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  registerController con = Get.put(registerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack( //AYUDA A POSICIONAR ELEMENTOS UNO ENCIMA DE OTRO
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _imageUser(context  ),
            _buttonBack()
          ],
        ),
      ),
    );
  }

  Widget _buttonBack(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
          ),
        )
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            ),
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textInformacion(),
            _textEmail(),
            _textName(),
            _textLastName(),
            _textPhone(),
            _textPassword(),
            _textConfirmPassword(),
            _buttomRegister(context)
          ],
        ),
      ),
    );
  }

  Widget _textEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }
  Widget _textName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }

  Widget _textPhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }

  Widget _textPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }
  Widget _textConfirmPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            prefixIcon: Icon(Icons.lock_outline)
        ),
      ),
    );
  }

  Widget _buttomRegister(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.register(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'Registrarse',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _textInformacion(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA TU INFORMACIÓN',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  // METODO PRIVADO
  Widget _imageUser(BuildContext context){
      return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 25),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<registerController> (
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : AssetImage('assets/img/user_profile.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )
          ),
        ),
      );
  }
}

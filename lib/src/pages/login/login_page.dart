import 'package:delivery_w_flutter/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textoDontHaveAccount(),
      ),
      body: Stack( //AYUDA A POSICIONAR ELEMENTOS UNO ENCIMA DE OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column( // POSICIONAR ELEMENTOS ENO DEBAJO DE OTRO (VERTICAL)
            children: [
              _imgCover(),
              _textAppName()
            ],
          )
        ],
      ),
    );
  }


  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: Colors.amber,
    );
  }

  Widget _textAppName(){
    return Text(
      'DELIVERY APP',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
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
            _textPassword(),
            _buttomLogin()
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

  Widget _buttomLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _textInformacion(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
        'INGRESA TU INFORMACIÓN',
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textoDontHaveAccount(){
    return Row( //UBICAR ELEMENTOS UNO AL LADO DEL OTRO
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes una cuenta?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: ()=> con.goToRegisterPage(),
          child: Text(
              'Crear una',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
          ),
        ),
      ]
    );
  }

    // METODO PRIVADO
    Widget _imgCover(){
      return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 15),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/img/delivery.png',
            width: 130,
            height: 130,
          ),
        ),
      );
    }
}

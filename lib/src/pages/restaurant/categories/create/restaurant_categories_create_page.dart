import 'package:delivery_w_flutter/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoiresCreatePage extends StatelessWidget {

  RestaurantCategoiresCreateController con = Get.put(RestaurantCategoiresCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack( //AYUDA A POSICIONAR ELEMENTOS UNO ENCIMA DE OTRO
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _textNewCategory(),
          ],
        ),
      ),
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
      height: MediaQuery.of(context).size.height * 0.45,
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
            _textName(),
            _textDescription(),
            _buttomCreate(context)
          ],
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
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            prefixIcon: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Icon(Icons.description))
        ),
      ),
    );
  }


  Widget _buttomCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: () {
            con.createCategory();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CREAR CATEGORIA',
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
  Widget _textNewCategory(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(Icons.category, size: 100),
            Text(
                'Nueva categoria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
                ),
            ),
          ],
        )
      ),
    );
  }
}

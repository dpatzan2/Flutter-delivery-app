import 'dart:io';

import 'package:delivery_w_flutter/src/models/category.dart';
import 'package:delivery_w_flutter/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:delivery_w_flutter/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {

  RestaurantProductsCreateController con = Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Stack( //AYUDA A POSICIONAR ELEMENTOS UNO ENCIMA DE OTRO
          children: [
            _backgroundCover(context),
            _boxForm(context),
            _textNewCategory(),
          ],
        ),
      )
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
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18, left: 50, right: 50),
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
            _textPrice(),
            _dropDownCategories(con.categories),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) => _cardImage(context, con.imageFile1, 1)
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) => _cardImage(context, con.imageFile2, 2)
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) => _cardImage(context, con.imageFile3, 3)
                  ),
                ],
              ),
            ),
            _buttomCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar categoria',
          style: TextStyle(
            fontSize: 15
          ),
        ),
        items: _dropDownItems(categories),
        value: con.idCategory,
        onChanged: (option) {
          print('opcion selecionada ${option}');
          con.idCategory = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () =>  con.showAlertDialog(context, numberFile),
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.18,
          child: imageFile !=null
          ?Image.file(
            imageFile,
            fit: BoxFit.cover,
          )
          : Image(
            image: AssetImage('assets/img/cover_image.png'),
          )
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

  Widget _textPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio',
            prefixIcon: Icon(Icons.attach_money)
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
            'CREAR PRODUCTO',
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
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: Text(
          'Nuevo producto',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23
          ),
        ),
      ),
    );
  }
}

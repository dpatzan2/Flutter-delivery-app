import 'dart:convert';
import 'dart:io';

import 'package:delivery_w_flutter/src/models/product.dart';
import 'package:delivery_w_flutter/src/models/response_api.dart';
import 'package:delivery_w_flutter/src/providers/categories_provider.dart';
import 'package:delivery_w_flutter/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:delivery_w_flutter/src/providers/products_provider.dart';

class RestaurantProductsCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var idCategory = ''.obs;

  List<Category> categories = <Category>[].obs;
  ProductsProvider productsProvider = ProductsProvider();

  RestaurantProductsCreateController() {
    getCategories();
  }

  void getCategories() async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }


  void createProduct(BuildContext context) async{
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    ProgressDialog progressDialog = ProgressDialog(context: context);

    if(isValidForm(name, description, price)) {
      Product product = Product(
        name: name,
        description: description,
        price: double.parse(price),
        idCategory: idCategory.value
      );

      progressDialog.show(max: 100, msg: 'Esto puede tomar unos segundos...');
      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);
      print(images);
      Stream stream = await productsProvider.create(product, images);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        if(responseApi.success == true) {
          clearForm();
        }
      });
    }
  }

  bool isValidForm(String name, String description, String price) {
    if(name.isEmpty){
      Get.snackbar('Fomulario no valido', 'Ingresa un nombre para el producto');
      return false;
    }
    if(description.isEmpty){
      Get.snackbar('Fomulario no valido', 'Es necesario ingresar una descripcion');
      return false;
    }
    if(price.isEmpty){
      Get.snackbar('Fomulario no valido', 'Es necesario ingresar el costo del producto');
      return false;
    }
    if(idCategory.value == ''){
      Get.snackbar('Fomulario no valido', 'Es necesario seleccionar la categoria de este producto');
      return false;
    }

    if (imageFile1 == null){
      Get.snackbar('Fomulario no valido', 'Es necesario seleccionar la imagen principal del producto');
      return false;
    }

    if (imageFile2 == null){
      Get.snackbar('Fomulario no valido', 'Es necesario seleccionar la imagen secundaria del producto');
      return false;
    }
    if (imageFile3 == null){
      Get.snackbar('Fomulario no valido', 'Es necesario seleccionar la tercer imagen del producto');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource, int numberFile)async{
    XFile? image = await picker.pickImage(source: imageSource);

    if(image != null){

      if(numberFile == 1){
        imageFile1 = File(image.path);
      }else if (numberFile == 2){
        imageFile2 = File(image.path);
      }else if( numberFile == 3) {
        imageFile3 = File(image.path);
      }

      update();
    }
  }


  void showAlertDialog(BuildContext context, int numberFile){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
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
          selectImage(ImageSource.camera, numberFile);
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

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }
}
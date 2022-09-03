import 'package:delivery_w_flutter/src/models/response_api.dart';
import 'package:delivery_w_flutter/src/providers/categories_provider.dart';
import 'package:delivery_w_flutter/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoiresCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();


  void createCategory() async{
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(
        name: name,
        description: description
      );

      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Success', responseApi.message ?? '');
      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Warning', 'Los campos no estan llenos');
    }
  }

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
  }
}
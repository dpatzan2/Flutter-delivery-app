import 'package:delivery_w_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:delivery_w_flutter/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_w_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_w_flutter/src/pages/register/register_page.dart';
import 'package:delivery_w_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_animated_bottom_bar.dart';



class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('CLIENT PROUDCTS LIST')),);
  }


}

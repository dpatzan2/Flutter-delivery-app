import 'package:delivery_w_flutter/src/models/user.dart';
import 'package:delivery_w_flutter/src/pages/client/home/client_home_page.dart';
import 'package:delivery_w_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_w_flutter/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:delivery_w_flutter/src/pages/client/profile/upadate/client_profile_update_page.dart';
import 'package:delivery_w_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_w_flutter/src/pages/home/home_page.dart';
import 'package:delivery_w_flutter/src/pages/login/login_page.dart';
import 'package:delivery_w_flutter/src/pages/register/register_page.dart';
import 'package:delivery_w_flutter/src/pages/restaurant/home/restaurant_home_page.dart';
import 'package:delivery_w_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_w_flutter/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:delivery_w_flutter/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async{
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles' : '/client/home' : '/',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage()),
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/roles', page: ()=> RolesPage()),
        GetPage(name: '/restaurant/home', page: ()=> RestaurantHomePage()),
        GetPage(name: '/restaurant/orders/list', page: ()=> RestaurantOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: ()=> DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: ()=> ClientProductsListPage()),
        GetPage(name: '/client/home', page: ()=> ClientHomePage()),
        GetPage(name: '/client/profile/info', page: ()=> ClientProfileInfoPage()),
        GetPage(name: '/client/profile/update', page: ()=> ClientProfileUpdatePage()),
        GetPage(name: '/client/orders/create', page: ()=> ClientOrdersCreatePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          background: Colors.grey,
          onSecondary: Colors.grey,


        )
      ),
      navigatorKey: Get.key,
    );
  }
}

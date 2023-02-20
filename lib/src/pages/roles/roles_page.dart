import 'package:delivery_w_flutter/src/models/Rol.dart';
import 'package:delivery_w_flutter/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RolesPage extends StatelessWidget {
  RolesController con = Get.put(RolesController());
  static const Object IMAGE = AssetImage('assets/img/no-image.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecciona un rol',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *0.17),
        child: ListView(
          children: con.user.roles != null ? con.user.roles!.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol){
    return GestureDetector(
      onTap: () => con.goToPageRol(rol),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 100,
              child: FadeInImage(
                image: NetworkImage(rol.image ?? IMAGE.toString() ),
                fit: BoxFit.contain,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            Text(
              rol.name ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black
              ),
            )
          ],
      ),
    );
  }
}

import 'package:delivery_w_flutter/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_w_flutter/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';


class ClientProductsDetailPage extends StatelessWidget {

  Product? product;

  var counter = 0.obs;
  var price = 0.0.obs;

  late ClientProductsDetailController con;

  ClientProductsDetailPage({@required this.product}) {
    con = Get.put(ClientProductsDetailController());
  }

  @override
  Widget build(BuildContext context) {
    con.checkIfProductWasAdded(product!, price, counter);
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
          height: 100,
          child: _buttomsAddToBag()
      ),
      body: Column(
        children: [
          _imageSlider(context),
          _TextNameProduct(),
          _TextDescriptionProduct(),
          _TextPriceProduct()
        ],
      ),
    ));
  }

  Widget _TextNameProduct () {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
          product?.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black
          ),
      ),
    );
  }

  Widget _TextDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: TextStyle(
            fontSize: 16,
        ),
      ),
    );
  }

  Widget _buttomsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400],),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => con.removeItem(product!, price, counter),
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25)
                        )
                    )
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '${counter.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  minimumSize: Size(40, 37)
                ),
              ),
              ElevatedButton(
                onPressed: () => con.addItem(product!, price, counter),
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(45, 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        )
                    )
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => con.addToBag(product!, price, counter),
                child: Text(
                  'Agregar    ${price.value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _TextPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\Q ${product?.price.toString() ?? ''}' ,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageSlider (BuildContext context) {
    return ImageSlideshow(
              width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                initialPage: 0,
                indicatorColor: Colors.amber,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image1 != null
                        ? NetworkImage(product!.image1!)
                        : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image2 != null
                          ? NetworkImage(product!.image2!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image3 != null
                          ? NetworkImage(product!.image3!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                ]
            );
  }
}

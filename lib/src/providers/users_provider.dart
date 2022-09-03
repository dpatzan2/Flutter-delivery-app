import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:delivery_w_flutter/src/envioment/envioment.dart';
import 'package:delivery_w_flutter/src/models/response_api.dart';
import 'package:delivery_w_flutter/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect{

  String url = Envioment.API_URL + 'api/users';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async{
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        });

    return response;
  }

  Future<ResponseApi> update(User user) async{
    Response response = await put(
        '$url/updateWithoutImage',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        });

    if(response.body == null){
      Get.snackbar('ERROR', 'Ocurrio un errorr intentalo de nuevo mas tarde');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('ERROR', 'No cuentas con los permisos suficientes para realizar esta acción');
      return ResponseApi();
    }

    ResponseApi responseApi =  ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Envioment.API_URL_OLD, '/api/users/createImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Envioment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async{
    Response response = await post(
        '$url/login',
        {
          'email': email,
          "password": password
        },
        headers: {
          'Content-Type': 'application/json'
        });

    if(response.body == null){
      Get.snackbar('Error', 'Ocurrio un error al momento de iniciar sesión');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
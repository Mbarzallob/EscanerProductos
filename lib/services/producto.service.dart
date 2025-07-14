import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:identificador_productos/models/ProductInfo.dart';

class ProductService{
  static Future<ProductInfo> uploadImage(XFile imagen) async {
    final String fileName = imagen.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imagen.path,
        filename: fileName,
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });

    Dio dio = Dio();
    var url = "http://172.20.10.11:8000/api/products/";
    return dio.post(url, data: formData, options: Options(
      validateStatus: (status){
        return status != null && status <500;
      }
    ))
        .then((response) {
          if(response.statusCode== 404){
            throw "No se encontro el producto";
          }
          var jsonResponse = jsonDecode(response.toString());
          return ProductInfo.fromJson(jsonResponse);
        });
  }
}
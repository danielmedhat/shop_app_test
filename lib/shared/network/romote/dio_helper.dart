import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  
  static inti() {
    
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      
    ));
  }
  
  static Future<Response> getDta(
    
      { Map<String, dynamic>? query,
          String? token,
       required String url}) async {
        
        dio!.options.headers = {
      'Authorization':token,
      'Content-Type': 'application/json'

    };
    return await dio!.get(
      url,
      queryParameters: query,
      
    );
  }

  static Future<Response> postData(
      {required Map<String, dynamic> data,
      String? token,
      Map<String, dynamic>? query,
      required String url}) async {
    dio!.options.headers = {
      'Authorization':token,
      'Content-Type': 'application/json'

    };
    return await dio!.post(
      url,
      data: data,
    );
  }
}

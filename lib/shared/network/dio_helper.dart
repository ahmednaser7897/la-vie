import 'package:dio/dio.dart';
import 'package:le_vie_app/shared/network/end_points.dart';


class DioHelper{
  static late Dio dio;
   static inti(){
   /*  dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.headers["Access-Control-Allow-Credentials"] = true;
    dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    dio.options.headers["Access-Control-Allow-Methods"] =
        "POST, GET, OPTIONS, PUT, DELETE, HEAD"; */
     dio=Dio(
      BaseOptions(
      baseUrl: BASEURL,
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
  "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD"
  }
      )
    ); 
  }
  static Future<Response> getData({
    required String url,
    Options ?options,
    Map<String, dynamic> ?querys,
    String ?token
   })async{
    dio.options.headers ={
    if(token!=null)
    'Authorization':token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    };
   
    return await dio.get(url,queryParameters: querys ,options: options);
  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic> ?query,
    Options ?options,
    String ?token,
    required Map<String, dynamic> data,
    })async{
    dio.options.headers ={
    if(token!=null)
    'Authorization':token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    };
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.headers["Access-Control-Allow-Credentials"] = true;
    dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    dio.options.headers["Access-Control-Allow-Methods"] =
        "POST,";
    return await dio.post(url,queryParameters: query,data:data, options:options );
  }
  static Future<Response> patchData({
    required String url,
    Map<String, dynamic> ?query,
    Options ?options,
    String ?token,
    required Map<String, dynamic> data,
    })async{
    dio.options.headers ={
    if(token!=null)
    'Authorization':token,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    };
    return await dio.patch(url,queryParameters: query,data:data, options:options );
  }

  static Future<Response> putData(
    {required String url,
    Map<String, dynamic> ?query,
    required Map<String, dynamic> data,
    String lang='en',
    String ?token
    })async{
      dio.options.headers ={
        'lang':lang,
        'Authorization':token??"",
        'Content-Type':'application/json'
     };
      return await dio.put(url,queryParameters: query,data: data);
  }
}


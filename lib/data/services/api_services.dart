import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class ApiServices {
 late Dio dio;
 ApiServices(){
   BaseOptions options = BaseOptions(
     baseUrl: baseUrl,
     receiveDataWhenStatusError: true,
     connectTimeout:const Duration(seconds: 20),
     receiveTimeout: const Duration(seconds: 20),
   );
   dio = Dio(options);
 }

  Future<Map<String, dynamic>> getAllCharacters() async {
    Response response = await dio.get('$baseUrl/character');
    return response.data;
  }
  
}
import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';


final dio = Dio();

class CommonService {
  String baseUrl = ServiceConfig.baseUrl;

  PhoneStorage storage = PhoneStorage();

  uploadFile(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/file/uploadImage",data:data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }

  }
}
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pro_23/model/user/user_data_model.dart';
import '../service/storage_service.dart';

class UserRepository {
  UserRepository();
  final Dio dio = Dio();

  final StorageService storage = Get.find<StorageService>();

  Future<(UserDataModel?, String?)> getUserPage({
    int page = 0,
    int size = 10,
    String? username,
    String? nickName,
    bool? published,
  }) async {
    try {
      final Response<dynamic> response = await dio.get(
        'https://flutter-api.janrent.com/api/users',
        queryParameters: <String, dynamic>{
          'sortBy': 'username',
          'direction': 'asc',
          'page': page,
          'size': size,
        },
      );

      print('========== GET USERS ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('================================');

      print('========== GET USERS ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('================================');


      final Map<String, dynamic> json =
      Map<String, dynamic>.from(response.data as Map);

      return (
      UserDataModel.fromJson(json),
      null,
      );

      return (UserDataModel.fromJson(json), null);
    } on DioException catch (e) {
      print('========== GET POSTS ERROR ==========');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      print('REQUEST: ${e.requestOptions.uri}');
      print('======================================');

      return (
      null,
      e.response?.data?['message']?.toString() ??
          e.message ??
          'Request failed',
      );
    } catch (e) {
      print('GET USERS ERROR: $e');

      return (null, e.toString());
    }
  }
}
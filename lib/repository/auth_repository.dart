import 'package:dio/dio.dart';

class AuthRepository {
  AuthRepository();

  final Dio dio = Dio();

  Future<(String?, String?)> login({
    required String username,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await dio.post(
        'https://flutter-api.janrent.com/api/auth/login',
        data: <String, dynamic>{'username': username, 'password': password},
      );

      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');

      final Map<String, dynamic> json = Map<String, dynamic>.from(
        response.data as Map,
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        json['data'] as Map,
      );

      final String? token = data['token']?.toString();

      if (token == null || token.isEmpty) {
        return (null, 'Token not found');
      }

      print('TOKEN: $token');

      return (token, null);
    } on DioException catch (e) {
      print('STATUS: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      print('MESSAGE: ${e.message}');

      return (
        null,
        e.response?.data?['message']?.toString() ??
            e.response?.data?['detail']?.toString() ??
            e.message ??
            'Login failed',
      );
    } catch (e) {
      print('ERROR: $e');
      return (null, e.toString());
    }
  }
}

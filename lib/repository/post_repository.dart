import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:pro_23/model/post/post_data_model.dart';

import '../constant/api_constant.dart';
import '../core/util/api_client.dart';
import '../service/storage_service.dart';

class PostRepository {
  PostRepository(this._api);

  final Dio dio = Dio();
  final ApiClient _api;

  final StorageService storage = Get.find<StorageService>();

  // =========================
  // Get Posts
  // =========================

  Future<(PostDataModel?, String?)> getPageTest({
    int page = 0,
    int size = 10,
    String? title,
    bool? published,
  }) async {
    try {
      final response = await _api.get(
        ApiConstant.posts,
        query: {
          'page': page,
          'size': size,
          'sortBy': 'createdAt',
          'direction': 'desc',
          if (title != null && title.isNotEmpty) 'title': title,
          if (published != null) 'published': published,
        },
      );

      return (PostDataModel.fromJson(response), null);

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
      print('GET POSTS ERROR: $e');

      return (null, e.toString());
    }
  }

  // =========================
  // Create Post
  // =========================

  Future<(Data?, String?)> createPost({
    required String title,
    required String content,
    required bool published,
  }) async {
    try {
      // =========================
      // Get Token
      // =========================

      final String? token = await storage.getString('token');

      print('========== CREATE POST ==========');
      print('TOKEN EXISTS: ${token != null}');
      print('TOKEN: ${token != null ? token : 'NULL'}');

      // =========================
      // Check Token
      // =========================

      if (token == null || token.isEmpty) {
        return (null, 'Token not found');
      }

      // =========================
      // POST Request
      // =========================

      final Response<dynamic> response = await dio.post(
        'https://flutter-api.janrent.com/api/posts',

        // Request Body
        data: <String, dynamic>{
          'title': title,
          'content': content,
          'published': published,
        },

        // Request Headers
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // =========================
      // Debug Request
      // =========================

      print('========== REQUEST ==========');
      print('URL: ${response.requestOptions.uri}');
      print('METHOD: ${response.requestOptions.method}');
      print('HEADERS: ${response.requestOptions.headers}');
      print('BODY: ${response.requestOptions.data}');
      print('==============================');

      // =========================
      // Debug Response
      // =========================

      print('========== RESPONSE ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('==============================');

      // =========================
      // Check Status

      //fix Created
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json =
        Map<String, dynamic>.from(response.data as Map);

        final Map<String, dynamic> postJson =
        Map<String, dynamic>.from(json['data'] as Map);

        final Data data = Data.fromJson(postJson);

        print('CREATED POST ID: ${data.id}');
        print('CREATED POST TITLE: ${data.title}');
        print('CREATED POST CONTENT: ${data.content}');

        return (data, null);
      }

      return (null, 'Create post failed: ${response.statusCode}');
    }
    // =========================
    // Dio Error
    // =========================
    on DioException catch (e) {
      print('========== DIO ERROR ==========');

      print('TYPE: ${e.type}');

      print('MESSAGE: ${e.message}');

      print('STATUS: ${e.response?.statusCode}');

      print('RESPONSE: ${e.response?.data}');

      print('REQUEST: ${e.requestOptions.uri}');

      print('METHOD: ${e.requestOptions.method}');

      print('HEADERS: ${e.requestOptions.headers}');

      print('BODY: ${e.requestOptions.data}');

      print('================================');

      return (
        null,
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Request failed',
      );
    }
    // =========================
    // Other Error
    // =========================
    catch (e) {
      print('========== ERROR ==========');

      print(e);

      print('============================');

      return (null, e.toString());
    }
  }

  // =========================
// Update Post
// =========================

  Future<(Data?, String?)> updatePost({
    required int id,
    required String title,
    required String content,
    required bool published,
  }) async {
    try {
      final String? token = await storage.getString('token');

      if (token == null || token.isEmpty) {
        return (null, 'Token not found');
      }

      print('========== UPDATE POST ==========');
      print('ID: $id');
      print('TITLE: $title');
      print('CONTENT: $content');
      print('PUBLISHED: $published');

      final Response<dynamic> response = await dio.put(
        'https://flutter-api.janrent.com/api/posts/$id',

        data: <String, dynamic>{
          'title': title,
          'content': content,
          'published': published,
        },

        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('========== UPDATE RESPONSE ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('=====================================');

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        final Map<String, dynamic> json =
        Map<String, dynamic>.from(
          response.data as Map,
        );

        final Map<String, dynamic> postJson =
        Map<String, dynamic>.from(
          json['data'] as Map,
        );

        final Data data = Data.fromJson(postJson);

        print('UPDATED POST ID: ${data.id}');
        print('UPDATED POST TITLE: ${data.title}');

        return (data, null);
      }

      return (
      null,
      'Update post failed: ${response.statusCode}',
      );
    } on DioException catch (e) {
      print('========== UPDATE DIO ERROR ==========');
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
      print('========== UPDATE ERROR ==========');
      print(e);
      print('==================================');

      return (null, e.toString());
    }
  }

  // =========================
// Delete Post
// =========================

  Future<(bool, String?)> deletePost({
    required int id,
  }) async {
    try {
      final String? token = await storage.getString('token');

      if (token == null || token.isEmpty) {
        return (false, 'Token not found');
      }

      print('========== DELETE POST ==========');
      print('ID: $id');

      final Response<dynamic> response = await dio.delete(
        'https://flutter-api.janrent.com/api/posts/$id',
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('========== DELETE RESPONSE ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('======================================');

      if (response.statusCode == 200 ||
          response.statusCode == 204) {
        return (true, null);
      }

      return (
      false,
      'Delete post failed: ${response.statusCode}',
      );
    } on DioException catch (e) {
      print('========== DELETE DIO ERROR ==========');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      print('REQUEST: ${e.requestOptions.uri}');
      print('======================================');

      return (
      false,
      e.response?.data?['message']?.toString() ??
          e.message ??
          'Request failed',
      );
    } catch (e) {
      print('========== DELETE ERROR ==========');
      print(e);
      print('==================================');

      return (false, e.toString());
    }
  }

  // =========================
// Upload Post Image
// =========================

  Future<(bool, String?)> uploadPostImage({
    required int postId,
    required String filePath,
  }) async {
    try {
      final String? token = await storage.getString('token');

      if (token == null || token.isEmpty) {
        return (false, 'Token not found');
      }

      print('========== UPLOAD POST IMAGE ==========');
      print('=======================================');

      final String fileName = filePath.split('/').last;

      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });


      final Response<dynamic> response = await dio.post(
        'https://flutter-api.janrent.com/api/posts/$postId/image',
        data: formData,
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('========== IMAGE RESPONSE ==========');
      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');
      print('====================================');

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return (true, null);
      }

      return (
      false,
      'Image upload failed: ${response.statusCode}',
      );
    } on DioException catch (e) {
      print('========== IMAGE UPLOAD ERROR ==========');
      print('TYPE: ${e.type}');
      print('MESSAGE: ${e.message}');
      print('STATUS: ${e.response?.statusCode}');
      print('RESPONSE: ${e.response?.data}');
      print('REQUEST: ${e.requestOptions.uri}');
      print('=========================================');

      return (
      false,
      e.response?.data?['message']?.toString() ??
          e.message ??
          'Image upload failed',
      );
    } catch (e) {
      print('========== IMAGE ERROR ==========');
      print(e);
      print('=================================');

      return (false, e.toString());
    }
  }
}

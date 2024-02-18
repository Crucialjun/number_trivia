import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';


import 'package:logger/logger.dart';
import 'package:number_trivia/core/api_response.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/services/network_service/auth_interceptor.dart';

import 'i_network_service.dart';
import 'network_logger.dart';

class NetworkService extends INetworkService {
  Dio _dio = Dio();
  final _logger = Logger();

  final _headers = {'Accept': 'application/json'};

  NetworkService() {
    _dio = Dio();
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.sendTimeout = const Duration(seconds: 60);
    _dio.interceptors.addAll([AuthInterceptor(), NetworkLoggerInterceptor()]);
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> delete(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.delete(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> get(String url,
      {Map<String, String>? headers}) async {
    _logger.i("received url is $url");
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.get(
        url,
        options: Options(
            headers: _headers, method: 'GET', responseType: ResponseType.plain),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: json.decode(res.data));
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> put(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.put(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: res.data);
      }
      throw Failure(message: res.statusMessage!, extraData: res.toString());
    } on DioException catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    _logger.i("received url is $url");
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      Logger().i("Set data: $body");
      final res = await _dio.post(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        _logger.d("Response: ${res.data}");
        return ApiResponse(data: jsonDecode(res.data));
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> postFile(
      {required String url,
      required String key,
      required File file,
      Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        key: await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final res = await _dio.post(
        url,
        data: formData,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse(data: json.decode(res.data));
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertException(e);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }

  Failure convertException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const Failure(message: "Connection Timed Out");
      case DioExceptionType.sendTimeout:
        return const Failure(message: "Connection Timed Out");
      case DioExceptionType.receiveTimeout:
        return const Failure(message: "Connection Timed Out");
      case DioExceptionType.badResponse:
        return Failure(
            message: e.response?.data['message'] ?? e.response?.data['errors']);
      case DioExceptionType.cancel:
        return Failure(
            message: e.response?.data['message'] ?? e.response?.data['errors']);
      case DioExceptionType.unknown:
        return const Failure(message: "No Internet Connection");
      default:
        return const Failure(message: "No Internet Connection");
    }
  }
}

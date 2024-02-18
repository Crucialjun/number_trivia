import 'dart:io';

import 'package:number_trivia/core/api_response.dart';


abstract class INetworkService {
  Future<ApiResponse<Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> postFile(
      {required String url,
      required String key,
      required File file,
      Map<String, String>? headers});

  Future<ApiResponse<Map<String, dynamic>>> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<ApiResponse<Map<String, dynamic>>> delete(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });
}

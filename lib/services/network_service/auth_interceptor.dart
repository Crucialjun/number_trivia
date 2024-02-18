import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /*
    if (err.response?.data['message'] == 'Unauthenticated') {
      final navigationService = locator<INavigationService>();
      final dialogAndSheetService = locator<IDialogAndSheetService>();
      _logOut();
      navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
      dialogAndSheetService.showAppDialog(
        const StatusDialog(
          isError: true,
          title: "Session Expired",
          body: "Kindly log in again.",
        ),
      );
    }
    */
    handler.reject(err);
  }

  Future<void> _logOut() async {
    
  }

  @override
  FutureOr<dynamic> onResponse(Response response, handler) async {
    var res = Map.castFrom(jsonDecode(response.data.toString()));
    if (res['message'] == 'SESSION_OUT') {
      await _logOut();
    
      
    }
    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onRequest(RequestOptions options, handler) async {
   
    return handler.next(options);
  }
}

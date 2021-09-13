import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:phonebuyertask/utils/const/api_endpoint.dart';
import 'res_base_model.dart';

class ApiService {
  Dio? _dio;
  String tag = "API call :";
  CancelToken? _cancelToken;
  static final Dio mDio = Dio();

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    mDio.options.contentType = 'application/json';
    return _instance;
  }

  ApiService._internal() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();

    final baseOption = BaseOptions(
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
      baseUrl: apiBaseUrl,
      contentType: 'application/json',
      headers: {},
    );
    mDio.options = baseOption;

    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint("$tag queryParameters ${options.queryParameters.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag headers ${options.headers.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.baseUrl.toString() + options.path}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.data.toString()}", wrapWidth: 1024);
        handler.next(options);
      },
      onResponse: (response, handler) async {
        debugPrint("Code  ${response.statusCode.toString()}", wrapWidth: 1024);
        debugPrint("Response ${response.toString()}", wrapWidth: 1024);
        handler.next(response);
      },
      onError: (e, errorHandler) async {
        debugPrint("$tag ${e.error.toString()}", wrapWidth: 1024);
        debugPrint("$tag ${e.response.toString()}", wrapWidth: 1024);
        errorHandler.next(e);
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null
        ? _cancelToken?.cancel('Cancelled')
        : cancelToken.cancel();
  }

  Future<Response> get(
    String endUrl, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      return await (_dio!.get(
        endUrl,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      rethrow;
    }
  }

  Future<Response> post(
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }

      return await (_dio!.post(
        endUrl,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      rethrow;
    }
  }

  Future<Response> put(
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }

      return await (_dio!.put(
        endUrl,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      rethrow;
    }
  }

  Future<Response> delete(
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await (_dio!.delete(
        endUrl,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError {
      rethrow;
    }
  }

  Future<Response> multipartPost(
    String endUrl, {
    FormData? data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await (_dio!.post(
        endUrl,
        data: data,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      ));
    } on DioError {
      rethrow;
    }
  }

  Future<Response> postFormData(
    String endUrl, {
    FormData? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      return await (_dio!.post(endUrl,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken ?? _cancelToken,
          options: options));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(ResBaseModel(
            message:
                "Internet not connected, Please check your network connection",
            success: false));
      }
      rethrow;
    }
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

import 'package:dio/dio.dart';
import 'package:laporan_check_apps/utils/end_points.dart';
import 'package:laporan_check_apps/utils/extention.dart';
import 'package:laporan_check_apps/utils/pref.dart';

import 'logger.dart';

class ApiBaseHelper {
  ApiBaseHelper() : dio = createDio();

  ApiBaseHelper.withToken() : dio = createDioWithToken();

  // static final String _baseUrl = Prefs().url;
  static const String _baseUrl = EndPoints.baseUrl;

  String get baseUrl => _baseUrl;

  /// custom to log everytime (true) or only when error found (false)
  bool isLog = true;

  /// helper to change map to params
  String mapToParams(Map<String, dynamic>? map) {
    return '?' + Uri(queryParameters: map).query;
  }

  final Dio dio;

  static BaseOptions opts = BaseOptions(
    baseUrl: _baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDioWithToken() {
    return Dio(opts)
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          // place token here
          var token = Prefs().token;
          if (token?.isEmpty ?? true) throw 'Token unavailable';
          options.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return handler.next(e); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        },
      ));
  }

  static Dio createDio() {
    return Dio(opts);
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      checkError(response.data, url: url, header: response.headers);
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  Future<dynamic> getWithoutStatus(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      checkError(response.data, url: url, header: response.headers, body: data);
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      checkError(response.data, url: url, header: response.headers, body: data);
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  Future<dynamic> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      Response response = await dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      checkError(response.data, url: url, header: response.headers, body: data);
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      if (isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: header,
            ),
      );
      checkError(response.data, url: url, header: response.headers, body: data);
      if (isLog) {
        logOutput(response.data);
      }
      return response.data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput(dioError.message,
          error: dioError.error, response: dioError.response);
      await handleErrorStatusCode(
          statusCode: dioError.response?.statusCode,
          data: dioError.response?.data);
      throw '${dioError.response?.statusCode} : ${dioError.message}'
          .checkServer();
    } catch (e, trace) {
      if (!isLog) {
        logInput(_baseUrl + url,
            queryParameters: queryParameters, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString().checkServer();
    }
  }

  checkError(dynamic data, {dynamic url, dynamic header, dynamic body}) {
    if (data['status'] == false) {
      throw data['message'] ?? data['data']?['message'] ?? 'Failed';
    }
  }

  logInput(dynamic url,
      {dynamic queryParameters, dynamic header, dynamic body}) {
    logger.d(url);
    if (queryParameters != null) logger.d(queryParameters);
    if (header != null) logger.d(header);
    if (body != null) logger.d(body);
  }

  logOutput(dynamic message, {dynamic error, dynamic trace, dynamic response}) {
    logger.d(message);
    if (error != null && error.toString() != message.toString())
      logger.d(error);
    if (trace != null) logger.d(trace);
    if (response != null) logger.d(response);
  }

  Future<void> handleErrorStatusCode({dynamic statusCode, dynamic data}) async {
    if (data != null) {
      if (data['status'] == false) {
        throw data['message'] ?? data['data']?['message'] ?? 'Failed';
      }
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:amazing_tv/core/resources/constants_manager.dart';
import 'package:dio/dio.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Header {
  // static Map<String, String> get userAuth => {
  //   'User-Cookie': User.fromLocalJson(json.decode(injector<SharedPreferences>().getString('userInfo')!)).cookie!.split('|').sublist(1).join('|').trim(),
  //   'Content-Type': 'application/json',
  //
  // };

  static Map<String, String> get noAuth => {
        'Content-Type': 'application/json',
      };
}

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (i) => true,
        responseType: ResponseType.plain,
      ),
    );

    dio.interceptors.add(CustomInterceptors());
  }

  static Future<ResponseModel> getData({
    required String url,
    Map<String, dynamic>? query,
  }) {
    return _request(url: url, requesType: RequestType.get, query: query);
  }

  static Future<ResponseModel> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) {
    return _request(
      url: url,
      requesType: RequestType.post,
      query: query,
      data: data,
    );
  }

  static Future<ResponseModel> _request({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    RequestType requesType = RequestType.get,
  }) async {
    Response? response;

    // url +=injector<SharedPreferences>().containsKey("language_code")
    //     ? '&lang='+injector<SharedPreferences>().getString('language_code').toString()
    //     : '&lang=en';
    try {
      switch (requesType) {
        case RequestType.post:
          response = await dio.post(
            url,
            queryParameters: query,
            data: json.encode(data),
            options: Options(
              headers: Header.noAuth,
            ),
          );
          break;

        case RequestType.put:
          response = await dio.put(
            url,
            queryParameters: query,
            data: json.encode(data),
            options: Options(
              headers: Header.noAuth,
            ),
          );
          break;

        case RequestType.delete:
          response = await dio.delete(
            url,
            queryParameters: query,
            options: Options(
              headers: Header.noAuth,
            ),
          );
          break;

        case RequestType.get:
        default:
          response = await dio.get(
            url,
            queryParameters: query,
            options: Options(
              headers: Header.noAuth,
            ),
          );
          break;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseModel(
          statusCode: response.statusCode!,
          data: jsonDecode(response.data),
          success: true,
        );
      } else {
        return ResponseModel(
          statusCode: response.statusCode ?? 400,
          data: jsonDecode(response.data),
          success: false,
        );
      }
    } catch (e) {
      return ResponseModel(
        statusCode: response?.statusCode ?? 500,
        success: false,
      );
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST:: ${options.uri} and Body::${options.data}');
    log('Header:: ${options.headers}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE:: Status code is: ${response.statusCode} response is: ${jsonDecode(response.data)}');

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR::$err');
    return handler.next(err);
  }
}

class ResponseModel {
  ResponseModel({
    this.success,
    this.messageEn,
    this.messageAr,
    this.data,
    this.statusCode,
  });

  bool? success;
  String? messageEn;
  String? messageAr;
  dynamic data;
  int? statusCode;

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json["Success"],
        messageEn: json["MessageEN"],
        messageAr: json["MessageAR"],
        data: json["Data"],
        statusCode: json["StatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "MessageEN": messageEn,
        "MessageAR": messageAr,
        "Data": data,
        "StatusCode": statusCode,
      };
}

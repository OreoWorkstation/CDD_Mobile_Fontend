import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: SERVER_API_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = Dio(options);
  }

  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String accessToken = Global.accessToken;
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  /// restful GET
  Future get(
    String path, {
    // @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    // requestOptions = requestOptions.merge(extra: {
    //   "context": context,
    // });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }

    var response =
        await dio.get(path, queryParameters: params, options: requestOptions);
    return response;
  }

  /// restful post 操作
  Future post(
    String path, {
    // @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    // requestOptions = requestOptions.merge(extra: {
    //   "context": context,
    // });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response;
  }

  /// restful put 操作
  Future put(
    String path, {
    // @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    // requestOptions = requestOptions.merge(extra: {
    //   "context": context,
    // });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.put(path, data: params, options: requestOptions);
    return response;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    // @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    // requestOptions = requestOptions.merge(extra: {
    //   "context": context,
    // });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response =
        await dio.delete(path, data: params, options: requestOptions);
    return response;
  }
}

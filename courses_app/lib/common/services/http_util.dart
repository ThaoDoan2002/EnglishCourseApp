import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/common/widgets/popup_messages.dart';
import 'package:dio/dio.dart';

import '../../global.dart';

class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    // dio.options.receiveTimeout = 10000 as Duration?;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        ErrorEntity eInfo = createErrorEntity(e);
        onError(eInfo);
        return handler.next(e); // Đảm bảo thông báo lỗi được xử lý
      },
    ));
  }

  Map<String, dynamic>? getAuthorizationHeader() {

    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getString(AppConstants.STORAGE_USER_TOKEN_KEY);
    print('-----------access___________--token--- $accessToken');
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  // Phương thức GET
  Future get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    // Thêm header Authorization nếu có
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    try {
      var response = await dio.get(path,
          queryParameters: queryParameters, options: requestOptions);
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e) {
      throw createErrorEntity(e as DioException);
    }
  }

  Future post(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        bool isFormData = false,
      }) async {
    Options requestOptions = options ?? Options();
    if (isFormData) {
      requestOptions.contentType = 'multipart/form-data';
    }
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    try {
      var response = await dio.post(
        path,
        data: FormData.fromMap(data ?? {}),
        queryParameters: queryParameters,
        options: requestOptions,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e) {
      print('Error occurred: $e');
      throw createErrorEntity(e as DioException);
    }
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception code $code, $message";
  }
}

// Thay đổi tại đây để kiểm tra mã 400 và trả về các key-value
createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificate");

    case DioExceptionType.badResponse:
      if (error.response!.statusCode == 400) {
        var responseData = error.response!.data;
        if (responseData is Map<String, dynamic>) {
          // Lấy ra thông báo lỗi từ các key
          List<String> messages = [];
          responseData.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              messages.add(value.first); // Lấy thông báo đầu tiên từ danh sách
            }
          });
          // Chuyển đổi danh sách thông báo thành chuỗi
          String errorMessage = messages.join(' '); // Nối các thông báo bằng dấu phẩy

          // Gọi toastInfo ở đây
          toastInfo(errorMessage);
          return ErrorEntity(code: 400, message: errorMessage);
        }
      }
      return ErrorEntity(code: error.response!.statusCode ?? -1, message: "Server bad response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {
  print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
  switch (eInfo.code) {
    case 400:
    // Bạn có thể bỏ qua toastInfo ở đây nếu đã gọi trong createErrorEntity
      print("Server syntax error");
      break;
    case 401:
      print("You are denied to continue");
      break;
    case 500:
      print("Internal server error");
      break;
    default:
      toastInfo("Unknown error");
      print("Unknown error");
      break;
  }
}